/*SemesterLeistung - An IRC Daemon
* Copyright (C) 2011  Simon Baumer
* 
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
* 
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.*/

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
		
		public static IDataAccess? InitDataAccess(string? pluginPath, string? logPath) throws PluginError, DataAccessError
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
