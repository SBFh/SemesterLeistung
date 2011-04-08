namespace Daemon.IRC
{
	public errordomain UserError
	{
		InvalidFormat
	}

	public class Entity : Object
	{
	
		public string Name { get; private set; }
		
		public string? RealName { get; private set; }
		
		public string? Host { get; private set; }
		
		private Entity(string name, string? realName, string? host)
		{
			Name = name;
			RealName = realName;
			Host = host;
		}
	
		public static Entity Parse(string text) throws UserError
		{
			string input = text.strip();
			
			if (input.length == 0)
			{
				throw new UserError.InvalidFormat("User empty");
			}
			
			return new Entity("rofl", "rofl", "rofl");
			
		}
	}
}
