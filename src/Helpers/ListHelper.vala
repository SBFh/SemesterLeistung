namespace Daemon.Helpers
{
	public class ListHelper<T> : Object
	{
		public T[] CopyList(List<T> list)
		{
			T[] result = new T[list.length()];
			
			for (int i = 0; i < list.length(); i++)
			{
				result[i] = list.nth_data(i);
			}
			
			return result;
		}
		
		public List<T> CopyArray(T[] array)
		{
			List<T> result = new List<T>();
			
			for (int i = 0; i < array.length; i++)
			{
				result.append(array[i]);
			}
			
			return result;
		}
	}
}
