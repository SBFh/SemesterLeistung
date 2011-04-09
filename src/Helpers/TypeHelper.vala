namespace Daemon.Helpers
{
	public static class TypeHelper : Object
	{
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
