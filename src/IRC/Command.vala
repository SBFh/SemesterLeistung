using Daemon.Helpers;

namespace Daemon.IRC
{
	public errordomain CommandError
	{
		Invalid
	}
	
	public enum CommandTypes
	{
		User,
		Nick,
		PrivMsg,
		Pass,
		Server,
		Oper,
		Quit,
		SQuit,
		Join,
		Part,
		Mode,
		Topic,
		Names,
		List,
		Invite,
		Kick,
		Version,
		Stats,
		Links,
		Time,
		Connect,
		Trace,
		Admin,
		Info,
		Notice,
		Who,
		WhoIs,
		WhoWas,
		Kill,
		Ping,
		Pong,
		Error;
		
		public string ToString()
		{
			EnumClass enumClass = (EnumClass)typeof(CommandTypes).class_ref();
			
			return enumClass.get_value((int)this).value_nick.up();
		}
		
		public static CommandTypes Parse(string input) throws CommandError
		{
			EnumClass enumClass = (EnumClass)typeof(CommandTypes).class_ref();
			EnumValue[] values = enumClass.values;
			
			string down = input.down();
			
			for (int i = 0; i < values.length; i++)
			{
				if (values[i].value_nick.down() == down)
				{
					return (CommandTypes)values[i].value;
				}
			}
			
			throw new CommandError.Invalid("Could not parse Command %s", input);
		}
	}

	public class Command : Object
	{
		public string? Prefix { get; private set; default = null; }
		public string? Name { get; private set; default = null; }
		public string[] Parameters { get; private set; }
		public int? Code { get; private set; default = null; }
		
		public Entity? Sender { get; private set; default = null; }
		public Entity? Receiver { get; private set; default = null; }
		
		public Entity[] Receivers { get; private set; default = new Entity[0]; }
	
		public CommandTypes Type { get; private set; }
	
		public Command(CommandTypes type, string[] parameters)
		{
			this.WithPrefix(null, type, parameters);
		}
		
		private Command.Numeric(string? prefix, int code, string[] parameters)
		{
			Code = code;
			Prefix = prefix;
			Parameters = parameters;
			
			InitEntities();
		}
		
		public Command.WithPrefix(string? prefix, CommandTypes type, string[] parameters)
		{
			Type = type;
			Prefix = prefix;
			Name = type.ToString();
			Parameters = parameters;
			
			InitEntities();
		}
		
		private void InitEntities()
		{
			if (Prefix != null)
			{
				try
				{
					Sender = Entity.Parse(Prefix);
				}
				catch
				{
					Sender = null;
				}
			}
			
			if (Parameters != null && Parameters.length > 0)
			{
				string[] receivers = Parameters[0].split(",");
				
				List<Entity> receiverList = new List<Entity>();
				
				bool receiverSet = false;
				
				for (int i = 0; i < receivers.length; i++)
				{
					try
					{
						Entity receiver = Entity.Parse(receivers[i].strip());
						receiverList.append(receiver);
						if (!receiverSet)
						{
							receiverSet = true;
							Receiver = receiver;
						}						
					}
					catch (EntityError error)
					{

					}
				}
				ListHelper<Entity> helper = new ListHelper<Entity>();
				Receivers = helper.CopyList(receiverList);
			}
		}
		
		public string ToString()
		{
			StringBuilder builder = new StringBuilder();
			
			builder.append("{ \n\t");
			builder.append("Command: ");
			builder.append(Name ?? Code.to_string());
			
			if (Prefix != null)
			{
				builder.append(",\n\t");
				builder.append("Prefix: ");
				builder.append(Prefix);
			}
			
			if (Parameters != null && Parameters.length > 0)
			{
				builder.append(",\n\t");
				builder.append("Parameters:");
				builder.append("\n\t[\n\t\t");
				
				for (int i = 0; i < Parameters.length; i++)
				{
					builder.append(Parameters[i]);
					if (i < Parameters.length - 1)
					{
						builder.append(",\n\t\t");
					}
				}
				
				builder.append("\n\t]");
			}
			
			if (Sender != null)
			{
				builder.append(",\n\t");
				builder.append("Sender: ");
				builder.append(Sender.ToString());
			}
			
			if (Receivers != null && Receivers.length != 0)
			{
				builder.append(",\n\t");
				builder.append("Receivers:");
				builder.append("\n\t[\n\t\t");
				
				for (int i = 0; i < Receivers.length; i++)
				{
					builder.append(Receivers[i].ToString());
					if (i < Receivers.length - 1)
					{
						builder.append(",\n\t\t");
					}
				}
				
				builder.append("\n\t]");
			}
			
			builder.append("\n}");
		
			return builder.str;
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
					if (Parameters[i].contains(" "))
					{
						builder.append(":");
					}
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
					
					trailBuilder.append(parts[i].substring(1));
					if (i + 1 < parts.length - 1)
					{
						trailBuilder.append(" ");
					}
					
					for (int j = i + 1; j < parts.length; j++)
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
			
			if (name.length == 3 && TypeHelper.IsNumeric(name))
			{
				return new Command.Numeric(prefix, int.parse(name), parameters);
			}
			
			CommandTypes commandType = CommandTypes.Parse(name);
			
			return new Command.WithPrefix(prefix, commandType, parameters);
		}
	}
}
