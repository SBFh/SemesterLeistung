using Sqlite;

namespace Daemon.Data
{
	errordomain DataAccessError
	{
		OpenFailed,
		WriteError
	}
	
	public enum EventTypes
	{
		Joined = 0,
		Left = 1,
		ChangedName = 2
	}

	public interface IDataAccess : Object
	{
		public abstract void UserJoined(string username, string channel, string server);
		public abstract void UserLeft(string username, string channel, string server);
		public abstract void UserChangedName(string oldUsername, string newUsername, string channel, string server);
		public abstract void ChatMessage(Message message, string channel, string server);
		
		public abstract DateTime? UserLastSeen(string username, string channel, string server);
		public abstract Message[] GetLog(string channel, string server);
		
		public abstract void Init(string? logPath);
	}
}
