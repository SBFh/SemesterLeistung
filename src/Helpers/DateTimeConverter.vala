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

namespace Daemon.Helpers
{
	public static class DateTimeConverter
	{
		public static int64 ToUnixTimestamp(DateTime dateTime)
		{
			return dateTime.to_unix();
		}
		
		public static DateTime FromUnixTimestamp(int64 timestamp)
		{
			return new DateTime.from_unix_local(timestamp);
		}
	}
}
