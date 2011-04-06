using Daemon.Data;

namespace Daemon
{
	errordomain PluginError
	{
		LibraryError
	}

	public class PluginManager : Object
	{
		public static IDataAccess DataAccess { get; private set; }
		
		public static IDataAccess InitDataAccess(string? pluginPath, string? logPath)
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
			
			result.Init(logPath);
			
			DataAccess = result;
			
			return result;
		}
	}
}
