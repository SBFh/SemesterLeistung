using Daemon.Configuration;

namespace Daemon.IRC
{
	public errordomain IRCError
	{
		InvalidHost,
		DNSError,
		ThreadError
	}

	public class IRCConnection : Object
	{
		private SocketClient _connection;
	
		public ServerConfiguration ServerConfiguration { get; private set; }
		
		private unowned Thread<void*> _connectionThread;
		
		public string Host { get; private set; }

		public uint16 Port { get; private set; }
		
		public InetAddress Address { get; private set; }
		
		public InetSocketAddress Endpoint { get; private set; }
		
		private SocketConnection _socket;
		
		private DataInputStream _inputStream;
		
		private IOChannel _channel;
		
		private List<Channel> _channels = new List<Channel>();
		
		private string _nickname;
	
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
			
			try
			{
				_connectionThread = Thread.create<void*>(StartConnection, true);
			}
			catch (ThreadError error)
			{
				throw new IRCError.ThreadError(error.message);
			}
		}
		
		void* StartConnection()
		{
			Connect();
			
			return null;
		}
		
		public void Join()
		{
			_connectionThread.join();
		}
		
		private int _lastFd;
		
		private void Connect()
		{
			_channels = new List<Channel>();
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
			_sentLogin = false;
			
			GlobalLog.ColorMessage(ConsoleColors.Green, "Successfully connected to Server: %s", ServerConfiguration.Name);
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
		
		bool _sentLogin = false;
		
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
		
		private void ReceivedCommand(Command command)
		{
			ConsoleColors color = command.Code != null ? ConsoleColors.Purple : ConsoleColors.Blue;
			GlobalLog.ColorMessage(color, "@%s Received\n%s", ServerConfiguration.Name, command.ToString());
			
			if (!_sentLogin)
			{
				_sentLogin = true;
				QueueCommand(new Command(CommandTypes.User, new string[] { "Simon", "localhost", "localhost", "Simon" }));
				QueueCommand(new Command(CommandTypes.Nick, new string[] { "Simon" }));
				QueueCommand(new Command(CommandTypes.Join, new string[] { "#main" }));
			}
			
		}
	}
}
