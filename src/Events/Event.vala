using Daemon.Helpers;

namespace Daemon.Events
{
	public abstract class LogEvent : Object
	{
		protected LogEvent(string username, string channel, string server)
		{
			this.WithTimestamp(username, channel, server, new DateTime.now_local());
		}
		
		protected LogEvent.WithTimestamp(string username, string channel, string server, DateTime timestamp)
		{
			Username = username;
			Timestamp = timestamp;
			Channel = channel;
			Server = server;
		}
	
		public string Username { get; private set; }
		
		public DateTime Timestamp { get; private set; }
		
		public string Channel { get; private set; }
		
		public string Server { get; private set; }
		
		private int64? _unixTimestamp;
		
		public int64 UnixTimestamp
		{
			get
			{
				if (_unixTimestamp == null)
				{
					_unixTimestamp = DateTimeConverter.ToUnixTimestamp(Timestamp);
				}
				return _unixTimestamp;
			}
		}
		
		private string? _timestampString;
		
		public string TimestampString
		{
			get
			{
				if (_timestampString == null)
				{
					_timestampString = Timestamp.to_string();
				}
				return _timestampString;
			}
		}
		
		public abstract string ToString();
	}
}
