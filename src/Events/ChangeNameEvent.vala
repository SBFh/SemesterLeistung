namespace Daemon.Events
{
	public class ChangeNameEvent : LogEvent
	{
		public string NewUsername { get; private set; }
		
		public ChangeNameEvent(string username, string newUsername, string channel, string server)
		{
			base(username, channel, server);
			NewUsername = newUsername;
		}
		
		public ChangeNameEvent.WithTimestamp(string username, string newUsername, string channel, string server, DateTime timestamp)
		{
			base.WithTimestamp(username, channel, server, timestamp);
			NewUsername = newUsername;
		}
		
		private const string _stringFormat = "%s | User '%s' in Channel '%s' on '%s' changed name to: '%s'";
		
		public override string ToString()
		{

			return _stringFormat.printf(TimestampString, Username, Channel, Server, NewUsername);
		}
	}
}
