using Sqlite;
using Daemon.Helpers;
using Daemon.Events;

namespace Daemon.Data
{
	public class SqliteData : Object, IDataAccess
	{
		private Database _database;
		
		public void Init(string? logPath) throws DataAccessError
		{
			int result = Database.open(logPath ?? "data.db", out _database);
			if (result != Sqlite.OK)
			{
				throw new DataAccessError.OpenFailed("Could not open Database");
			}
			CreateSchema();
		}
		
		private void CreateSchema() throws DataAccessError
		{
			string createLog = "CREATE TABLE IF NOT EXISTS Log (Username TEXT, Data TEXT NULL, Channel TEXT, Server TEXT, Timestamp INTEGER, Type INTEGER)";
			
			if (_database.exec(createLog) != Sqlite.OK)
			{
				throw new DataAccessError.WriteError("Could not create Database");				
			}	
			
			GlobalLog.ColorMessage(ConsoleColors.Green, "Successfully initialized Database");
		}
		
		public void Log(LogEvent event) throws DataAccessError
		{
			if (event is StatusEvent)
			{
				LogStatusEvent((StatusEvent)event);
			}
			else if (event is ChangeNameEvent)
			{
				LogChangeNameEvent((ChangeNameEvent)event);
			}
			else if (event is MessageEvent)
			{
				LogMessageEvent((MessageEvent)event);
			}
			stdout.printf(event.ToString() + "\n");
		}
		
		private void LogStatusEvent(StatusEvent event) throws DataAccessError
		{
			string commandText = "INSERT INTO Log (Username, Channel, Server, Type, Timestamp) VALUES (@1, @2, @3, @4, @5)";
			Statement statement;
			
			_database.prepare_v2(commandText, -1, out statement);
			
			statement.bind_text(1, event.Username);
			statement.bind_text(2, event.Channel);
			statement.bind_text(3, event.Server);
			statement.bind_int(4, event.Type == StatusChange.Join ? (int)EventTypes.Joined : (int)EventTypes.Left);
			statement.bind_int64(5, event.UnixTimestamp);
			
			if (statement.step() != Sqlite.DONE)
			{
				throw new DataAccessError.WriteError(_database.errmsg());
			}
		}
		
		public void LogChangeNameEvent(ChangeNameEvent event) throws DataAccessError
		{
			string commandText = "INSERT INTO Log (Username, Data, Channel, Server, Type, Timestamp) VALUES (@1, @2, @3, @4, @5, @6)";
			Statement statement;
			
			_database.prepare_v2(commandText, -1, out statement);
			
			statement.bind_text(1, event.Username);
			statement.bind_text(2, event.NewUsername);
			statement.bind_text(3, event.Channel);
			statement.bind_text(4, event.Server);
			statement.bind_int(5, (int)EventTypes.ChangedName);
			statement.bind_int64(6, event.UnixTimestamp);
			
			if (statement.step() != Sqlite.DONE)
			{
				throw new DataAccessError.WriteError(_database.errmsg());
			}
		}
		
		public void LogMessageEvent(MessageEvent event) throws DataAccessError
		{
			string commandText = "INSERT INTO Log (Username, Data, Channel, Server, Timestamp, Type) VALUES (@1, @2, @3, @4, @5, @6)";
			
			Statement statement;
			
			_database.prepare_v2(commandText, -1, out statement);
			
			statement.bind_text(1, event.Username);
			statement.bind_text(2, event.Message);
			statement.bind_text(3, event.Channel);
			statement.bind_text(4, event.Server);
			statement.bind_int64(5, event.UnixTimestamp);
			statement.bind_int(6, (int)EventTypes.Message);
			
			if (statement.step() != Sqlite.DONE)
			{
				throw new DataAccessError.WriteError(_database.errmsg());
			}
		}
				
		public DateTime? UserLastSeen(string username, string channel, string server) throws DataAccessError
		{
			string commandText = "SELECT Timestamp,Type FROM Log WHERE Username = @1 AND Channel = @2 AND Server = @3 ORDER BY Timestamp DESC LIMIT 1";
			
			Statement statement;
			
			_database.prepare_v2(commandText, -1, out statement);
			
			statement.bind_text(1, username);
			statement.bind_text(2, channel);
			statement.bind_text(3, server);
			
			if (statement.step() != Sqlite.ROW)
			{
				return null;
			}
			
			if (statement.column_int(1) != (int)EventTypes.Left)
			{
				return new DateTime.now_local();
			}
			
			return DateTimeConverter.FromUnixTimestamp(statement.column_int64(0));
		}
		
		public List<LogEvent> GetLog(string channel, string server) throws DataAccessError
		{
			string commandText = "SELECT * FROM Log WHERE Channel = @1 AND Server = @2 ORDER BY Timestamp DESC LIMIT 50";

			Statement statement;
			
			_database.prepare_v2(commandText, -1, out statement);
			
			statement.bind_text(1, channel);
			statement.bind_text(2, server);
			
			int result = 0;
			
			List<LogEvent> results = new List<LogEvent>();

			do
			{
				result = statement.step();
				switch (result)
				{
					case (Sqlite.DONE):
					{
						break;
					}
					case (Sqlite.ROW):
					{
						string username = statement.column_text(0);
						string data = statement.column_text(1);
						string eventChannel = statement.column_text(2);
						string eventServer = statement.column_text(3);
						DateTime timestamp = DateTimeConverter.FromUnixTimestamp(statement.column_int64(4));
						EventTypes type = (EventTypes)statement.column_int(5);
						
						LogEvent current = null;
						
						switch (type)
						{
							case (EventTypes.Joined):
							{
								current = new StatusEvent.WithTimestamp(username, StatusChange.Join, eventChannel, eventServer, timestamp);
								break;
							}
							case (EventTypes.Left):
							{
								current = new StatusEvent.WithTimestamp(username, StatusChange.Leave, eventChannel, eventServer, timestamp);
								break;
							}
							case (EventTypes.ChangedName):
							{
								current = new ChangeNameEvent.WithTimestamp(username, data, eventChannel, eventServer, timestamp);
								break;
							}
							case (EventTypes.Message):
							{
								current = new MessageEvent.WithTimestamp(username, data, eventChannel, eventServer, timestamp);
								break;
							}
						}
						
						results.append(current);
						
						break;
					}
					default:
					{
						throw new DataAccessError.ReadError(_database.errmsg());
					}
				}
			}
			while (result == Sqlite.ROW);

			return results;
		}
	}
}
