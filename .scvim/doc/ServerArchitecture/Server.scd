Server			object representing an sc-server application

superclass: Model

A Server object is the client-side representation of a server app and is used to control the app from the SuperCollider language application. (See ClientVsServer for more details on the distinction.) It forwards osc-messages and has a number of allocators that keep track of IDs for nodes, buses and buffers. The server application is a commandline program, so all commands apart from osc-messages are unix commands. The server application represented by a Server object might be running on the same machine as the client (in the same address space as the language application or separately; see below), or it may be running on a remote machine. 

Most of a Server's options are contolled through its instance of ServerOptions. See the ServerOptions helpfile for more detail.

Paths

Server apps running on the local machine have two unix environment variables: SC_SYNTHDEF_PATH and SC_PLUGIN_PATH. These indicate directories of synthdefs and ugen plugins that will be loaded at startup. These are in addition to the default synthdef/ and plugin/ directories which are hard-coded. These can be set within SC using the getenv and setenv methods of class String.

// all defs in this directory will be loaded when a local server boots
"SC_SYNTHDEF_PATH".setenv("~/scwork/".standardizePath); 
"echo $SC_SYNTHDEF_PATH".unixCmd;

The default group

When a Server is booted there is a top level group with an ID of 0 that defines the root of the node tree. (This is represented by a subclass of Group: RootNode.) If the server app was booted from within SCLang (as opposed to from the command line) the method initTree will be called automatically after booting. This will also create a default_group with an ID of 1, which is the default group for all Nodes when using object style. This provides a predictable basic node tree so that methods such as Server-scope, Server-record, etc. can function without running into order of execution problems. The default group is persistent, i.e. it is recreated after a reboot, pressing cmd-., etc. See RootNode and default_group for more information. Note that if a Server has been booted from the command line you must call initTree manually in order to initialize the default group, if you want it. See initTree below.

Local vs. Internal

In general, when working with a single machine one will probably be using one of two Server objects which are created at startup and stored in the class variables local and internal. By default two GUI windows are created to control these. The difference between the two is that the local server runs as a separate application with its own address space, and the internal server runs within the same space as the language/client app. The internal server has the advantage of being able to access shared memory, thus allowing for things like scope windows (see below) and SharedIn/SharedOut. It also minimizes messaging latency. The local server, and any other server apps running on your local machine, have the advantage that if the language app crashes, it (and thus possibly your piece) will continue to run. It is thus an inherently more robust arrangement.

The default Server

There is always a default Server, which is stored in the class variable default. Any Synths or Groups created without a target will be created on the default server. At startup this is set to be the local server (see above), but can be set to be any Server.

Class Methods

*new(name, addr, options, clientID)
	
	name - a symbol;  each Server object is stored in one global classvariable under its name.
	addr - an optional instance of NetAddr, providing host and port. The default is the localhost address 			using port 57110; the same as the local server.
	options - an optional instance of ServerOptions. If nil, an instance of ServerOptions will be created, using 			the default values.
	clientID - an integer. In multi client situations, every client can be given a separate nodeID range. 
			The default is 0.


*local - returns the local server, stored in classvar local (created already on initClass)

*internal - returns the internal server, stored in classvar local (created already on initClass)

*default - returns the default server. By default this is the local server (see above)

*default_(aServer) - sets the default Server to be aServer. This will also assign aServer to the interpreter variable 's'.
	
	Server.default = Server.internal; // set the internal Server to be the default Server
	s.postln; // internal

*all - the set of all servers.	

*allRunningServers - the set of all running servers.	

*quitAll - quit all registered servers
		
*killAll - query the system for any sc-server apps and hard quit them
		
*freeAll - free all nodes in all registered servers	

Instance Methods
						
sendMsg(arg1, arg2, arg3, ... argN) - send an osc message to the server.
		
	s.sendMsg("/s_new", "default", s.nextNodeID, 0, 1);

sendBundle(time, array1, array1, array1, ... arrayN) - send an osc bundle to the server. Since the network may have irregular performance, time allows for the bundle to be evaluated at a specified point in the future. Thus all messages are synchronous relative to each other, but delayed by a constant offset. If such a bundle arrives late, the server replies with a late message but still evaluates it.				
	
	s.sendBundle(0.2, ["/s_new", "default", x = s.nextNodeID, 0, 1], ["/n_set", x, "freq", 500]);
		
sendRaw(aRawArray)

listSendMsg([arg1, arg2, arg3, ... argN]) - as sendMsg, but takes an array as argument.

listSendBundle(time, [array1, array1, array1, ... arrayN]) - as sendBundle, but takes an array as argument. This allows you to collect messages in an array and then send them.

	s.listSendBundle(0.2, [["/s_new", "default", x = s.nextNodeID, 0, 1], 
		["/n_set", x, "freq", 600]]);
		
sendSynthDef(name, dir) - send a synthDef to the server that was written in a local directory
		
loadSynthDef(name, completionMsg, dir) - load a synthDef that resides in the remote directory

loadDirectory(dir, completionMsg) - load all the SynthDefs in the directory dir. dir is a String which is a valid path.
		
nextNodeID - get a unique nodeID. 

nextPermNodeID - get a permanent node ID. This node ID is in a reserved range and will be held until you explicitly free it.

freePermNodeID - free a permanent node ID for later reuse.
	
wait(responseName) - this can be used within a Routine to wait for a server reply

waitForBoot(func, limit) - evaluate the function func as soon as the server has booted. If it is running, it is evaluated immediately. If it is not running, boot the server and evaluate the function. limit indicates the maximum times to try. (5 times/sec)

doWhenBooted(func, limit) - evaluate the function as soon as the server has booted. If it is running, it is evaluated immediately. limit is the maximum number of times to try. (5 times/sec)

boot(startAliveThread) - boot the remote server, create new allocators. startAliveThread: if set to false, the server is not queried to give information for the window. N.B. You cannot locally boot a server app on a remote machine.

quit - quit the server application
		
reboot - quit and restart the server application
		
freeAll - free all nodes in this server 
		
status - query the server status

notify(flag) - server sends notifications, for example if a node was created, a 'tr' message from a SendTrig, or a /done action. if flag is set to false, these messages are not sent. The default is true.

dumpOSC(code)
	code:
		0 - turn dumping OFF.
		1 - print the parsed contents of the message.
		2 - print the contents in hexadecimal.
		3 - print both the parsed and hexadecimal representations of the contents.
		
queryAllNodes - Post a representation of this Server's current node tree to the post window. Very helpful for debugging. For local servers this uses g_dumpTree and for remote g_queryTree. See Group and Server-Command-Reference for more info.
	
	s.boot;
	s.queryAllNodes; // note the root node (ID 0) and the default group (ID 1)
	s.quit;
	
ping(numberOfTimes, waitBewteen, completionFunction)
		measure the time between server and client, which may vary. the completionFunction is
		evaluated after numberOfTimes and is passed the resulting maximum. 


options - returns this Server's ServerOptions object. Changes take effect when the server is rebooted.

options_(aServerOptions) - sets this Server's ServerOptions object. Changes take effect when the server is rebooted.

defaultGroup - returns this Server's default group.
	
volume - an instance of Volume that runs after the defualt group.

volume_(level) - sets the Volume of the Server's output to level. Level is in db.

mute - mute the server's output. This can also be toggled from the Server window with the 'm' key.

unmute - unmute the server. This can also be toggled from the Server window with the 'm' key.

reorder(nodeList, target, addAction) - Move the nodes in nodeList to the location specified by target and addAction, placing them there in the order indicated by nodeList. Any nodes which have already been freed will be skipped. Passing nil for target and addAction will result in the location being the head of the default group.
	
	g = Group.new;
	x = Array.fill(5, {Synth(\default)});
	s.queryAllNodes;
	s.reorder(x, g, \addToTail);
	s.queryAllNodes;

Automatic Message Bundling

Server provides support for automatically bundling messages. This is quite convenient in object style, and ensures synchronous execution. See also bundledCommands.

makeBundle(time, func, bundle) - The Function func is evaluated, and all OSC messages generated by it are deferred and added to a bundle. This method returns the bundle so that it can be further used if needed. If time is set to nil or a number the bundle will be automatically sent and executed after the corresponding delay in seconds. If time is set to false the bundle will not be sent.  bundle allows you to pass in a preexisting bundle and continue adding to it. If an error is encountered while evaluating func this method will throw an Error and stop message deferral. Calling sync inside func will split the bundle and wait for asynchronous actions to complete before continuing.

	s.boot;
	(
	// send a synth def to server
	SynthDef("tpulse", { arg out=0,freq=700,sawFreq=440.0;
		Out.ar(out, SyncSaw.ar(freq,  sawFreq,0.1) )
	}).add;
	)
	
	// all OSC commands generated in the function contained below will be added to a bundle
	// and executed simultaneously after 2 seconds.
	(
	s.makeBundle(2.0, {
		x = Synth.new("tpulse");
		a = Bus.control.set(440);
		x.map(\freq, a);
	});
	)
	x.free;
	
	// don't send
	(
	b = s.makeBundle(false, { 	
		x = { PinkNoise.ar(0.1) * In.kr(0, 1); }.play;
	});
	)
	// now pass b as a pre-existing bundle, and start both synths synchronously
	(
	s.makeBundle(nil, { // nil executes ASAP
		y = { SinOsc.kr(0.2).abs }.play(x, 0, 0, \addBefore); // sine envelope
	}, b);
	)
	x.free; y.free;
	
	// Throw an Error
	(
	try {
		s.makeBundle(nil, {
			s.farkermartin;
		});
	} { |error|
		("Look Ma, normal operations resume even though:\n" + error.errorString).postln; 
		x = { FSinOsc.ar(440, 0, 0.2) }.play; // This works fine
	}
	)
	x.free;
	
	// use sync
	(
	s.makeBundle(nil, {
		b = Buffer.read(s, "sounds/a11wlk01.wav");
		s.sync; // wait until load is done and then send the rest of the bundle
		x = { PlayBuf.ar(1, b) * 0.5 }.play;
	});
	)
	x.free; b.free;

bind(func) - Just as in makeBundle, the Function func is evaluated, and all OSC messages generated by it are deferred and added to a bundle, which is sent to the server, using the server default latency.

	// example
	(
	s.bind {
		a = { |freq=100| SinOsc.ar(freq, LFTri.ar(freq)) * 0.2 }.play;
		a.set(\freq, 400);
	}
	)

Shared Controls

The internal server has a number of shared control buses. Their values can be set or polled using the methods below.

getSharedControl(num) - get the current value of a shared control bus. num is the index of the bus to poll. This command is synchronous and only works with the internal server.

setSharedControl(num, value) - set the current value of a shared control bus to value. num is the index of the bus to set. This command is synchronous and only works with the internal server.

allocSharedControls(numControls) - set the number of shared control buses. Must be done before the internal server is booted. The default is 1024.

Persistent Node Trees

The class ServerTree can be used to store functions which will be evaluated after the server is booted, after all nodes are freed, and after cmd-. is pressed. This allows, for example, for one to create a persistent basic node structure. ServerTree is evaluated in the method initTree after the default group is created, so its existence can be relied upon.

initTree - This method initializes the default_group and runs ServerTree. This method is called automatically when you boot a Server from the language. N.B. If you started a server app from the command line you will have to call initTree manually if you need this functionality.

	s.quit;
	f = {Group.new(s.defaultGroup); "Other code can be evaluated too".postln;};
	ServerTree.add(f);
	s.boot;
	s.queryAllNodes; // note the group within the default group
	ServerTree.remove(f);

ServerBoot and ServerQuit provide similar functionality at boot and quit times.

Keyboard Shortcuts

when a server window is in focus, these shortcuts can be used:

space:	start the server
d		toggle dumpOSC
n		post a representation of the node tree
N		post a representation of the node tree and the current control values of any synths
s		scope (internal server only)

Scope Support

This only works with the internal server, and currently only on OSX.
see Stethoscope for further details.

scope(numChannels, index, bufsize, zoom, rate) - Open a scope window showing the output of the Server. 
		
numChannels - the number of channels to be scoped out. The default is this server's options' numOutputBusChannels.
index - the first channel to be output. The default is 0.
bufsize - the size of the buffer for the ScopeView. The default is 4096.
zoom - a zoom value for the scope's X axis. Larger values show more. The default is 1.
rate - whether to display audio or control rate buses (either \audio or \control)

Recording Support

The following methods are for convenience use. For recording with sample accurate start and stop times you should make your own nodes. See the DiskOut helpfile for more info. For non-realtime recording, see the Non-Realtime-Synthesis helpfile. 

This functionality is also available through the recording button on the server windows. Pressing it once calls record, and pressing it again calls stopRecording (see below). When doing so the file created will be in your recordings folder and be named for the current date and time. The default location of the recordings folder varies from platform to platform but is always stored in thisProcess.platform.recordingsDir. Setting this variable allows you to change the default.

NOTE: record creates the recording synth after the Server's default group and uses In.ar. Thus if you add nodes after the recording synth their output will not be captured. To avoid this, either use Node objects (which use the default node as their target) or (when using messaging style) use a target nodeID of 1 .

s.sendMsg("/s_new", "default", s.nextNodeID, 1,1);

For more detail on this subject see Order-of-execution, default_group, and NodeMessaging.

prepareForRecord(path) - Allocates the necessary buffer, etc. for recording the server's output. (See record below.) path is a String representing the path and name of the output file. If you do not specify a path than a file will be created in your recordings folder (see the note above on this) called SC_thisDateAndTime. Changes to the header or sample format, or to the number of channels must be made BEFORE calling this.
		
record(path) - Starts or resumes recording the output. If you have not called prepareForRecord first (see above) then it will be invoked for you (but that adds a slight delay before recording starts for real). The path argument is optional and is passed to prepareForRecord (above).
			
pauseRecording - Pauses recording. Can be resumed by executing record again.
		
stopRecording - Stops recording, closes the file, and frees the associated resources. You must call this when finished recording or the output file will be unusable. Cmd-. while recording has the same effect.
		
recordNode - Returns the current recording synth so that it can be used as a target. This should only be necessary for nodes which are not created in the default group.


The following setter methods have corresponding getters. See SoundFile for information on the various sample and header formats.	Not all sample and header formats are compatible.

recChannels_(anInteger) - Sets the number of channels to record. The default is two. Must be called BEFORE prepareForRecord.

recHeaderFormat_(aString) - Sets the header format of the output file. The default is "aiff". Must be called BEFORE prepareForRecord.
	
recSampleFormat_(aString) - Sets the sample format of the output file. The default is "float". Must be called BEFORE prepareForRecord.

Note that the sampling rate of the ouput file will be the same as that of the server app. This can be set using the Server's ServerOptions.


s.boot; // start the server

// something to record
(
SynthDef("bubbles", {
	var f, zout;
	f = LFSaw.kr(0.4, 0, 24, LFSaw.kr([8,7.23], 0, 3, 80)).midicps; // glissando function
	zout = CombN.ar(SinOsc.ar(f, 0, 0.04), 0.2, 0.2, 4); // echoing sine wave
	Out.ar(0, zout);
}).add;
SynthDef("tpulse", { arg out=0,freq=700,sawFreq=440.0; 
	Out.ar(out, SyncSaw.ar(freq,  sawFreq,0.1) ) 
}).add;

)

x = Synth.new("bubbles");

s.prepareForRecord; // you have to call this first

s.record;

s.pauseRecording; // pausable

s.record // start again

s.stopRecording; // this closes the file and deallocates the buffer recording node, etc.

x.free; // stop the synths

// look in your recordings folder and you'll find a file named for this date and time

Asynchronous Commands

Server provides support for waiting on the completion of asynchronous OSC commands such as reading or writing soundfiles. N.B. The following methods must be called from within a running Routine. Explicitly passing in a Condition allows multiple elements to depend on different conditions. The examples below should make clear how all this works.

bootSync(condition) - Boot the Server and wait until it has completed before resuming the thread. condition is an optional instance of Condition used for evaluating this.

sendMsgSync(condition, args) - Send the following message to the  wait until it has completed before resuming the thread. condition is an optional instance of Condition used for evaluating this. args should be one or more valid OSC messages.

sync(condition, bundles, latency) - Send a /sync message to the server, which will replie with the message /synced when all pending asynchronous commands have been completed. condition is an optional instance of Condition used for evaluating this. This may be slightly less safe then sendMsgSync under UDP on a wide area network, as packets may arrive out of order, but on a local network should be okay. Under TCP this should always be safe. bundles is one or more OSC messages which will be bundled before the sync message (thus ensuring that they will arrive before the /sync message). latency allows for the message to be evaluated at a specific point in the future.

(
Routine.run {
	var c;

	// create a condition variable to control execution of the Routine
	c = Condition.new;
	
	s.bootSync(c);
	\BOOTED.postln;
		
	s.sendMsgSync(c, "/b_alloc", 0, 44100, 2);
	s.sendMsgSync(c, "/b_alloc", 1, 44100, 2);
	s.sendMsgSync(c, "/b_alloc", 2, 44100, 2);
	\b_alloc_DONE.postln;
};
)

(
Routine.run {
	var c;

	// create a condition variable to control execution of the Routine
	c = Condition.new;
	
	s.bootSync(c);
	\BOOTED.postln;
		
	s.sendMsg("/b_alloc", 0, 44100, 2);
	s.sendMsg("/b_alloc", 1, 44100, 2);
	s.sendMsg("/b_alloc", 2, 44100, 2);
	s.sync(c);
	\b_alloc_DONE.postln;
};
)









