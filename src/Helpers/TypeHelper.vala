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
	public errordomain DaemonError
	{
		ParseFailed
	}

	public static class TypeHelper : Object
	{
	
		public static uint16? ParsePort(string text)
		{
			string input = text.strip();
		
			if (input.length == 0 || !IsNumeric(input))
			{
				return null;
			}
			
			int port = int.parse(input);
			if (port < 0 || port < uint16.MIN || port > uint16.MAX)
			{
				return null;
			}
			
			return (uint16)port;
		}
		
		public static void ParseHostAndPort(string input, out string host, out uint16? port) throws DaemonError
		{
			string[] parts = input.split(":");
			
			if (parts.length > 2)
			{
				throw new DaemonError.ParseFailed("Invalid host");
			}
			
			host = parts[0].strip();
			if (host.length == 0)
			{
				throw new DaemonError.ParseFailed("Invalid host");
			}
			
			if (parts.length == 2)
			{
				port = ParsePort(parts[1]);
				if (port == null)
				{
					throw new DaemonError.ParseFailed("Could not parse port");
				}
			}
		}
	
		public static string IndentString(string text, int count)
		{
			string[] parts = text.split("\n");
			string prefix = string.nfill(count, '\t');
			
			for (int i = 0; i < parts.length; i++)
			{
				parts[i] = prefix + parts[i];
			}
			
			return string.joinv("\n", parts);
		}
	
		public static bool IsNumeric(string text)
		{
			for (int i = 0; i < text.length; i++)
			{
				if (!text[i].isalnum())
				{
					return false;
				}
			}
			
			return true;
		}
	}
}
