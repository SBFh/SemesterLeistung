using Daemon.Configuration;

namespace Daemon.IRC
{
	errordomain IRCError
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
		
		private void Connect()
		{
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
				Reconnect(_reconnectTime);
				return;
			}
			
			_socket.socket.set_keepalive(true);

			Connected();
			
			_channel = new IOChannel.unix_new(_socket.socket.fd);
			
			_channel.add_watch(IOCondition.IN, InputWatch);
		}
		
		private const int _reconnectTime = 5;
		
		private void Reconnect(int wait)
		{
			if (_socket != null)
			{
				_socket.dispose();
				_socket = null;
			}
			if (_connection != null)
			{
				_connection.dispose();
				_connection = null;
			}
			Thread.usleep(wait * 1000000);
			Connect();
		}
		
		private void Connected()
		{
			_sentLogin = false;
			
			GlobalLog.ColorMessage(ConsoleColors.Green, "Successfully connected to Server: %s", ServerConfiguration.Name);
		}
		
		private void Disconnected()
		{
			GlobalLog.Warning("Disconnected from Server: %s", ServerConfiguration.Name);
			Reconnect(0);
		}
		
		bool _sentLogin = false;
		
		private void ReceivedCommand(Command command)
		{
			GlobalLog.ColorMessage(ConsoleColors.Blue, "@%s Received - %s", ServerConfiguration.Name, command.ToString());
			if (!_sentLogin)
			{
				_sentLogin = true;
				SendCommand(new Command("USER", new string[] { "Simon", "localhost", "localhost", "Simon" }));
				SendCommand(new Command("NICK", new string[] { "LolBot" }));
			}
		}
		
		private void SendCommand(Command command)
		{
			string prepared = command.Prepare();
			_socket.output_stream.write_async(prepared.data, prepared.length);
			GlobalLog.ColorMessage(ConsoleColors.Yellow, "@%s Sent - %s", ServerConfiguration.Name, command.ToString());
//			_channel.write_chars(prepared, null);
		}
		
		public bool InputWatch(IOChannel source, IOCondition condition)
		{
			string receivedText;
			
			source.read_line(out receivedText, null, null);

			Command receivedCommand = null;
			
			try
			{
				receivedCommand = Command.Parse(receivedText);
			}
			catch (CommandError error)
			{
				GlobalLog.Warning("@%s - Could not understand command '%s", ServerConfiguration.Name, receivedText);
				return true;
			}
			
			if (receivedCommand != null)
			{
				ReceivedCommand(receivedCommand);
			}
			
			return true;
		}
	}
}
