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

using Daemon.Helpers;

namespace Daemon.IRC
{
	public errordomain CommandError
	{
		Invalid
	}
	
	public enum Codes
	{
		Invalid = -1,
		NoSuckNick = 401,
		NoSuchServer = 402,
		NoSuchChannel = 403,
		CannotSendToChannel = 404,
		TooManyChannels = 405,
		WasNoSuckNick = 406,
		TooManyTargets = 407,
		NoOrigin = 409,
		NoRecipient = 411,
		NoTextToSend = 412,
		NoTopLevel = 413,
		WildTopLevel = 414,
		UnknownCommand = 421,
		NoMOTD = 422,
		NoAdminInfo = 423,
		FileError = 424,
		NoNicknameGiven = 431,
		ErroneusNickname = 432,
		NicknameInUse = 433,
		NickCollision = 436,
		UserNotInChannel = 441,
		NotOnChannel = 442,
		UserOnChannel = 443,
		NoLogin = 444,
		SummonDisabled = 445,
		UserDisabled = 446,
		NotRegistered = 451,
		NeedMoreParameters = 461,
		AlreadyRegistered = 462,
		NoPermissionForHost = 463,
		PasswordMismatch = 464,
		BannedFromServer = 465,
		KeySet = 467,
		ChannelIsFull = 471,
		UnknownMode = 472,
		InviteOnlyChannel = 473,
		BannedFromChannel = 474,
		BadChannelKey = 475,
		PermissionDenied = 481,
		ChannelOperatorPrivilegesNeeded = 482,
		CannotKillServer = 483,
		NoOperatorHost = 491,
		UnknownModeFlag = 501,
		UsersDontMatch = 502,
		None = 300,
		Away = 301,
		UserHost = 302,
		Ison = 303,
		UnAway = 305,
		NoAway = 306,
		WhoIsUser = 311,
		WhoIsServer = 312,
		WhoIsOperator = 313,
		WhoIsIdle = 317,
		EndOfWhoIs = 318,
		WhoIsChannels = 319,
		WhoWasUser = 314,
		EndOfWhoWas = 369,
		ListStart = 321,
		List = 322,
		ListEnd = 323,
		ChannelModeIs = 324,
		NoTopic = 331,
		Topic = 332,
		Inviting = 341,
		Summoning = 342,
		Version = 351,
		WhoReply = 352,
		EndOfWho = 315,
		NameReply = 353,
		EndOfNames = 366,
		Links = 364,
		EndOfLinks = 365,
		BanList = 367,
		EndOfBanList = 368,
		Info = 371,
		EndOfInfo = 374,
		MOTDStart = 375,
		MOTD = 372,
		EndOfMOTD = 376,
		YoureOperator = 381,
		Rehasing = 382,
		Time = 391,
		UsersStart = 392,
		Users = 393,
		EndOfUsers = 394,
		NoUsers = 395,
		TraceLink = 200,
		TraceConnecting = 201,
		TraceHandshake = 202,
		TraceUnknown = 203,
		TraceOperator = 204,
		TraceUser = 205,
		TraceServer = 206,
		TraceNewType = 208,
		TraceLog = 261,
		StatsLinkInfo = 211,
		StatsCommands = 212,
		StatsCLine = 213,
		StatsNLine = 214,
		StatsSILine = 215,
		StatsKLine = 216,
		StatsYLine = 218,
		EndOfStats = 219,
		StatsSLineReply = 241,
		StatsUptime = 242,
		StatsOLine = 243,
		StatsHLine = 244,
		UserModeIs = 221,
		LUserClient = 251,
		OperatorsOnline = 252,
		UnknownUsers = 253,
		UserChannels = 254,
		UserMe = 255,
		AdminMe = 256,
		AdminLoc1 = 257,
		AdminLoc2 = 258,
		AdminEmail = 259;
		
		public string ToString()
		{
			EnumClass enumClass = (EnumClass)typeof(Codes).class_ref();
			
			return enumClass.get_value((int)this).value_nick.up();
		}
		
		public static Codes FromInt(int code) throws CommandError
		{
			EnumClass enumClass = (EnumClass)typeof(Codes).class_ref();

			foreach (EnumValue current in enumClass.values)
			{
				if (current.value == code)
				{
					return (Codes)code;
				}
			}

			throw new CommandError.Invalid("Code not valid");
		}
	}
	
	public enum CommandTypes
	{
		Invalid,
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
		public Codes Code { get; private set; default = Codes.Invalid; }
		
		public Entity? Sender { get; private set; default = null; }
		public Entity? Receiver { get; private set; default = null; }
		
		public Entity[] Receivers { get; private set; default = new Entity[0]; }
	
		public CommandTypes Type { get; private set; default = CommandTypes.Invalid; }
	
		public Command(CommandTypes type, string[] parameters)
		{
			this.WithPrefix(null, type, parameters);
		}
		
		private Command.Numeric(string? prefix, Codes code, string[] parameters)
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
			
			if (Code != Codes.Invalid)
			{
				builder.append("Code: ");
				builder.append(Code.ToString());
			}
			else
			{
				builder.append("Command: ");
				builder.append(Name);
			}
			
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
				try
				{
					int code = int.parse(name);
					Codes actualCode = Codes.FromInt(code);
					return new Command.Numeric(prefix, actualCode, parameters);
				}
				catch
				{
					throw new CommandError.Invalid("Invalid Code: %s", name);				
				}
			}
			
			CommandTypes commandType = CommandTypes.Parse(name);
			
			return new Command.WithPrefix(prefix, commandType, parameters);
		}
	}
}
