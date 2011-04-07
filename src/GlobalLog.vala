namespace Daemon
{
	public static class GlobalLog : Object
	{
		public static void Text(string format, params Object[] parameters)
		{
			stdout.printf(format, parameters);
		}
	}
}
