namespace Daemon.IRC
{
	public errordomain EntityError
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
		
		public string ToString()
		{
			StringBuilder builder = new StringBuilder();
			
			builder.append("{ Name: ");
			builder.append(Name);
			
			if (RealName != null)
			{
				builder.append(", Real Name: ");
				builder.append(RealName);
			}
			
			if (Host != null)
			{
				builder.append(", Host: ");
				builder.append(Host);
			}
			
			builder.append(" }");
			
			return builder.str;
		}
	
		public static Entity Parse(string text) throws EntityError
		{
			string input = text.strip();
			
			if (input.length == 0)
			{
				throw new EntityError.InvalidFormat("User empty");
			}
			
			string name = input;
			string? realName = null;
			string? host = null;
			
			if (input.contains("!"))
			{
				string[] nameParts = input.split("!");
				name = nameParts[0].strip();
				
				if (nameParts.length > 1)
				{
					realName = nameParts[1];
					
					if (realName.contains("@"))
					{
						string[] hostParts = realName.split("@");
						
						realName = hostParts[0].strip();
						
						if (hostParts.length > 1)
						{
							host = hostParts[1].strip();
						}
					}
					
					if (realName.length > 0 && realName[0] == '~')
					{
						realName = realName.substring(1);
					}
				}
			}
			
			return new Entity(name, realName, host);
		}
	}
}
