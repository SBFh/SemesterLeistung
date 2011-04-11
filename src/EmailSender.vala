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

namespace Daemon
{
	public errordomain EmailError
	{
		ServerFailed,
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
			
			string localAddress;
			
			try
			{
				_socket = _connection.connect(endpoint);
				_inputStream = new DataInputStream(_socket.input_stream);
			
				localAddress = ((InetSocketAddress)_socket.get_local_address()).get_address().to_string();

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
			catch (Error error)
			{
				throw new EmailError.ServerFailed(error.message);
			}
			
			GlobalLog.ColorMessage(ConsoleColors.Green, "Successfully sent E-Mail with subject '%s' to '%s', body:", subject, receiver);
			GlobalLog.ColorMessage(ConsoleColors.Cyan, body);
		}
		
		private void Read() throws IOError
		{
			size_t size;
			_inputStream.read_line(out size);
		}
		
		private void Write(string text) throws IOError
		{
			_socket.output_stream.write(text.data, null);
		}
	}
}
