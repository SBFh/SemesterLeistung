using Daemon.Helpers;

namespace Daemon.Configuration
{
	public class ServerConfiguration : Object
	{
		public ServerConfiguration(string host, uint16 port, string[] channels)
		{
			Host = host;
			Port = port;
			Channels = channels;
			Name = Host + ":" + Port.to_string();
		}
		
		public string Host { get; private set; }
		public uint16 Port { get; private set; }
		public string[] Channels { get; private set; }
		public string Name { get; private set; }
	
		public static ServerConfiguration Parse(string input) throws ConfigurationError
		{
			string[] parts = input.split("/");
			
			if (parts.length != 2)
			{
				throw new ConfigurationError.Invalid("Invalid format");
			}
			
			if (parts[0].length == 0 || parts[1].length == 0)
			{
				throw new ConfigurationError.Invalid("Must specify both Server and Channel(s)");
			}
			
			string[] channels = parts[1].split(",");
			
			string host;
			uint16? port;
			
			try
			{
				TypeHelper.ParseHostAndPort(parts[0], out host, out port);
			}
			catch (DaemonError error)
			{
				throw new ConfigurationError.Invalid(error.message);
			}
			
			port = port ?? 6667;

			return new ServerConfiguration(host, port, channels);
		}
		
		public string ToString()
		{
			StringBuilder builder = new StringBuilder();
			
			builder.append("{\n\t");
			builder.append("Host: ");
			builder.append(Host);
			builder.append(",\n\t");
			builder.append("Port: ");
			builder.append(Port.to_string());
			
			if (Channels != null && Channels.length > 0)
			{
				builder.append(",\n\tChannels:\n\t[");
				builder.append("\n\t\t");
				
				for (int i = 0; i < Channels.length; i++)
				{
					builder.append(Channels[i]);
					if (i < Channels.length - 1)
					{
						builder.append(",\n\t\t");
					}
				}
				
				builder.append("\n\t]");
			}
			
			builder.append("\n}");
			
			return builder.str;
		}
	}
}
