using Daemon.IRC;
using Daemon.Data;

namespace Daemon
{
	public class Main : Object {
		public Main () {
		}

		public void run () {
		
			PluginManager.InitDataAccess(null, "/home/simon/data.db");
			
			IDataAccess access = PluginManager.DataAccess;
			access.UserJoined("Lol", "#rofl", "localhost");
			access.UserLeft("Lol", "#rofl", "localhost");
			access.UserChangedName("Lol", "Lol2", "#rofl", "localhost");
			
			Message newMessage = new Message("Lol", "Rofl", new DateTime.now_local());
			
			for (int i = 0; i < 10; i++)
			{
				access.ChatMessage(newMessage, "#rofl", "localhost");
			}
			
			//IRCConnection connection = new IRCConnection("localhost", 6667);
		}

		static int main (string[] args) {
			var main = new Main ();
			main.run ();
			return 0;
		}

	}
}
