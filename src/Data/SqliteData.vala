using Sqlite;
using Daemon.Helpers;

namespace Daemon.Data
{
	public class SqliteData : Object, IDataAccess
	{
		private Database _database;
		
		public void Init(string? logPath)
		{
			int result = Database.open(logPath ?? "data.db", out _database);
			if (result != Sqlite.OK)
			{
				throw new DataAccessError.OpenFailed("Could not open Database");
			}
			CreateSchema();
		}
		
		private void CreateSchema()
		{
			string createLog = "CREATE TABLE IF NOT EXISTS Log (Username TEXT, Message TEXT, Channel TEXT, Server TEXT, Timestamp INTEGER)";
			
			if (_database.exec(createLog) != Sqlite.OK)
			{
				throw new DataAccessError.WriteError("Could not create Database");				
			}	
			
			string createEvents = "CREATE TABLE IF NOT EXISTS Events (Username TEXT, NewUsername TEXT NULL, Channel TEXT, Server TEXT, Type INTEGER, Timestamp INTEGER)";
			
			if (_database.exec(createEvents) != Sqlite.OK)
			{
				throw new DataAccessError.WriteError("Could not create Database");				
			}	
			
			stdout.printf("Successfully initialized Database");
		}
		
		private void JoinedLeft(string username, string channel, string server, int type)
		{
			string commandText = "INSERT INTO Events (Username, Channel, Server, Type, Timestamp) VALUES (@1, @2, @3, @4, @5)";
			Statement statement;
			
			_database.prepare_v2(commandText, -1, out statement);
			
			statement.bind_text(1, username);
			statement.bind_text(2, channel);
			statement.bind_text(3, server);
			statement.bind_int(4, type);
			statement.bind_int64(5, DateTimeConverter.ToUnixTimestamp(new DateTime.now_local()));
			
			if (statement.step() != Sqlite.DONE)
			{
				throw new DataAccessError.WriteError(_database.errmsg());
			}
		}
		
		public void UserJoined(string username, string channel, string server)
		{
			JoinedLeft(username, channel, server, (int)EventTypes.Joined);
		}
		
		public void UserLeft(string username, string channel, string server)
		{
			JoinedLeft(username, channel, server, (int)EventTypes.Left);
		}
		
		public void UserChangedName(string oldUsername, string newUsername, string channel, string server)
		{
			string commandText = "INSERT INTO Events (Username, NewUsername, Channel, Server, Type, Timestamp) VALUES (@1, @2, @3, @4, @5, @6)";
			Statement statement;
			
			_database.prepare_v2(commandText, -1, out statement);
			
			statement.bind_text(1, oldUsername);
			statement.bind_text(2, newUsername);
			statement.bind_text(3, channel);
			statement.bind_text(4, server);
			statement.bind_int(5, (int)EventTypes.ChangedName);
			statement.bind_int64(6, DateTimeConverter.ToUnixTimestamp(new DateTime.now_local()));
			
			if (statement.step() != Sqlite.DONE)
			{
				throw new DataAccessError.WriteError(_database.errmsg());
			}
		}
		
		public void ChatMessage(Message message, string channel, string server)
		{
			string commandText = "INSERT INTO Log (Username, Message, Channel, Server, Timestamp) VALUES (@1, @2, @3, @4, @5)";
			
			Statement statement;
			
			_database.prepare_v2(commandText, -1, out statement);
			
			statement.bind_text(1, message.Username);
			statement.bind_text(2, message.Text);
			statement.bind_text(3, channel);
			statement.bind_text(4, server);
			statement.bind_int64(5, DateTimeConverter.ToUnixTimestamp(message.TimeStamp));
			
			if (statement.step() != Sqlite.DONE)
			{
				throw new DataAccessError.WriteError(_database.errmsg());
			}
		}
				
		public DateTime? UserLastSeen(string username, string channel, string server)
		{
			return null;
		}
		
		public Message[] GetLog(string channel, string server)
		{
			return null;
		}
	}
}
