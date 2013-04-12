Using Extensions

See also: Writing-Classes    Writing_Unit_Generators   Quarks

SC supports extensions to its class library, documentation, and server UGen plugins. Extensions should be packaged as a single folder containing all three (for convenient addition or removal), or any combination, which can then be placed in platform-specific extension directories in order to be included.

Platform Specific Directories

You can install extensions simply by copying the extensions to the following location:

User-specific
OSX			~/Library/Application Support/SuperCollider/Extensions/
Linux		~/share/SuperCollider/Extensions/

Platform.userExtensionDir


System-wide (apply to all users)
OSX			/Library/Application Support/SuperCollider/Extensions/
Linux		/usr/local/share/SuperCollider/Extensions/

Platform.systemExtensionDir


How Extensions Folders Should be Organised

Class files and UGen plugins are recognised by their file extensions (.sc for the former and .scx or .sco for the latter). Anything placed within a folder named help/ or ignore/ (case insensitive) will be ignored when compiling the class library or loading plugins, but anything in the former will be added to the search path for help files.

Here is an example folder layout:

	MyExtension/
	
		classes/
			myClass.sc 	myUGens.sc
		plugins/
			myUGenPlugins.scx
		help/
			myClass.html 	myUGen1.html	myUGen2.html




