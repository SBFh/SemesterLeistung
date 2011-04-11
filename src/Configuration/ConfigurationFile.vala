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
			RealName = GetElementValue(_root, "realname");
			Host = GetElementValue(_root, "hostname");
			Username = GetElementValue(_root, "username");
			
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
			
			Xml.Node* smtpNode = GetElement(_root, "smtp");
			
			if (smtpNode != null)
			{
				string? sender = GetElementValue(smtpNode, "sender");
				string? host = GetElementValue(smtpNode, "host");
				string? port = GetElementValue(smtpNode, "port");
				
				uint16? actualPort = null;
				
				if (host == null || (host = host.strip()).length == 0)
				{
					throw new ConfigurationError.Invalid("Host required for SMTP");
				}
				
				if (sender == null || (sender = sender.strip()).length == 0)
				{
					throw new ConfigurationError.Invalid("Sender required for SMTP");
				}
				
				if (port != null)
				{
					actualPort = TypeHelper.ParsePort(port);
					if (actualPort == null)
					{
						throw new ConfigurationError.Invalid("Could not parse port");
					}
				}
				
				Smtp = new SmtpConfiguration(sender, host, actualPort);
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
					
					uint16 actualPort = TypeHelper.ParsePort(port) ?? 6667;
					
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
		public string? RealName { get; private set; }
		public string? Host { get; private set; }
		public string? Username { get; private set; }
		public ServerConfiguration[]? Servers { get; private set; }
		public SmtpConfiguration? Smtp { get; private set; }
		
		private const string _stringFormat = "Disable Daemon: %s\nLog Library: %s\nLog File: %s\nNicknames: %s\nServers:\n%s";
		
		public string ToString()
		{
			StringBuilder builder = new StringBuilder();
			
			builder.append("{\n\t");
			builder.append("Disable Daemon: ");
			builder.append(DisableDaemon ? "true" : "false");
			
			if (LogLibrary != null)
			{
				builder.append(",\n\t");
				builder.append("Log Library: ");
				builder.append(LogLibrary);
			}
			
			if (LogFile != null)
			{
				builder.append(",\n\t");
				builder.append("Log File: ");
				builder.append(LogFile);
			}
			
			if (RealName != null)
			{
				builder.append(",\n\t");
				builder.append("Real Name: ");
				builder.append(RealName);
			}
			
			if (Host != null)
			{
				builder.append(",\n\t");
				builder.append("Host: ");
				builder.append(Host);
			}
			
			if (Username != null)
			{
				builder.append(",\n\t");
				builder.append("Username: ");
				builder.append(Username);
			}
			
			if (Smtp != null)
			{
				builder.append(",\n\t");
				builder.append("Smtp Configuration:\n");
				builder.append(TypeHelper.IndentString(Smtp.ToString(), 1));
			}
			
			if (Nicknames != null && Nicknames.length > 0)
			{
				builder.append(",\n\t");
				builder.append("Nicknames: ");
				builder.append("\n\t[\n\t\t");
				
				for (int i = 0; i < Nicknames.length; i++)
				{
					builder.append(Nicknames[i]);	
					if (i < Nicknames.length - 1)
					{
						builder.append(",\n\t\t");
					}
				}
				
				builder.append("\n\t]");
			}
			
			if (Servers != null && Servers.length > 0)
			{
				builder.append(",\n\t");
				builder.append("Servers: ");
				builder.append("\n\t[\n");
				
				for (int i = 0; i < Servers.length; i++)
				{
					builder.append(TypeHelper.IndentString(Servers[i].ToString(), 2));
					if (i < Servers.length - 1)
					{
						builder.append(",\n");
					}
				}
				
				builder.append("\n\t]");
			}
			
			return builder.str;
		
			
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
