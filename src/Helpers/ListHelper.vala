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
		
		public T[] AppendArrays(T[] first, T[] second)
		{
			T[] result = new T[first.length + second.length];
			
			for (int i = 0; i < first.length; i++)
			{
				result[i] = first[i];	
			}
			
			for (int i = 0; i < second.length; i++)
			{
				result[i + first.length] = second[i];
			}
			
			return result;
		}
		
		public T[] AppendList(T[] first, List<T> second)
		{
			return AppendArrays(first, CopyList(second));
		}
		
		public T[] AppendArray(List<T> first, T[] second)
		{
			return AppendArrays(CopyList(first), second);
		}
	}
}
