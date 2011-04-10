using Daemon.Helpers;

namespace Daemon
{
	public errordomain SmtpError
	{
		InvalidConfiguration
	}
	
	public enum EncryptionTypes
	{
		None = 0,
		SSL = 1,
		TLS = 2
	}

	public class SmtpConfiguration : Object
	{
		public SmtpConfiguration(string sender, string host, uint16 port)
		{
			Sender = sender;
			Host = host;
			Port = port;
		}
		
		public string Sender { get; private set; }
		public string Host { get; private set; }
		public uint16 Port { get; private set; }
		
		public string ToString()
		{
			StringBuilder builder = new StringBuilder();
			
			builder.append("{\n\t");
			builder.append("Host: ");
			builder.append(Host);
			
			builder.append(",\n\t");
			builder.append("Port: ");
			builder.append(Port.to_string());
			
			builder.append(",\n\t");
			builder.append("Sender: ");
			builder.append(Sender);
			
			builder.append("\n}");
			
			return builder.str;
		}

		public static SmtpConfiguration Parse(string input) throws SmtpError
		{
			string[] parts = input.split("/");
			
			if (parts.length != 2)
			{
				throw new SmtpError.InvalidConfiguration("Invalid configuration string");
			}
			
			string sender = parts[0].strip();
			
			if (sender.length == 0)
			{
				throw new SmtpError.InvalidConfiguration("Invalid configuration string");
			}
			
			string host;
			uint16? port;
			
			try
			{
				TypeHelper.ParseHostAndPort(parts[1], out host, out port);
			}
			catch (DaemonError error)
			{
				throw new SmtpError.InvalidConfiguration(error.message);
			}
			
			port = port ?? 25;
			
			return new SmtpConfiguration(sender, host, port);
		}
	}
}
