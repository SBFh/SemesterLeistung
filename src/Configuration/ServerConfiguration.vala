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
			
			string[] hostParts = parts[0].split(":");
			
			if (hostParts.length > 2)
			{
				throw new ConfigurationError.Invalid("Invalid Server format");
			}
			
			string host = hostParts[0];
			uint16 port = 6667;
			
			if (hostParts.length == 2)
			{
				
				int inputPort;
			
				if ((inputPort = int.parse(hostParts[1])) == 0)
				{
					throw new ConfigurationError.Invalid("Could not parse Port");
				}

				if (inputPort < 0 || inputPort < uint16.MIN || inputPort > uint16.MAX)
				{
					throw new ConfigurationError.Invalid("Port out of range");
				}
			
				port = (uint16)inputPort;
			}

			return new ServerConfiguration(host, port, channels);
		}
		
		private const string _stringFormat = "Host: %s\nPort: %i\nChannels: %s\nName: %s";
		
		public string ToString()
		{
			return _stringFormat.printf(Host, Port, string.joinv(", ", Channels), Name);
		}
	}
}
