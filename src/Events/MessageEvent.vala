namespace Daemon.Events
{
	public class MessageEvent : LogEvent
	{
		public MessageEvent(string username, string message, string channel, string server)
		{
			base(username, channel, server);
			Message = message;		
		}
		
		public MessageEvent.WithTimestamp(string username, string message, string channel, string server, DateTime timestamp)
		{
			base.WithTimestamp(username, channel, server, timestamp);
			Message = message;
		}
	
		public string Message { get; private set; }
		
		private const string _stringFormat = "%s | User '%s' in Channel '%s' on '%s' sent message: '%s'";
		
		public override string ToString()
		{
			return _stringFormat.printf(TimestampString, Username, Channel, Server, Message);
		}
	}
}
