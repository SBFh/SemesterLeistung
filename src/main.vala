using Daemon.IRC;
using Daemon.Data;
using Daemon.Events;

namespace Daemon
{
	public class Main : Object {
		public Main () {
		}

		public void run () {
		
			ChangeNameEvent event = new ChangeNameEvent("Simon", "Theodor", "#rofl", "localhost");
			StatusEvent nextEvent = new StatusEvent("Simon", StatusChange.Join, "#rofl", "localhost");
			StatusEvent nextEvent2 = new StatusEvent("Simon", StatusChange.Leave, "#rofl", "localhost");
			MessageEvent lastEvent = new MessageEvent("Simon", "LOOOOL", "#rofl", "localhost");
		
			PluginManager.InitDataAccess(null, "/home/simon/data.db");
			
			IDataAccess access = PluginManager.DataAccess;
			
			List<LogEvent> results = access.GetLog("#rofl", "localhost");
			
			foreach (LogEvent current in results)
			{
				stdout.printf(current.ToString() + "\n");
				
			}
			
			return;
			
			access.Log(event);
			access.Log(nextEvent);
			access.Log(nextEvent2);
			access.Log(lastEvent);
			
			//IRCConnection connection = new IRCConnection("localhost", 6667);
		}

		static int main (string[] args) {
			var main = new Main ();
			main.run ();
			return 0;
		}

	}
}
