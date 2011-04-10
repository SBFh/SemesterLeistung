namespace Daemon
{
	public errordomain EmailError
	{
		ServerFailed,
		InvalidEmail,
		Critical,
		DNSError
	}

	public class EmailSender
	{
		private SocketClient _connection;
		private SocketConnection _socket;
		private DataInputStream _inputStream;
	
		public static SmtpConfiguration Configuration { get; set; }
	
		public void SendEmail(string receiver, string subject, string body) throws EmailError
		{
			SocketClient client = new SocketClient();
			Resolver resolver = Resolver.get_default();
			
			List<InetAddress> addresses;
			
			try
			{
				addresses = resolver.lookup_by_name(Configuration.Host);
			}
			catch (Error error)
			{
				throw new EmailError.DNSError(error.message);
			}
			
			if (addresses.length() == 0)
			{
				throw new EmailError.DNSError("No IP found for " + Configuration.Host);
			}
			
			InetAddress address = addresses.nth_data(0);
			
			InetSocketAddress endpoint = new InetSocketAddress(address, Configuration.Port);
			
			_connection = new SocketClient();
			_socket = _connection.connect(endpoint);
			_inputStream = new DataInputStream(_socket.input_stream);
			
			string localAddress = ((InetSocketAddress)_socket.get_local_address()).get_address().to_string();
			
			Read();
			Write("HELO " + localAddress + "\r\n");
			Read();
			Write("MAIL FROM: ");
			Write(Configuration.Sender);
			Write("\r\n");
			Read();
			Write("VRFY ");
			Write(Configuration.Sender);
			Write("\r\n");
			Read();
			Write("RCPT TO: ");
			Write(receiver);
			Write("\r\n");
			Read();
			Write("DATA\r\n");
			Write("Subject: ");
			Write(subject + "\r\n");
			Read();
			Write(body + "\r\n");
			Write(".\r\n");
			Read(); 
			Write("QUIT\r\n");
			Read();
		}
		
		private void Read()
		{
			size_t size;
			string read = _inputStream.read_line(out size);
		}
		
		private void Write(string text)
		{
			_socket.output_stream.write(text.data, null);
		}
	}
}
