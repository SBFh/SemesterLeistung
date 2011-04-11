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

namespace Daemon
{
	public enum ConsoleColors
	{
		Red = 31,
		Green = 32,
		Yellow = 33,
		Blue = 34,
		Purple = 35,
		Cyan = 36,
		White = 37
	}

	public static class GlobalLog : Object
	{
		
		private static void SetConsoleColor(ConsoleColors color)
		{
			stdout.printf("\033[1;%dm", (int)color);
		}
		
		private static void ResetConsoleColor()
		{
			stdout.printf("\033[0m");
		}
	
		[PrintfFormat]
		public static void Message(string format, ...)
		{
			Print(null, "", format, va_list());
		}
		
		[PrintfFormat]
		public static void ColorMessage(ConsoleColors color, string format, ...)
		{
			Print(color, "", format, va_list());
		}
		
		[PrintfFormat]
		public static void Error(string format, ...)
		{
			Print(ConsoleColors.Red, "Error: ", format, va_list());
		}
		
		[PrintfFormat]
		public static void Warning(string format, ...)
		{
			Print(ConsoleColors.Yellow, "Warning: ", format, va_list());
		}
		
		private static void Print(ConsoleColors? color, string prefix, string format, va_list args)
		{
			if (color != null)
			{
				SetConsoleColor(color);
			}
			stdout.vprintf(prefix + format + "\n", args);
			if (color != null)
			{
				ResetConsoleColor();
			}
		}
	}
}
