using Daemon.Events;

namespace Daemon.Data
{
	public errordomain DataAccessError
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
		public abstract void Log(LogEvent event) throws DataAccessError;
		public abstract DateTime? UserLastSeen(string username, string channel, string server) throws DataAccessError;
		public abstract List<LogEvent> GetLog(string channel, string server) throws DataAccessError;
		public abstract void Init(string? logPath) throws DataAccessError;
	}
}
