using Daemon.IRC;
using Daemon.Data;
using Daemon.Events;
using Daemon.Configuration;

namespace Daemon
{
	public class Main : Object {
		public Main () {
		}

		public void run ()
		{
			IRCConnection connection = null;
			try
			{	
				connection = new IRCConnection("localhost:6667");
			}
			catch (IRCError error)
			{
				stdout.printf(error.message);
				return;
			}
			
			connection.Join();
		}
		
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
 				"console", 
 				'd', 
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
 				"Specify the Servers and Channels to use. Use format: 'host:(port)/channel,channel,...'", 
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
				GlobalLog.Warning("Ignoring Configuration File");
			}
			else
			{
				ConfigFile = ConfigFile ?? Environment.get_current_dir() + "/config.xml";
			
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

			if (Nicknames != null && Nicknames.length > 0)
			{
				nicknames = Nicknames.split(",");
				
				GlobalLog.ColorMessage(ConsoleColors.Green, "Using these nicknames in this order:");
				
				foreach (string current in nicknames)
				{
					GlobalLog.ColorMessage(ConsoleColors.Purple, current);
				}
			}
			
			if (Servers == null || Servers.length == 0)
			{
				GlobalLog.Error("No servers specified");
				return 1;
			}
			
			foreach (string current in Servers)
			{
				ServerConfiguration server;
				
				try
				{
					server = ServerConfiguration.Parse(current);
					GlobalLog.ColorMessage(ConsoleColors.Green, "Using Server:");
					GlobalLog.ColorMessage(ConsoleColors.Purple, server.ToString());
				}
				catch (ConfigurationError error)
				{
					GlobalLog.Error("Server configuration invalid, reason: %s", error.message);
					return 1;
				}
			}
			
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
			

			return 0;
			var main = new Main ();
			main.run ();
			return 0;
		}

	}
}
