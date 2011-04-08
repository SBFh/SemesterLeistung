namespace Daemon.Helpers
{
	public static class TypeHelper : Object
	{
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
