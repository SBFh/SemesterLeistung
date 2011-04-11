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

namespace Daemon
{
	public class PluginRegistrar<T> : Object
	{
	  public string Path { get; private set; }

	  private Type _type;
	  private Module _module;

	  private delegate Type RegisterPluginFunction (Module module);

	  public PluginRegistrar(string name)
	  {
    	assert(Module.supported());
      Path = Module.build_path (Environment.get_variable ("PWD"), name);
	  }

	  public bool Load()
	  {
  		GlobalLog.ColorMessage(ConsoleColors.Green, "Loading plugin with path: '%s'\n", Path);

      _module = Module.open (Path, ModuleFlags.BIND_LAZY);
      
      if (_module == null)
      {
        return false;
      }

      stdout.printf ("Loaded module: '%s'\n", _module.name ());

      void* function;
      _module.symbol ("register_plugin", out function);
      RegisterPluginFunction register = (RegisterPluginFunction)function;

      _type = register(_module);
      
  		GlobalLog.ColorMessage(ConsoleColors.Green, "Plugin type: %s\n\n", _type.name());
      return true;
	  }

	  public T Create() 
	  {
	      return Object.new(_type);
  	}
	}
}
