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
	public class MessageEvent : LogEvent
	{
		public MessageEvent(string username, string message, string channel, string server)
		{
			base(username, channel, server);
			Message = message;		
		}
		
		public MessageEvent.WithTimestamp(string username, string message, string channel, string server, DateTime timestamp)
		{
			base.WithTimestamp(username, channel, server, timestamp);
			Message = message;
		}
	
		public string Message { get; private set; }
		
		private const string _stringFormat = "%s | User '%s' in Channel '%s' on '%s' sent message: '%s'";
		
		public override string ToString()
		{
			return _stringFormat.printf(TimestampString, Username, Channel, Server, Message);
		}
	}
}
