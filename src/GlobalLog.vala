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
