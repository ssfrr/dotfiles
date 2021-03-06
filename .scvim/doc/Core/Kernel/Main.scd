Main

superclass: Process

Main is the concrete instance of Process (the runtime environment for the virtual machine and interpreter).
Main overrides some methods of Process. There are two methods of interest. One is named startup and is 
called after the class library has been compiled. The other is called shutdown which gets called when the library gets re-compiled.

The singleton instance of Main is available through the special keyword thisProcess. 
For example, to find out what platform you're on:

	thisProcess.platform;	// --> e.g. "an OSXPlatform", "a LinuxPlatform", ...


startup

called after the class library has been compiled. This calls the superclass' startup, which among other things initializes the AppClock and the top-level Environment. Main's startup then stores Server.default in the interpreter variable s, sets the platform default's GUI kit, initializes the GeneralHID system, calls a Platform specific startup method (for example OSXPlatform's startup opens the server windows), and finally invokes StartUp.run. To add your own startup functionalities, you could either edit the special startup-file (discussed in Using-the-Startup-File), or use StartUp.add as discussed in the StartUp help file.


shutdown

called after SuperCollider is quit or the class library is about to be re-compiled. This will quit all audio Server instances, perform a platform specific shutdown (e.g. on Mac OS X, the HID service is released), finally Process' shutdown method is called, resulting successive calls to UI.shutdown, NetAddr.disconnectAll, File.closeAll, and Archive.write. To register your own shutdown code, use a call like this:

	UI.registerForShutdown({ "Good bye!!".postln });

sleep / wake

sleepAction and wakeAction are called when the computer was set in sleep mode / awoke from sleep mode.
(currently OS X only)
	
	thisProcess.sleepAction =  { "good night,".postln };

isSleeping
returns true if computer was just set to sleep. (currently OS X only)
	
	thisProcess.isSleeping;

run

Override this to do whatever you want, e. g. add a class extension file like this to the class library:

	+ Main {
		run { "myPatch.rtf".load }
	}


recvOSCfunc

You can store a custom function in this field that gets called whenever SuperCollider language (the client) receives an OSC message. That is very useful for debugging OSC-communication with other applications (e.g. Processing, Pure Data, but also the scsynth server).

	// post all incoming traffic except the server status messages
	(
	thisProcess.recvOSCfunc = { |time, replyAddr, msg| 
		if(msg[0] != '/status.reply') {
			"At time %s received message % from %\n".postf( time, msg, replyAddr )
		}  
	}
	);
	
	// stop posting.
	thisProcess.recvOSCfunc = nil;


pid

Returns the operating system's pid (process ID) for the process.

	thisProcess.pid


<>preferencesAction - OSX SC.app only.

A function to evaluate when the SuperCollider preferences menu is selected.

	thisProcess.preferencesAction = { arg process; SCWindow.new.front; }



*version, *versionAtLeast, *versionAtMost

These class methods tell you which version of SuperCollider you are running and whether that version complies to your required minimum / maximum settings:

	// the current version as a human readable string
	Main.version;	
	// check if we are running at least version 3.1 (returns true or false)
	Main.versionAtLeast( 3, 1 );
	// check if we are running version 3.1 or older (returns true or false)	
	Main.versionAtMost( 3, 1 );	


recompile

Recompiles the class library. This is equivalent to restarting SC. Currently OSX (SuperCollider.app) only.


