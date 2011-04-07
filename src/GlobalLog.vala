namespace Daemon
{
	public static class GlobalLog : Object
	{
		private enum ConsoleColors
		{
			Red = 31,
			Green = 32,
			Yellow = 33,
			Blue = 34,
			Purple = 35,
			Cyan = 36,
			White = 37
		}
		
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
			Print(format, va_list());
		}
		
		[PrintfFormat]
		public static void Error(string format, ...)
		{
			SetConsoleColor(ConsoleColors.Red);
			Print("Error: " + format, va_list());
			ResetConsoleColor();
		}
		
		[PrintfFormat]
		public static void Warning(string format, ...)
		{
			SetConsoleColor(ConsoleColors.Yellow);
			Print("Warning: " + format, va_list());
			ResetConsoleColor();
		}
		
		private static void Print(string format, va_list args)
		{
			stdout.vprintf(format + "\n", args);
		}
	}
}
