namespace Daemon.Helpers
{
	public static class DateTimeConverter
	{
		public static int64 ToUnixTimestamp(DateTime dateTime)
		{
			return dateTime.to_unix();
		}
		
		public static DateTime FromUnixTimestamp(int64 timestamp)
		{
			return new DateTime.from_unix_local(timestamp);
		}
	}
}
