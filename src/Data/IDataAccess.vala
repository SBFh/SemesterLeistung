using Sqlite;

namespace Daemon.Data
{
	errordomain DataAccessError
	{
		OpenFailed
	}

	public class DataAccess
	{
		private Database _database;
	
		public DataAccess()
		{
			int result = Database.open("data.db", out _database);
			if (result != Sqlite.OK)
			{
				throw new DataAccessError.OpenFailed("Could not open Database");
			}
		}
	}
}
