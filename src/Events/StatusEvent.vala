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

namespace Daemon.Events
{
	public enum StatusChange
	{
		Join,
		Leave
	}

	public class StatusEvent : LogEvent
	{
		public StatusEvent(string username, StatusChange type, string channel, string server)
		{
			base(username, channel, server);
			Type = type;
		}
		
		public StatusEvent.WithTimestamp(string username, StatusChange type, string channel, string server, DateTime timestamp)
		{
			base.WithTimestamp(username, channel, server, timestamp);
			Type = type;
		}
		
		public StatusChange Type { get; private set; }
		
		private const string _stringFormat = "%s | User '%s' on '%s' %s Channel '%s'";
		
		public override string ToString()
		{
			string eventString = Type == StatusChange.Join ? "joined" : "left";
			
			return _stringFormat.printf(TimestampString, Username, Server, eventString, Channel);
		}
	}
}
