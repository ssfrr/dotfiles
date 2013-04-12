ServerOptions			encapsulates commandline and other options for a Server

Inherits from: Object

ServerOptions encapsulates various options for a server app within an object. This makes it convenient to launch multiple servers with the same options, or to archive different sets of options, etc. Every Server has an instance of ServerOptions created for it if one is not passed as the options argument when the Server object is created. (This is the case for example with the local and internal Servers which are created at startup.)

A Server's instance of ServerOptions is stored in its options instance variable, which can be accessed through corresponding getter and setter methods.

N.B. A ServerOptions' instance variables are translated into commandline arguments when a server app is booted. Thus a running Server must be rebooted before changes will take effect. There are also a few commandline options which are not currently encapsulated in ServerOptions. See Server-Architecture for more details.

See also: Server, Server-Architecture, and Server-Command-Reference.

Creation / Class Methods

	*new
	
		Create and return a new instance of ServerOptions.
		
	*devices
	
		Return an Array of Strings listing the audio devices currently available on the system.
		
	*inDevices
	
		Return an Array of Strings listing the audio devices currently available on the system which have input channels.
		
	*outDevices
	
		Return an Array of Strings listing the audio devices currently available on the system which have output channels.
		

Accessing Instance and Class Variables (The Options)
				
	blockSize_(arg1)
	blockSize
		
		The number of samples in one control period. The default is 64.
		
	device_(arg1)
	device
		
		A String that allows you to choose a sound device to use as input and output. The default, nil will use the system's default input and output device(s) (more below in the examples). 

	inDevice_(arg1)
	inDevice
		
		A String that allows you to choose an input sound device. The default, nil will use the system's default input device (more below in the examples).

	outDevice_(arg1)
	outDevice
		
		A String that allows you to choose an output sound device. The default, nil will use the system's default output device (more below in the examples).
	
	hardwareBufferSize_(arg1)
	hardwareBufferSize
		
		The preferred hardware buffer size. If non-nil the server app will attempt to set the hardware buffer frame size. Not all sizes are valid. See the documentation of your audio hardware for details.
		Default value is nil.
				
	initialNodeID_(arg1)
	initialNodeID
		
		By default, the Server object in the client begins allocating node IDs at 1000, reserving 0-999 for "permanent" nodes. You may change this default here.
		
	inputStreamsEnabled_(arg1)
	inputStreamsEnabled
		
		A String which allows turning off input streams that you are not interested in on the audio device. If the string is "01100", for example, then only the second and third input streams on the device will be enabled. Turning off streams can reduce CPU load. The default value is nil.
		
	loadDefs_(arg1)
	loadDefs
		
		A Boolean indicating whether or not to load the synth definitions in synthdefs/ (or anywhere set in the environment variable SC_SYNTHDEF_PATH) at startup. The default is true.
				
	maxNodes_(arg1)
	maxNodes
		
		The maximum number of nodes. The default is 1024.
	
	maxSynthDefs_(arg1)
	maxSynthDefs
		
		The maximum number of synthdefs. The default is 1024.
		
	memSize_(arg1)
	memSize
		
		The number of kilobytes of real time memory allocated to the server. This memory is used to allocate synths and any memory that unit generators themselves allocate (for instance in the case of delay ugens which do not use buffers, such as CombN), and is separate from the memory used for buffers. Setting this too low is a common cause of 'exception in real time: alloc failed' errors. The default is 8192.
				
	numAudioBusChannels_(arg1)
	numAudioBusChannels
		
		The number of audio rate busses, which includes input and output busses. The default is 128.
	
	numBuffers_ (argNumBuffers)
	numBuffers
	
		The number of global sample buffers available. (See Buffer.) The default is 1024.
				
	numControlBusChannels_(arg1)
	numControlBusChannels
		
		The number of internal control rate busses. The default is 4096.
		
	numInputBusChannels_(arg1)
	numInputBusChannels
		
		The number of audio input bus channels. This need not correspond to the number of hardware inputs. The default is 8.
	
	numOutputBusChannels_(arg1)
	numOutputBusChannels
		
		The number of audio output bus channels. This need not correspond to the number of hardware outputs (this can be useful for instance in the case of recording). The default is 8.
				
	numRGens_(arg1)
	numRGens
		
		The number of seedable random number generators. The default is 64.
		
	numWireBufs_(arg1)
	numWireBufs
		
		The maximum number of buffers that are allocated to interconnect unit generators. (Not to be confused with the global sample buffers represented by Buffer.) This sets the limit of complexity of SynthDefs that can be loaded at runtime. This value will be automatically increased if a more complex def is loaded at startup, but it cannot be increased thereafter without rebooting. The default is 64.
	
	outputStreamsEnabled_(arg1)
	outputStreamsEnabled
		
		A String which allows turning off output streams that you are not interested in on the  audio device. If the string is "11000", for example, then only the first two output streams on the device will be enabled. Turning off streams can reduce CPU load.
				
	protocol_(arg1)
	protocol
		
		A Symbol representing the communications protocol. Either  \udp or \tcp. The default is udp.
				
	remoteControlVolume_(arg1)
	remoteControlVolume
		
		A Boolean indicating whether this server should allow its volume to be set remotely. The default value is false.
				
	sampleRate_(arg1)
	sampleRate
		
		The preferred sample rate. If non-nil the server app will attempt to set the sample rate of the hardware. The hardware has to support the sample rate that you choose.
		
	verbosity_(arg1)
	verbosity
		
		Controls the verbosity of server messages. A value of 0 is normal behaviour, -1 suppresses informational messages, and -2 suppresses informational and many error messages. The default is 0.
				
	zeroConf_(arg1)
	zeroConf
		
		A Boolean indication whether or not the server should publish its port using zero configuration networking, to facilitate network interaction. This is true by default; if you find unacceptable delays (beachballing) upon server boot, you can try setting this to false.
				
	restrictedPaths_(arg1)
	restrictedPaths
		
		Allows you to restrict the system paths in which scsynth is allowed to read/write files during running. A nil value (the default) means no restriction. Otherwise, set it as a string representing a single path.
				
				
Instance Methods

	
	asOptionsString (port)
	
		Returns a String specifying the options in the format required by the command-line scsynth app.
		port - The port number for the resulting server app. Default value is 57110.
		
	firstPrivateBus
	
		Returns the index of the first audio bus on this server which is not used by the input and output hardware.




Examples

// Get the local server's options

o = Server.local.options;

// Post the number of output channels

o.numOutputBusChannels.postln;

// Set them to a new number

o.numOutputBusChannels = 6; // The next time it boots, this will take effect

// specify a device

o.device ="MOTU Traveler"; 	// use a specific soundcard
o.device = nil;			// use the system default soundcard

// Create a new instance of ServerOptions

o = ServerOptions.new;

// Set the memory size to twice the default

o.memSize = 4096;

// Create a new Server on the local machine using o for its options

t = Server(\Local2, NetAddr("127.0.0.1", 57111), o);
t.makeWindow;
t.boot;
t.quit;



