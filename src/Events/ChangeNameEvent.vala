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
	public class ChangeNameEvent : LogEvent
	{
		public string NewUsername { get; private set; }
		
		public ChangeNameEvent(string username, string newUsername, string channel, string server)
		{
			base(username, channel, server);
			NewUsername = newUsername;
		}
		
		public ChangeNameEvent.WithTimestamp(string username, string newUsername, string channel, string server, DateTime timestamp)
		{
			base.WithTimestamp(username, channel, server, timestamp);
			NewUsername = newUsername;
		}
		
		private const string _stringFormat = "%s | User '%s' in Channel '%s' on '%s' changed name to: '%s'";
		
		public override string ToString()
		{

			return _stringFormat.printf(TimestampString, Username, Channel, Server, NewUsername);
		}
	}
}
