namespace Daemon.IRC
{
	public class Channel : Object
	{
		private List<string> _activeUsers = new List<string>();
	
		public List<string> ActiveUsers
		{
			get
			{
				return _activeUsers;
			}
		}
		
		public string Name { get; private set; }
		
		public Channel(string name)
		{
			Name = name;
		}
		
		public void UserJoined(string name)
		{
			ActiveUsers.append(name);
		}
		
		public void UserLeft(string name)
		{
			ActiveUsers.remove(name);
		}
		
		public void UserChangedName(string name, string newName)
		{
			UserLeft(name);
			UserJoined(newName);
		}
	}
}
