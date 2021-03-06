/*SemesterLeistung - An IRC Daemon
* Copyright (C) 2011  Simon Baumer
* 
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
* 
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.*/

using Daemon.Configuration;
using Daemon.Data;
using Daemon.Events;

namespace Daemon.IRC
{
	public errordomain IRCError
	{
		InvalidHost,
		DNSError//,
		//ThreadError
	}

	public class IRCConnection : Object
	{
		public static string RealName { get; set; }
		public static string[] Nicknames { get; set; }
		public static string Hostname { get; set; }
		public static string Username { get; set; }
	
		private SocketClient _connection;
	
		public ServerConfiguration ServerConfiguration { get; private set; }
		
//		private unowned Thread<void*> _connectionThread;
		
		public string Host { get; private set; }

		public uint16 Port { get; private set; }
		
		public InetAddress Address { get; private set; }
		
		public InetSocketAddress Endpoint { get; private set; }
		
		private SocketConnection _socket;
		
		private DataInputStream _inputStream;
		
		private IOChannel _channel;
		
		private List<string> _channels = new List<string>();
		
		private List<string> _pendingChannels = new List<string>();
	
		public IRCConnection(ServerConfiguration configuration) throws IRCError
		{
			ServerConfiguration = configuration;
			
			Resolver resolver = Resolver.get_default();
			
			List<InetAddress> addresses;
			
			try
			{
				addresses = resolver.lookup_by_name(configuration.Host);
			}
			catch (Error error)
			{
				throw new IRCError.DNSError(error.message);
			}
			
			if (addresses.length() == 0)
			{
				throw new IRCError.DNSError("No IP found for " + configuration.Host);
			}

			Address = addresses.nth_data(0);
			
			Endpoint = new InetSocketAddress(Address, configuration.Port);
			
			/*try
			{
				_connectionThread = Thread.create<void*>(StartConnection, true);
			}
			catch (ThreadError error)
			{
				throw new IRCError.ThreadError(error.message);
			}*/
			Connect();
		}
		
		/*void* StartConnection()
		{
			Connect();
			
			return null;
		}
		
		public void Join()
		{
			_connectionThread.join();
		}*/
		
		private int _lastFd;
		
		private void Connect()
		{
			_authComplete = false;
		
			_nickIndex = 0;
			_nickSuffix = "";
			
			_currentNick = null;
			_lastNick = null;
			
			_channels = new List<string>();
			_pendingChannels = new List<string>();
			
			_connection = new SocketClient();
			_connection.set_protocol(SocketProtocol.TCP);
			_connection.set_timeout(60);
			
			try
			{
				_socket = _connection.connect(Endpoint);
				_inputStream = new DataInputStream(_socket.input_stream);
			}
			catch
			{
				GlobalLog.Warning("Failed to connect to Server %s", ServerConfiguration.Name);
				Reconnect(_reconnectTime);
				return;
			}
			
			_socket.socket.set_keepalive(true);

			Connected();
			
			if (_socket.socket.fd != _lastFd)
			{
				_lastFd = _socket.socket.fd;
				
				if (_channel != null)
				{
					try
					{
						_channel.shutdown(false);
					}
					catch
					{
					
					}
					_channel = null;
				}
				
				_channel = new IOChannel.unix_new(_socket.socket.fd);

				_channel.add_watch(IOCondition.IN | IOCondition.OUT | IOCondition.HUP | IOCondition.ERR | IOCondition.PRI | IOCondition.NVAL, InputWatch);
			
				_channel.init();
			}
			
		}
		
		private const int _reconnectTime = 5;
		
		private List<Command> _waitingCommands = new List<Command>();
		
		private void Reconnect(int wait)
		{
			Thread.usleep(wait * 1000000);
			GlobalLog.Warning("Trying to reconnect to Server %s", ServerConfiguration.Name);
			Connect();
		}
		
		private void Connected()
		{
			GlobalLog.ColorMessage(ConsoleColors.Green, "Successfully connected to Server: %s", ServerConfiguration.Name);
			SendNickname();
			Auth();
		}
		
		private void Disconnected()
		{
			try
			{
				_socket.socket.shutdown(true, true);
			}
			catch
			{
			
			}
			_socket.socket.dispose();
			try
			{
				_socket.close();
			}
			catch
			{
			
			}
			_socket.dispose();
			_connection.dispose();
			GlobalLog.Warning("Disconnected from Server: %s", ServerConfiguration.Name);
			Reconnect(0);
		}
		
		private void SendCommand(Command command)
		{
			string prepared = command.Prepare() + "\r\n";
			try
			{
				_socket.output_stream.write(prepared.data);
			}
			catch
			{
				Disconnected();
				return;
			}
			GlobalLog.ColorMessage(ConsoleColors.Yellow, "@%s Sent\n%s", ServerConfiguration.Name, command.ToString());
		}
		
		private void QueueCommand(Command command)
		{
			_waitingCommands.append(command);
		}
		
		private void Receive(IOChannel source)
		{
			string receivedText;
			
			IOStatus status;
			
			try
			{
				status = source.read_line(out receivedText, null, null);
			}
			catch
			{
				status = IOStatus.ERROR;
			}
			
			if (status == IOStatus.EOF || status == IOStatus.ERROR)
			{
				Disconnected();
				return;
			}

			Command receivedCommand = null;
			
			try
			{
				receivedCommand = Command.Parse(receivedText);
			}
			catch (CommandError error)
			{
				GlobalLog.Warning("@%s - Could not understand command '%s", ServerConfiguration.Name, receivedText);
				return;
			}
			
			if (receivedCommand != null)
			{
				ReceivedCommand(receivedCommand);
			}
		}
		
		public bool InputWatch(IOChannel source, IOCondition condition)
		{
			if ((condition & IOCondition.ERR) == IOCondition.ERR)
			{
				GlobalLog.Error("@%s - Connection Error", ServerConfiguration.Name);
				if (_socket.is_closed())
				{
					Disconnected();
				}
				return true;
			}
			if ((condition & IOCondition.NVAL) == IOCondition.NVAL || (condition & IOCondition.HUP) == IOCondition.HUP)
			{
				Disconnected();
				return true;
			}
		
			if ((condition & IOCondition.OUT) == IOCondition.OUT)
			{
				if (_waitingCommands.length() > 0)
				{
					Command commandToSend = _waitingCommands.nth_data(0);
					_waitingCommands.remove(commandToSend);
					SendCommand(commandToSend);
				}
			}
			if ((condition & IOCondition.PRI) == IOCondition.PRI || (condition & IOCondition.IN) == IOCondition.IN)
			{
				Receive(source);
			}
			
			return true;
		}
		
		int _nickIndex = 0;
		string _nickSuffix = "";
		string? _lastNick = null;
		
		string? _currentNick = null;
		
		bool _authComplete = false;
		
		private void SendNickname()
		{
			if (_nickIndex >= Nicknames.length)
			{
				_nickIndex = 0;
				_nickSuffix += "_";
			}
			
			_lastNick = Nicknames[_nickIndex] + _nickSuffix;
			
			QueueCommand(new Command(CommandTypes.Nick, new string[] { _lastNick }));
			
			_nickIndex++;
		}
		
		private void Auth()
		{
			QueueCommand(new Command(CommandTypes.User, new string[] { Username, Hostname, ServerConfiguration.Host, RealName }));
		}
		
		private void JoinChannel(string name)
		{
			_pendingChannels.append(name);
			QueueCommand(new Command(CommandTypes.Join, new string[] { name }));
		}
		
		[PrintfFormat]
		private void SendMessage(Entity target, string format, ...)
		{
			string message = format.vprintf(va_list());
			
			string[] messageLines = message.split("\n");
			
			foreach (string current in messageLines)
			{
				QueueCommand(new Command(CommandTypes.PrivMsg, new string[] { target.Name, current }));			
			}

		}
		
		private void ReceivedCommand(Command command)
		{
			ConsoleColors color = command.Code != Codes.Invalid ? ConsoleColors.Purple : ConsoleColors.Blue;
			GlobalLog.ColorMessage(color, "@%s Received\n%s", ServerConfiguration.Name, command.ToString());
			
			ProcessCommand(command);
			ProcessCode(command);
			
			if (_authComplete && _currentNick != null)
			{
				foreach (string channel in ServerConfiguration.Channels)
				{
					if (!InChannel(channel) && !IsChannelPending(channel))
					{
						JoinChannel(channel);
					}
				}
			}
		}
		
		private bool InChannel(string name)
		{
			foreach (string current in _channels)
			{
				if (current == name)
				{
					return true;
				}
			}
			return false;
		}
		
		private bool IsChannelPending(string name)
		{
			foreach (string current in _pendingChannels)
			{
				if (current == name)
				{
					return true;
				}
			}
			return false;
		}
		
		private void ProcessCommand(Command command)
		{
			switch (command.Type)
			{
				case CommandTypes.Ping:
				{
					QueueCommand(new Command(CommandTypes.Pong, new string[0]));
					break;
				}
				case CommandTypes.PrivMsg:
				{
					foreach (Entity receiver in command.Receivers)
					{
						if (receiver.Name == _currentNick)
						{
							ProcessMessage(command.Sender, command.Parameters[1]);
						}
						else
						{
							if (InChannel(receiver.Name))
							{
								try
								{
									IRCLog.Log(new MessageEvent(command.Sender.Name, command.Parameters[1], receiver.Name, ServerConfiguration.Name));
								}
								catch (DataAccessError error)
								{
									GlobalLog.Error(error.message);
									break;
								}
							}
						}
					}
					break;
				}
				case CommandTypes.Nick:
				{
					if (command.Sender.Name == _currentNick)
					{
						break;
					}
					else
					{
						try
						{
							IRCLog.Log(new ChangeNameEvent(command.Sender.Name, command.Receiver.Name, "!global", ServerConfiguration.Name));
						}
						catch (DataAccessError error)
						{
							GlobalLog.Error(error.message);
							break;
						}
					}
					break;
				}
				case CommandTypes.Join:
				{
					if (command.Sender.Name == _currentNick)
					{
						_channels.append(command.Parameters[0]);
						_pendingChannels.remove(command.Parameters[0]);
					}
					else
					{
						try
						{
							IRCLog.Log(new StatusEvent(command.Sender.Name, StatusChange.Join, command.Parameters[0], ServerConfiguration.Name));
						}
						catch (DataAccessError error)
						{
							GlobalLog.Error(error.message);
							break;
						}
					}
					break;
				}
				case CommandTypes.Part:
				{
					if (command.Sender.Name == _currentNick)
					{
						_channels.remove(command.Parameters[0]);
					}
					else
					{
						try
						{
							IRCLog.Log(new StatusEvent(command.Sender.Name, StatusChange.Leave, command.Parameters[1], ServerConfiguration.Name));
						}
						catch (DataAccessError error)
						{
							GlobalLog.Error(error.message);
							break;
						}
					}
					break;
				}
			}
		}
		
		private void ProcessCode(Command command)
		{
			switch (command.Code)
			{
				case Codes.NicknameInUse:
				case Codes.NickCollision:
				{
					SendNickname();
					return;
				}
				case Codes.LUserClient:
				{
					_currentNick = command.Parameters[0];
					_authComplete = true;
					break;
				}
			}
		}
		
		private void SendUnavailable(Entity receiver)
		{
			SendMessage(receiver, "Currently unavailable, try again in a few minutes");
		}
		
		private void ProcessMessage(Entity sender, string message)
		{
			string[] parts = message.split(" ");
			
			switch(parts[0])
			{
				case "LASTSEEN":
				{
					string otherUser = "";
					string channel = "";
					if (parts.length != 3 || (channel = parts[1].strip()).length == 0 || (otherUser = parts[2].strip()).length == 0)
					{
						SendMessage(sender, "LASTSEEN requires exactly two parameter: The Channels and the Users name");
						break;
					}
					
					DateTime? lastSeen;
					
					try
					{
						lastSeen = PluginManager.DataAccess.UserLastSeen(otherUser, channel, ServerConfiguration.Name);
					}
					catch (DataAccessError error)
					{
						SendUnavailable(sender);
						break;
					}
					
					if (lastSeen == null)
					{
						SendMessage(sender, "I have never seen User %s on Channel %s", otherUser, channel);
						break;
					}
					
					SendMessage(sender, "The last time user %s did something on Channel %s was at %s", otherUser, channel, lastSeen.format("%x %X"));
					
					break;
				}
				case "SENDLOG":
				{
					string channel = "";
					string email = "";
					if (parts.length != 3 || (channel = parts[1].strip()).length == 0 || (email = parts[2].strip()).length == 0)
					{
						SendMessage(sender, "SENDLOG requires exactly two parameter: The Channels name and a E-Mail address");
						break;
					}
					
					List<LogEvent> log = new List<LogEvent>();
					
					try
					{
						log = PluginManager.DataAccess.GetLog(channel, ServerConfiguration.Name);
					}
					catch (DataAccessError error)
					{
						SendUnavailable(sender);
					}
					
					StringBuilder builder = new StringBuilder();
					
					builder.append("Starting log for channel %s on server %s\n\n".printf(channel, ServerConfiguration.Name));
					
					foreach (LogEvent current in log)
					{
						builder.append(current.ToString());
						builder.append("\n");
					}
					
					builder.append("\nEND OF LOG");
					
					EmailSender emailSender = new EmailSender();
					
					try
					{
						emailSender.SendEmail(email, "Log for channel %s".printf(channel), builder.str);
					}
					catch (EmailError error)
					{
						SendMessage(sender, "Could not send E-Mail to %s, might be a wrong address?", email);
						break;
					}
					
					SendMessage(sender, "Great success!");
					
					break;
				}
				default:
				{
					NotUnderstood(sender);
					break;
				}
			}
		}
		
		private const string _helpString =
		"""This bot can only understand the following Commands:
		LASTSEEN <CHANNEL> <USERNAME>
		SENDLOG <CHANNEL> <EMAIL>""";
		
		private void NotUnderstood(Entity sender)
		{
			SendMessage(sender, _helpString);
		}
	}
}
