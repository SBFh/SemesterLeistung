namespace Daemon
{
	public class Message : Object
	{
		public string Text { get; private set; }
		public string Username { get; private set; }
		public DateTime TimeStamp { get; private set; }
		
		public Message(string text, string username, DateTime timeStamp)
		{
			Text = text;
			Username = username;
			TimeStamp = timeStamp;
		}
	}
}
