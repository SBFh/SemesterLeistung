namespace Daemon.IRC
{
	public class IRCConnection : Object
	{
		private SocketClient _connection;
	
		public IRCConnection(string host, uint16 port)
		{
			Host = host;
			Port = port;
			
			Resolver resolver = Resolver.get_default();
			
			List<InetAddress> addresses = resolver.lookup_by_name(host);

			Address = addresses.nth_data(0);
			
			Endpoint = new InetSocketAddress(Address, Port);
			
			Connect();
		}
		
		public string Host { get; private set; }

		public uint16 Port { get; private set; }
		
		public InetAddress Address { get; private set; }
		
		public InetSocketAddress Endpoint { get; private set; }
		
		private SocketConnection _socket;
		
		private void Connect()
		{
			_connection = new SocketClient();
			
			_socket = _connection.connect(Endpoint);
			
			if (_socket != null)
			{
				_socket.socket.notify.disconnect(Disconnected);
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
