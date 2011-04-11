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

using Daemon.Helpers;

namespace Daemon
{
	public errordomain SmtpError
	{
		InvalidConfiguration
	}
	
	public enum EncryptionTypes
	{
		None = 0,
		SSL = 1,
		TLS = 2
	}

	public class SmtpConfiguration : Object
	{
		public SmtpConfiguration(string sender, string host, uint16 port)
		{
			Sender = sender;
			Host = host;
			Port = port;
		}
		
		public string Sender { get; private set; }
		public string Host { get; private set; }
		public uint16 Port { get; private set; }
		
		public string ToString()
		{
			StringBuilder builder = new StringBuilder();
			
			builder.append("{\n\t");
			builder.append("Host: ");
			builder.append(Host);
			
			builder.append(",\n\t");
			builder.append("Port: ");
			builder.append(Port.to_string());
			
			builder.append(",\n\t");
			builder.append("Sender: ");
			builder.append(Sender);
			
			builder.append("\n}");
			
			return builder.str;
		}

		public static SmtpConfiguration Parse(string input) throws SmtpError
		{
			string[] parts = input.split("/");
			
			if (parts.length != 2)
			{
				throw new SmtpError.InvalidConfiguration("Invalid configuration string");
			}
			
			string sender = parts[0].strip();
			
			if (sender.length == 0)
			{
				throw new SmtpError.InvalidConfiguration("Invalid configuration string");
			}
			
			string host;
			uint16? port;
			
			try
			{
				TypeHelper.ParseHostAndPort(parts[1], out host, out port);
			}
			catch (DaemonError error)
			{
				throw new SmtpError.InvalidConfiguration(error.message);
			}
			
			port = port ?? 25;
			
			return new SmtpConfiguration(sender, host, port);
		}
	}
}
