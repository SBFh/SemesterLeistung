using Daemon.Helpers;

namespace Daemon.IRC
{
	public errordomain CommandError
	{
		Invalid
	}

	public class Command : Object
	{
		public string? Prefix { get; private set; default = null; }
		public string Name { get; private set; }
		public string[] Parameters { get; private set; }
	
		public Command(string name, string[] parameters)
		{
			this.WithPrefix(null, name, parameters);
		}
		
		public Command.WithPrefix(string? prefix, string name, string[] parameters)
		{
			Prefix = prefix;
			Name = name;
			Parameters = parameters;
		}
		
		private const string _stringFormat = "Command: %s - Parameters: %s";
		private const string _stringFormatWithPrefix = "Command: %s - Prefix: %s - Parameters: %s";
		
		public string ToString()
		{
			string parametersString = string.joinv(", ", Parameters);
			
			if (Prefix != null)
			{
				return _stringFormatWithPrefix.printf(Name, Prefix, parametersString);
			}
			else
			{
				return _stringFormat.printf(Name, parametersString);
			}
		}
		
		public string Prepare()
		{
			StringBuilder builder = new StringBuilder();
			
			if (Prefix != null)
			{
				builder.append(":");
				builder.append(Prefix);
			}
			
			builder.append(" ");
			builder.append(Name);
			
			if (Parameters.length > 0)
			{
				builder.append(" ");
				for (int i = 0; i < Parameters.length; i++)
				{
					builder.append(Parameters[i]);
					if (i < Parameters.length - 1)
					{
						builder.append(" ");
					}
				}
			}
			
			return builder.str;
		}
	
		public static Command Parse(string text) throws CommandError
		{
			string input = text;
			input = input.strip();
			
			if (input.length == 0)
			{
				throw new CommandError.Invalid("Empty Command");
			}
		
			string[] parts = input.split(" ");
			if (parts.length == 0)
			{
				throw new CommandError.Invalid("Empty Command");
			}
			
			int offset = 0;
			
			string? prefix = null;
			string name;
			string[] parameters;
			
			if (parts[0][0] == ':')
			{
				prefix = parts[0].strip().substring(1);
				offset = 1;
			}
			
			if (offset >= parts.length)
			{
				throw new CommandError.Invalid("No Command found");
			}
			
			name = parts[offset].strip();
			
			offset++;
			
			List<string> parametersList = new List<string>();
			
			for (int i = offset; i < parts.length; i++)
			{
				if (parts[i][0] == ':')
				{
					StringBuilder trailBuilder = new StringBuilder();
					for (int j = i; j < parts.length; j++)
					{
						trailBuilder.append(parts[j].strip());
						if (j < parts.length - 1)
						{
							trailBuilder.append(" ");
						}
					}
					parametersList.append(trailBuilder.str);
					break;
				}
				parametersList.append(parts[i].strip());
			}
			
			ListHelper<string> helper = new ListHelper<string>();
			
			parameters = helper.CopyList(parametersList);
			
			return new Command.WithPrefix(prefix, name, parameters);
		}
	}
}
