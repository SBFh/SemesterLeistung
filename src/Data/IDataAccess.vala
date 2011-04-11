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
	
	public static class IRCLog : Object
	{
		public static void Log(LogEvent event) throws DataAccessError
		{
			GlobalLog.Message(event.ToString());
			PluginManager.DataAccess.Log(event);
		}
	}
}
