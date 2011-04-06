namespace Daemon.Events
{
	public enum StatusChange
	{
		Join,
		Leave
	}

	public class StatusEvent : LogEvent
	{
		public StatusEvent(string username, StatusChange type, string channel, string server)
		{
			base(username, channel, server);
			Type = type;
		}
		
		public StatusEvent.WithTimestamp(string username, StatusChange type, string channel, string server, DateTime timestamp)
		{
			base.WithTimestamp(username, channel, server, timestamp);
			Type = type;
		}
		
		public StatusChange Type { get; private set; }
		
		private const string _stringFormat = "%s | User '%s' on '%s' %s Channel '%s'";
		
		public override string ToString()
		{
			string eventString = Type == StatusChange.Join ? "joined" : "left";
			
			return _stringFormat.printf(TimestampString, Username, Server, eventString, Channel);
		}
	}
}
