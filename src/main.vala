using Daemon.IRC;
using Daemon.Data;
using Daemon.Events;

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
			
			GlobalLog.Message("Initializing the Daemon");
			
			if (LogLibrary == null)
			{
				GlobalLog.Message("Using default log library");
			}
			else
			{
				GlobalLog.Message("Using log library located at: %s", LogLibrary);
			}
			
			LogFile = LogFile ?? "~/data.db";
			
			GlobalLog.Message("Using Log at %s", LogFile);

			return 0;
			var main = new Main ();
			main.run ();
			return 0;
		}

	}
}
