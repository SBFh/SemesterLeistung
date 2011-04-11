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
