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

using Daemon.Helpers;

namespace Daemon.Events
{
	public abstract class LogEvent : Object
	{
		protected LogEvent(string username, string channel, string server)
		{
			this.WithTimestamp(username, channel, server, new DateTime.now_local());
		}
		
		protected LogEvent.WithTimestamp(string username, string channel, string server, DateTime timestamp)
		{
			Username = username;
			Timestamp = timestamp;
			Channel = channel;
			Server = server;
		}
	
		public string Username { get; private set; }
		
		public DateTime Timestamp { get; private set; }
		
		public string Channel { get; private set; }
		
		public string Server { get; private set; }
		
		private int64? _unixTimestamp;
		
		public int64 UnixTimestamp
		{
			get
			{
				if (_unixTimestamp == null)
				{
					_unixTimestamp = DateTimeConverter.ToUnixTimestamp(Timestamp);
				}
				return _unixTimestamp;
			}
		}
		
		private string? _timestampString;
		
		public string TimestampString
		{
			get
			{
				if (_timestampString == null)
				{
					_timestampString = Timestamp.to_string();
				}
				return _timestampString;
			}
		}
		
		public abstract string ToString();
	}
}
