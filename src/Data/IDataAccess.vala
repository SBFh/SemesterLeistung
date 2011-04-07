using Daemon.Events;

namespace Daemon.Data
{
	errordomain DataAccessError
	{
		OpenFailed,
		WriteError,
		ReadError
	}
	
	public enum EventTypes
	{
		Joined = 0,
		Left = 1,
		ChangedName = 2,
		Message = 3
	}

	public interface IDataAccess : Object
	{
		public abstract void Log(LogEvent event);
		public abstract DateTime? UserLastSeen(string username, string channel, string server);
		public abstract List<LogEvent> GetLog(string channel, string server);
		public abstract void Init(string? logPath);
	}
}
