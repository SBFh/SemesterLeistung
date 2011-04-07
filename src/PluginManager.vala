using Daemon.Data;

namespace Daemon
{
	public errordomain PluginError
	{
		LibraryError
	}

	public class PluginManager : Object
	{
		public static IDataAccess? DataAccess { get; private set; }
		
		public static IDataAccess? InitDataAccess(string? pluginPath, string? logPath) throws PluginError
		{
			IDataAccess result;
			
			if (pluginPath == null)
			{
				result = new SqliteData();
			}
			else
			{
				PluginRegistrar<IDataAccess> registrar = new PluginRegistrar<IDataAccess>(pluginPath);
				registrar.Load(); 
				result = registrar.Create();
			}
			
			try
			{
				result.Init(logPath);
			}
			catch (DataAccessError error)
			{
				stdout.printf("Error initializing Data Access Plugin: %s", error.message);
				return null;
			}
			
			DataAccess = result;
			
			return result;
		}
	}
}
