Using the Startup File

Once the class library is finished compiling the interpreter looks for a file at an operating system dependent path and if such a file exists, executes any code within it. (This happens within Main-startup.) By creating a file in this location you can make user specific customizations.

- On Mac OS X the path is either "/Library/Application Support/SuperCollider/startup.rtf" (i.e. a system-wide file) or "~/Library/Application Support/SuperCollider/startup.rtf" (i.e. a user-specific file). Both files can be used, where the system-wide file is executed before the user-specific file.
- On Linux the path is "~/.sclang.sc"
- On Windows the file is "startup.sc" and needs to be in the same directory as PsyCollider

A common example would be to alter the options of the local and internal Servers:
// placing the following code in the file will cause these modifications to be made
// at startup (see also: ServerOptions)

Server.local.options.numOutputBusChannels = 4;	// change number of input and output channels
Server.local.options.numInputBusChannels = 4;
Server.internal.options.numOutputBusChannels = 4;
Server.internal.options.numInputBusChannels = 4;

Server.local.options.device = "Built-in Audio";	// use a specific soundcard
Server.local.options.device = "MOTU Traveler";
Server.local.options.device = "TASCAM US-122";
Server.local.options.device = "Jack Router";
Server.local.options.device = nil;				// use the system default soundcard

Server.local.options.blockSize = 128; // increase block size (default is 64)
Server.internal.options.blockSize = 128;

Server.local.options.sampleRate = 96000; // increase sampling rate (if your hardware supports it)
Server.internal.options.sampleRate = 96000;
Server.internal.options.sampleRate = nil;	// use the currently selected samplerate of the soundcard

// change the standard synthDef directory to a custom one:
SynthDef.synthDefDir = "~/scwork/synthdefs".standardizePath;

// change the standard archive path to a custom one:
Archive.archiveDir = "~/scwork".standardizePath;
		
Naturally the file must contain only valid SC expressions.


