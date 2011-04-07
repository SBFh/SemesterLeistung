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
	
		public IRCConnection(string fullHost) throws IRCError
		{
			string[] hostParts = fullHost.split(":");
			
			string host;
			uint16 port = 6667;
			
			if (hostParts.length == 2)
			{
				host = hostParts[0];
				try
				{
					port = (uint16)int.parse(hostParts[1]);
				}
				catch
				{
					throw new IRCError.InvalidHost("Could not parse Port");
				}
			}
			else if (hostParts.length > 2)
			{
				throw new IRCError.InvalidHost("Invalid Host Format");
			}
			else
			{
				host = fullHost;
			}
		
			Host = host;
			Port = port;
			
			Resolver resolver = Resolver.get_default();
			
			List<InetAddress> addresses;
			
			try
			{
				addresses = resolver.lookup_by_name(host);
			}
			catch (Error error)
			{
				throw new IRCError.DNSError(error.message);
			}
			
			if (addresses.length() == 0)
			{
				throw new IRCError.DNSError("No IP found for " + host);
			}

			Address = addresses.nth_data(0);
			
			Endpoint = new InetSocketAddress(Address, Port);
			
			try
			{
				_connectionThread = Thread.create<void*>(StartConnection, true);
			}
			catch (ThreadError error)
			{
				throw new IRCError.ThreadError(error.message);
			}
		}
		
		private unowned Thread<void*> _connectionThread;
		
		void* StartConnection()
		{
			Connect();
			
			return null;
		}
		
		public void Join()
		{
			_connectionThread.join();
		}
		
		public string Host { get; private set; }

		public uint16 Port { get; private set; }
		
		public InetAddress Address { get; private set; }
		
		public InetSocketAddress Endpoint { get; private set; }
		
		private SocketConnection _socket;
		
		private void Connect()
		{
			_connection = new SocketClient();
			_connection.set_protocol(SocketProtocol.TCP);
			_connection.set_timeout(60);
			
			try
			{
				_socket = _connection.connect(Endpoint);
			}
			catch
			{
				Reconnect(_reconnectTime);
				return;
			}
			
			_socket.get_socket().set_keepalive(true);
			
			if (_socket != null)
			{
				Connected();
			}
			else
			{
				Reconnect(_reconnectTime);
			}
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
			print("Connected");
		}
		
		private void Disconnected()
		{
			print("Disconnected");
			Reconnect(0);
		}
	}
}
