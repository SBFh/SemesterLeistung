using Xml;
using Daemon.Helpers;

namespace Daemon.Configuration
{
	public errordomain ConfigurationError
	{
		Invalid
	}

	public class ConfigurationFile : Object
	{
		private Doc* _document;
		private Xml.Node* _root;
		
		private void Parse() throws ConfigurationError
		{
_root = _document->get_root_element();
			
			if (_root == null)
			{
				return;
			}
			
			DisableDaemon = GetElementValue(_root, "disable-daemon") == "true";
			LogLibrary = GetElementValue(_root, "log-library");
			LogFile = GetElementValue(_root, "log-file");
			
			Xml.Node* nicknamesNode = GetElement(_root, "nicknames");
			
			if (nicknamesNode != null)
			{
				List<string> nicknames = new List<string>();
				
				for (Xml.Node* iter = nicknamesNode->children; iter != null; iter = iter->next)
				{
		    	if (iter->type != ElementType.ELEMENT_NODE)
		    	{
		      	continue;
		    	}
		    	
		    	string nickname = iter->get_content();
		    	
		    	if (nickname != null)
		    	{
		    		nickname = nickname.strip();
		    	}
		    	
		    	if (nickname == null || nickname.length == 0)
		    	{
		    		throw new ConfigurationError.Invalid("Empty Nickname found");
		    	}
		    	
		    	nicknames.append(nickname);
		    }
		    
		    ListHelper<string> helper = new ListHelper<string>();
		    
		    Nicknames = helper.CopyList(nicknames);
			}
			
			Xml.Node* serversNode = GetElement(_root, "servers");
			
			if (serversNode != null)
			{
				List<ServerConfiguration> servers = new List<ServerConfiguration>();
				
				for (Xml.Node* iter = serversNode->children; iter != null; iter = iter->next)
				{
		    	if (iter->type != ElementType.ELEMENT_NODE)
		    	{
		      	continue;
		    	}
					
					string host = GetElementValue(iter, "host");
					string port = GetElementValue(iter, "port");
					
					if (host != null)
					{
						host = host.strip();
					}
					
					if (host == null || host.length == 0)
					{
						throw new ConfigurationError.Invalid("No hostname defined for server");
					}
					
					uint16 actualPort = 6667;
					
					if (port != null)
					{
						port = port.strip();
						int parsedPort = int.parse(port);
						
						if (parsedPort == 0 || parsedPort < 0 || parsedPort < uint16.MIN || parsedPort > uint16.MAX)
						{
							throw new ConfigurationError.Invalid("Invalid Port");
						}
						
						actualPort = (int16)parsedPort;
					}
					
					List<string> channels = new List<string>();
					
					Xml.Node* channelsNode = GetElement(iter, "channels");
		    	
		    	if (channelsNode == null)
		    	{
		    		throw new ConfigurationError.Invalid("No channels defined for Server '%s:%s'", host, port);
		    	}
		    	
		    	for (Xml.Node* channelsIter = channelsNode->children; channelsIter != null; channelsIter = channelsIter->next)
		    	{
				  	if (channelsIter->type != ElementType.ELEMENT_NODE)
				  	{
				    	continue;
				  	}
				  	string channelName = channelsIter->get_content();
				  	
				  	if (channelName != null)
				  	{
				  		channelName = channelName.strip();
				  	}
				  	
				  	if (channelName == null || channelName.length == 0)
				  	{
				  		throw new ConfigurationError.Invalid("Empty Channel Name found");
				  	}
				  	
				  	channels.append(channelName);
				  	
		    	}
		    	
		    	ListHelper<string> helper = new ListHelper<string>();
		    	
		    	string[] channelArray = helper.CopyList(channels);
		    	
		    	ServerConfiguration configuration = new ServerConfiguration(host, actualPort, channelArray);
		    	
		    	servers.append(configuration);
		    	
	    	}
	    	
	    	ListHelper<ServerConfiguration> serverHelper = new ListHelper<ServerConfiguration>();
	    	Servers = serverHelper.CopyList(servers);
			}
		}
	
		private ConfigurationFile(string filename) throws ConfigurationError
		{
			_document = Parser.parse_file(filename);
			
			if (_document == null)
			{
				throw new ConfigurationError.Invalid("Configuration file could not be opened");
			}
		}
		
		public bool DisableDaemon { get; private set; }
		public string? LogLibrary { get; private set; }
		public string? LogFile { get; private set; }
		public string[]? Nicknames { get; private set; }
		public ServerConfiguration[]? Servers { get; private set; }
		
		private const string _stringFormat = "Disable Daemon: %s\nLog Library: %s\nLog File: %s\nNicknames: %s\nServers:\n%s";
		
		public string ToString()
		{
			string nicknamesString = Nicknames == null ? "None" : string.joinv(", ", Nicknames);
			string serversString = "none";
			
			if (Servers != null)
			{
				serversString = "";
				foreach (ServerConfiguration current in Servers)
				{
					serversString += current.ToString() + "\n";
				}
			}
			
			return _stringFormat.printf(DisableDaemon ? "true" : "false", LogLibrary, LogFile, nicknamesString, serversString);
		}
		
		private Xml.Node* GetElement(Xml.Node* node, string elementName)
		{
			for (Xml.Node* iter = node->children; iter != null; iter = iter->next)
			{
		    if (iter->type != ElementType.ELEMENT_NODE)
		    {
		      continue;
		    }
		    
		    if (iter->name == elementName)
		    {
		    	return iter;
		    }
	    }
	    return null;
		}
		
		private string? GetElementValue(Xml.Node* node, string elementName)
		{
			Xml.Node* elementNode = GetElement(node, elementName);
			if (elementNode == null)
			{
				return null;
			}
			return elementNode->get_content();
		}
		
		private void Release()
		{
			delete _document;
		}
		
		public static ConfigurationFile Load(string filename) throws ConfigurationError
		{
			ConfigurationFile file = null;
			
			try
			{
				file = new ConfigurationFile(filename);
				file.Parse();
			}
			catch (ConfigurationError error)
			{
				throw error;
			}
			finally
			{
				if (file != null)
				{
					file.Release();
				}
			}
			
			return file;
		}
	}
}
