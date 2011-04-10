namespace Daemon.Helpers
{
	public errordomain DaemonError
	{
		ParseFailed
	}

	public static class TypeHelper : Object
	{
	
		public static uint16? ParsePort(string text)
		{
			string input = text.strip();
		
			if (input.length == 0 || !IsNumeric(input))
			{
				return null;
			}
			
			int port = int.parse(input);
			if (port < 0 || port < uint16.MIN || port > uint16.MAX)
			{
				return null;
			}
			
			return (uint16)port;
		}
		
		public static void ParseHostAndPort(string input, out string host, out uint16? port) throws DaemonError
		{
			string[] parts = input.split(":");
			
			if (parts.length > 2)
			{
				throw new DaemonError.ParseFailed("Invalid host");
			}
			
			host = parts[0].strip();
			if (host.length == 0)
			{
				throw new DaemonError.ParseFailed("Invalid host");
			}
			
			if (parts.length == 2)
			{
				port = ParsePort(parts[1]);
				if (port == null)
				{
					throw new DaemonError.ParseFailed("Could not parse port");
				}
			}
		}
	
		public static string IndentString(string text, int count)
		{
			string[] parts = text.split("\n");
			string prefix = string.nfill(count, '\t');
			
			for (int i = 0; i < parts.length; i++)
			{
				parts[i] = prefix + parts[i];
			}
			
			return string.joinv("\n", parts);
		}
	
		public static bool IsNumeric(string text)
		{
			for (int i = 0; i < text.length; i++)
			{
				if (!text[i].isalnum())
				{
					return false;
				}
			}
			
			return true;
		}
	}
}
