using Daemon.IRC;
using Daemon.Data;
using Daemon.Events;
using Daemon.Configuration;
using Daemon.Helpers;

namespace Daemon
{
	public class Main : Object
	{
		public static string? LogLibrary = null;

		public static string? LogFile = null;
		
		public static string? ConfigFile = null;
		
		public static bool DisableDaemon = false;
		
		[CCode (array_length = false, array_null_terminated = true)]
    [NoArrayLength]
		public static string[] Servers;

		public static string? Nicknames = null;
		
		public static bool IgnoreConfig = false;
		
		public static bool OverrideValues = false;
		
		public static string? RealName = null;
		
		public static string? Host = null;
		
		public static string? Username = null;
		
		public static string? Smtp = null;

		private const OptionEntry[] _options = 
		{
 			{
 				"logger", 
 				'l', 
 				0, 
 				OptionArg.FILENAME, 
 				ref LogLibrary,
 				"Specifies which Log Library is going to be used. Defaults to the build-in Sqlite3 Library.", 
 				null 
			},
 			{
 				"logfile", 
 				'f', 
 				0, 
 				OptionArg.FILENAME, 
 				ref LogFile,
 				"Path to the Log File.", 
 				null 
			},
 			{
 				"config", 
 				'c', 
 				0, 
 				OptionArg.FILENAME, 
 				ref ConfigFile,
 				"Path to the configuration file.", 
 				null 
			},
 			{
 				"disable-daemon", 
 				'D', 
 				0, 
 				OptionArg.NONE, 
				ref DisableDaemon,
 				"Disable the Daemon functionality.", 
 				null 
			},
 			{
 				"servers", 
 				's', 
 				0, 
 				OptionArg.STRING_ARRAY, 
				ref Servers,
 				"Specify the Servers and Channels to use. Use format: 'host(:port)/channel{,channel}'", 
 				null 
			},
 			{
 				"ignore-config", 
 				'i', 
 				0, 
 				OptionArg.NONE, 
				ref IgnoreConfig,
 				"Ignore all settings from the configuration file.", 
 				null 
			},
 			{
 				"override-config", 
 				'o', 
 				0, 
 				OptionArg.NONE, 
				ref OverrideValues,
 				"Override all Configuration options. Otherwise appends Servers and Nicknames.", 
 				null 
			},
 			{
 				"nick", 
 				'n', 
 				0, 
 				OptionArg.STRING, 
				ref Nicknames,
 				"The Nicknames used by the bot. Comma-Separated.", 
 				null 
			},
 			{
 				"real-name", 
 				'r', 
 				0, 
 				OptionArg.STRING, 
				ref RealName,
 				"The \"Real name\" sent to the IRC Servers.", 
 				null 
			},
 			{
 				"host", 
 				'h', 
 				0, 
 				OptionArg.STRING, 
				ref Host,
 				"Override the hostname sent to the IRC Servers.", 
 				null 
			},
 			{
 				"username", 
 				'u', 
 				0, 
 				OptionArg.STRING, 
				ref Username,
 				"Set the username sent to the IRC Servers.", 
 				null 
			},
			{
				"smtp",
				's',
				0,
				OptionArg.STRING,
				ref Smtp,
				"Set the smtp configuration using the format: 'sender/host(:port)'",
				null
			},
			{ null } 
		}; 

		static int main (string[] args) 
		{
			try
			{
				OptionContext context = new OptionContext("");

				context.set_help_enabled(true);
				context.add_main_entries(_options, null);
				context.parse(ref args);
			}
			catch (Error error)
			{
				stderr.printf("Error: %s\n", error.message); 
				stderr.printf("Run '%s --help' to see a full list of available options\n", args[0]); 
				return 1;
			}
			
			GlobalLog.ColorMessage(ConsoleColors.Blue, "Initializing the Application");
			
			ConfigurationFile configuration = null;
			
			if (IgnoreConfig)
			{				
				if (OverrideValues)
				{
					GlobalLog.Error("Cannot override and ignore Configuration");
					return 1;
				}
				GlobalLog.Warning("Ignoring Configuration File");
			}
			else
			{

				ConfigFile = ConfigFile ?? "/etc/daemon/config.xml";
			
				File configFile = File.new_for_path(ConfigFile);
			
				if (configFile.query_exists())
				{
					GlobalLog.ColorMessage(ConsoleColors.Green, "Using Configuration File: %s", ConfigFile);
				
					try
					{
						configuration = ConfigurationFile.Load(ConfigFile);
					
						GlobalLog.ColorMessage(ConsoleColors.Green, "Successfully loaded Configuration File, settings:");
						GlobalLog.ColorMessage(ConsoleColors.Blue, configuration.ToString());
					}
					catch (ConfigurationError error)
					{
						GlobalLog.Error("Loading Configuration File %s failed: %s", ConfigFile, error.message);
						return 1;
					}
				
				}
				else
				{
					GlobalLog.Warning("Could not open Configuration File: %s", ConfigFile);
				}
			}
			
			if (OverrideValues)
			{
				GlobalLog.Warning("Overriding Configuration");
			}
			
			if (configuration != null)
			{
				LogLibrary = LogLibrary ?? configuration.LogLibrary;
				LogFile = LogFile ?? configuration.LogFile;
				DisableDaemon = DisableDaemon || configuration.DisableDaemon;
			}
			
			if (LogLibrary == null)
			{
				GlobalLog.ColorMessage(ConsoleColors.Green, "Using default log library");
			}
			else
			{
				GlobalLog.ColorMessage(ConsoleColors.Green, "Using log library located at: %s", LogLibrary);
			}
			
			LogFile = LogFile ?? Environment.get_home_dir() + "/data.db";
			
			GlobalLog.ColorMessage(ConsoleColors.Green, "Using Log File at %s", LogFile);
			
			string[] nicknames = new string[0];
			
			if (configuration != null)
			{
				nicknames = configuration.Nicknames;
			}

			if (Nicknames != null && Nicknames.length > 0)
			{
			
				string[] newNicknames = Nicknames.split(",");
				
				if (OverrideValues)
				{
					nicknames = newNicknames;
				}
				else
				{
					ListHelper<string> helper = new ListHelper<string>();
					nicknames = helper.AppendArrays(nicknames, newNicknames);
				}
				
				GlobalLog.ColorMessage(ConsoleColors.Green, "Using these nicknames in this order:");
				
			}
			
			if (nicknames.length == 0)
			{
				GlobalLog.Error("No nicknames specified");
				return 1;
			}
			
			ServerConfiguration[] servers = new ServerConfiguration[0];
			
			if (configuration != null)
			{
				servers = configuration.Servers;
			}
			
			if (Servers != null && Servers.length != 0)
			{
				List<ServerConfiguration> serverList = new List<ServerConfiguration>();
			
				foreach (string current in Servers)
				{
					ServerConfiguration server;
				
					try
					{
						server = ServerConfiguration.Parse(current);
						serverList.append(server);
					}
					catch (ConfigurationError error)
					{
						GlobalLog.Error("Server configuration invalid, reason: %s", error.message);
						return 1;
					}
				}
				
				ListHelper<ServerConfiguration> helper = new ListHelper<ServerConfiguration>();
				
				if (OverrideValues)
				{
					servers = helper.CopyList(serverList);
				}
				else
				{
					servers = helper.AppendList(servers, serverList);
				}
			}
			
			if (servers.length == 0)
			{
				GlobalLog.Error("No servers specified");
				return 1;
			}
			
			if (RealName == null && configuration != null)
			{
				RealName = configuration.RealName;
			}
			
			if (RealName == null || RealName.length == 0)
			{
				GlobalLog.Error("No \"Real Name\" specified");
				return 1;
			}
			
			GlobalLog.ColorMessage(ConsoleColors.Green, "Using \"Real Name\": '%s'", RealName);
			
			IRCConnection.RealName = RealName;
			
			GlobalLog.ColorMessage(ConsoleColors.Green, "Using nicknames:");
			
			StringBuilder nicknameBuilder = new StringBuilder();
			
			nicknameBuilder.append("[\n\t");
			
			for (int i = 0; i < nicknames.length; i++)
			{
				nicknameBuilder.append(nicknames[i]);
				if (i < nicknames.length - 1)
				{
					nicknameBuilder.append(",\n\t");
				}
			}
			
			nicknameBuilder.append("\n]");
			
			GlobalLog.ColorMessage(ConsoleColors.Purple, nicknameBuilder.str);
			
			IRCConnection.Nicknames = nicknames;
			
			string? host = Host;
			
			if (Host == null && configuration != null)
			{
				host = configuration.Host;
			}
			
			if (host != null && host.length == 0)
			{
				GlobalLog.Error("Invalid hostname");
				return 1;
			}
			
			host = host ?? "none";
			
			GlobalLog.ColorMessage(ConsoleColors.Green, "Sending host: %s", host);
			
			IRCConnection.Hostname = host;
			
			string? username = Username;
			
			if (Username == null && configuration != null)
			{
				username = configuration.Username;
			}
			
			if (username == null || username.length == 0)
			{
				GlobalLog.Error("No Username set.");
				return 1;
			}
			
			GlobalLog.ColorMessage(ConsoleColors.Green, "Sending Username: %s", username);
			
			IRCConnection.Username = username;
			
			foreach (ServerConfiguration current in servers)
			{
				GlobalLog.ColorMessage(ConsoleColors.Green, "Using Server:");
				GlobalLog.ColorMessage(ConsoleColors.Purple, current.ToString());
			}
			
			SmtpConfiguration? smtpConfiguration = null;
			
			if (Smtp != null)
			{
				try
				{
					smtpConfiguration = SmtpConfiguration.Parse(Smtp);
				}
				catch (SmtpError error)
				{
					GlobalLog.Error("Could not parse SMTP Configuration: %s", error.message);
				}
			}
			else if (configuration != null)
			{
				smtpConfiguration = configuration.Smtp;
			}
			
			if (smtpConfiguration == null)
			{
				GlobalLog.Error("No SMTP configuration set");
				return 1;
			}
			
			EmailSender.Configuration = smtpConfiguration;
			
			GlobalLog.ColorMessage(ConsoleColors.Green, "Using SMTP Configuration:");
			GlobalLog.ColorMessage(ConsoleColors.Purple, smtpConfiguration.ToString());
			
			if (DisableDaemon)
			{
				GlobalLog.Warning("Not running as Daemon");
			}
			else
			{
				GlobalLog.ColorMessage(ConsoleColors.Blue, "Running as Daemon");
			}

			try
			{
				PluginManager.InitDataAccess(LogLibrary, LogFile);
			}
			catch (PluginError error)
			{
				GlobalLog.Error("Could not initialize Log Library: %s", error.message);
				return 1;
			}
			catch (DataAccessError error)
			{
				GlobalLog.Error("Log Library threw Exception: %s", error.message);
				return 1;
			}
			
			if (!DisableDaemon)
			{
				if (fork() != 0)
				{
					return 0;
				}
			}
			
			IRCConnection[] connections = new IRCConnection[servers.length];
			
			for (int i = 0; i < servers.length; i++)
			{
				try
				{
					connections[i] = new IRCConnection(servers[i]);
				}
				catch (IRCError error)
				{
					GlobalLog.Error(error.message);
					return 1;
				}
			}
			
			GlobalLog.ColorMessage(ConsoleColors.Green, "Application initialized");
			
			MainLoop loop = new MainLoop();
			
			loop.run();

			return 0;
		}

	}
}
