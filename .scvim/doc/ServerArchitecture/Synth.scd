Synth					client-side representation of a synth node on the server

superclass: Node

A Synth is the client-side representation of a synth node on the server. A Synth represents a single sound producing unit.  What it does is defined in a SynthDef, which specifies what UGens are used and how they are patched together.  It also specifies what inputs and outputs the Synth will have. A SynthDef is thus a kind of fixed pattern, upon which Synths are be based. (Despite this, a given SynthDef can provide a surprising amount of variation.) For more detail on SynthDefs, their construction, and how to send them to a server, see the SynthDef help file.

For more on the important distinction between client objects and server nodes, see ClientVsServer. For information on creating nodes without using objects, see NodeMessaging.

N.B. Synth is a subclass of Node, and thus many of its most useful and important methods are documented in the Node help file.

Order of Execution

Order of execution is a crucial issue when creating Synths which interact with each other.

	sound ->  filter
	
If a sound is to be passed through a filter, the synth that does the filtering must be later in the order of execution than the synth which is its input.  The computer must calculate a buffer's worth of sound, and then the computer moves on to calculate a buffer's worth of the filtered version of that sound.

The actual interconnection between synth nodes is accomplished with buses. See Bus and Server-Architecture for details.

See the Order-of-execution help file for a more detailed discussion of this important topic.

Bundling

Some of the methods below have two versions: a regular one which sends its corresponding message to the server immediately, and one which returns the message in an Array so that it can be added to a bundle. It is also possible to capture the messages generated by the regular methods using Server's automated bundling capabilities. See Server and bundledCommands for more details.

Accessing Instance Variables

	defName - Returns the name of this Synth's SynthDef.
	
For other instance variables see Node.

Creation with Immediate Instantiation on the Server
	

	*new(defName, args: [ arg1, value1, ... argN, valueN  ], target, addAction)
		
		Create and return a new Synth object, and immediately start the corresponding synth node on the server.
		
		defName - A String or Symbol specifying the name of the SynthDef to use in creating the Synth.
		
		args - An optional array specifying initial values for the SynthDef's arguments (controls). These are specified in pairs of control name or index and value. If names are used they can be specified with either Strings or Symbols. e.g. [\frequency, 440, \amplitude, 1, ...]
			Values that are arrays are sent using  OSC array type-tags ($[ and $]).  These values will 
			be assigned to subsequent controls.
		
		target - A target for this Synth. If target is not a Group or Synth, it will be converted as follows: If it is a Server, it will be converted to the default_group of that server. If it is nil, to the default_group of the default Server. If it is an integer, it is created relative to a group with that id. 
			Note: A Synth is not a valid target for \addToHead and \addToTail.
		
		addAction - one of the following Symbols:		
			\addToHead 	- (the default) add at the head of the group specified by target
			\addToTail 	- add at the tail of the group specified by target
			\addAfter 	- add immediately after target in its server's node order
			\addBefore 	- add immediately before target in its server's node order
			\addReplace 	- replace target and take its place in its server's node order
			
		s.boot;
		// create a Synth at the head of the default Server's default group
		// based on the SynthDef "default"
		x = Synth.new("default"); 
		s.queryAllNodes; // note the default group (ID 1)
		x.free;

		// Using an arrayed control
		(
		x = SynthDef("help-synth", {| freq = #[440, 450, 460], out = 0 |
			Out.ar(out, Mix(SinOsc.ar(freq, 0, 0.1)));
		});
		x = x.play(s, [freq: [500,501,510] ]);
		)
		x.set(\freq, [1,2,3] * 400 + [1,2,3], \out, 1); // two pairs
		x.set(\freq, [3] * 400 + [1,2,3], \out, 1); // two pairs
		x.set(0, [660, 680, 720], 1, 0); // freq is the first argument, so it's index is 0. out is index 1.
		x.free;

	*newPaused(defName, args: [ arg1, value1,... argN, valueN  ], target, addAction)
		
		As *new above, but creates a node which is paused. This can be started by calling run on it.
		
		s.boot;
		x = Synth.newPaused("default"); 
		s.queryAllNodes; // see I'm here
		x.run; // true is the default
		x.run(false); // pause me again
		x.free;
		
	*grain(defName, args: [ arg1, value1, ... argN, valueN  ], target, addAction)
	
		A convenience method which will create a synth node with an node ID of -1. Such a node cannot be messaged after creation. As such this method does not create an object, and returns nil. For details of its arguments see *new above.
		
		
The following convenience methods correspond to the add actions of Synth.new:

	*after(aNode, defName, args)
		
		Create and return a Synth and add it immediately after aNode.

	*before(aNode, defName, args)
		
		Create and return a Synth and add it immediately before aNode.

	*head(aGroup, defName, args)
	
		Create and return a Synth. If aGroup is a Group add it at the head of that group. If it is a Server, add it at the head of the default_group of that server. If it is nil, add it at the head of the default_group of the default server. If it is an integer, it is created relative to a group with that id. 
				
	*tail(aGroup, defName, args)
		
		Create and return a Synth. If aGroup is a Group add it at the tail of that group. If it is a Server, add it at the tail of the default_group of that server. If it is nil, add it at the tail of the default_group of the the default server. If it is an integer, it is created relative to a group with that id. 
		
	*replace(nodeToReplace, defName, args)
		
		Create and return a Synth and use it to replace nodeToReplace, taking its place in its server's node order.
		
Creation without Instantiation on the Server

For use in message bundles it is also possible to create a Synth object in the client app without immediately creating a synth node on the server. Once done one can call methods which create messages to add to a bundle, which when sent to the server will instantiate the synth.

	*basicNew(defName, server, nodeID)
	
		Create and return a Synth object without creating a synth node on the server. 
		
		defName - A String or Symbol specifying the name of the SynthDef to use in creating the Synth.
		
		server - An optional instance of Server. If nil this will default to the default Server. 
		
		nodeID - An optional node ID number. If not supplied one will be generated by the Server's NodeIDAllocator. Normally you should not need to supply an ID.
		
		s.boot;
		x = Synth.basicNew("default", s); // Create without sending
		s.sendBundle(nil, x.newMsg;); // Now send a message; create at the head of s' default group
		s.queryAllNodes;
		x.free;
		
	newMsg(target, args, addAction)
	
		Returns a message of the type s_new which can be bundled. When sent to the server this message will instantiate this synth. If target is nil, it will default to the default_group of the Server specified in *basicNew when this Synth was created. The default addAction is \addToHead. (See *new above for details of addActions and args.)
		
	addToHeadMsg(aGroup, args)
	
		Returns a message of the type s_new which can be bundled. When sent to the server this message will instantiate this synth. If aGroup is a Group it will be added at the head of that group. If it is nil, it will be added at the head of the default_group of this Synth's server (as specified when *basicNew was called). See *new above for details on args.
		
	addToTailMsg(aGroup, args)
	
		Returns a message of the type s_new which can be bundled. When sent to the server this message will instantiate this synth. If aGroup is a Group it will be added at the tail of that group. If it is nil, it will be added at the tail of the default_group of this Synth's server (as specified when *basicNew was called). See *new above for details on args.
		
	addBeforeMsg(aNode, args)
	
		Returns a message of the type s_new which can be bundled. When sent to the server this message will instantiate this synth, immediately before aNode. See *new above for details on args.
		
	addAfterMsg(aNode, args)
	
		Returns a message of the type s_new which can be bundled. When sent to the server this message will instantiate this synth, immediately after aNode. See *new above for details on args.
		
	addReplaceMsg(nodeToReplace, args)
	
		Returns a message of the type s_new which can be bundled. When sent to the server this message will instantiate this synth, replacing nodeToReplace in the server's node order. See *new above for details on args.

Control

For further methods of controlling Synths (set, map, etc.), see the Node helpfile.

	get(index, action)
	getMsg(index)
		
		Query the server for the current value of a Control (argument). index is a control name or index. action is a Function which will be evaluated with the value passed as an argument when the reply is received.
		
		s.boot;
		(
		SynthDef("help-Synth-get", { arg freq = 440; 
			Out.ar(0, SinOsc.ar(freq, 0, 0.1));
		}).add;
		)
		x = Synth("help-Synth-get");
		x.set(\freq, 220 + 440.rand);
		x.get(\freq, { arg value; ("freq is now:" + value + "Hz").postln; });
		x.free;
		
	getn(index, count, action)
	getnMsg(index, count)
		
		Query the server for the current values of a sequential range of Controls (arguments). index is a control name or index. count is the number of sequential controls to query, starting at index. action is a Function which will be evaluated with an Array containing the values passed as an argument when the reply is received.	


Examples


// boot the default server
s = Server.default; // just to be sure
s.boot;


(
// send a synth def to server
SynthDef("tpulse", { arg out = 0,freq = 700, sawFreq = 440.0; 
	Out.ar(out, SyncSaw.ar(freq, sawFreq, 0.1));
}).add;
)

// Here the defaults for *new will result in a Synth at the head of the default group
// of the default Server. This will use the SynthDef's default arguments;
y = Synth.new("tpulse"); 
y.free;

// The same done explicitly
y = Synth.new("tpulse", nil, s, \addToHead); 
y.free;

// With some arguments
y = Synth.new("tpulse", [\freq, 350, \sawFreq, 220]);
y.free;

// make a new synth
y = Synth("tpulse");

// pause
y.run(false);

y.run(true);

// set a control by argument name
y.set("freq", 200);

// or by index
y.set(2, 100.0);

// modulate out to bus number 1 (the right speaker)
y.set(0, 1);

//  multiple set commands in one message
y.set("out", 0, "freq",300);

// free the synth from the server
y.free;



//////////// Filtering

(
// first collect some things to play with
SynthDef("moto-rev", { arg out=0;
	var x;
	x = RLPF.ar(LFPulse.ar(SinOsc.kr(0.2, 0, 10, 21), [0,0.1], 0.1), 
		100, 0.1).clip2(0.4);
	Out.ar(out, x);
}).add;

SynthDef("bubbles", { arg out=0;
	var f, zout;
	f = LFSaw.kr(0.4, 0, 24, LFSaw.kr([8,7.23], 0, 3, 80)).midicps; 
	zout = CombN.ar(SinOsc.ar(f, 0, 0.04), 0.2, 0.2, 4); // echoing sine wave
	Out.ar(out, zout);
}).add;


SynthDef("rlpf",{ arg out=0,ffreq=600,rq=0.1;
	ReplaceOut.ar( out, RLPF.ar( In.ar(out), ffreq,rq) )
}).add;


SynthDef("wah", { arg out, rate = 1.5, cfreq = 1400, mfreq = 1200, rq=0.1;
	var zin, zout;

	zin = In.ar(out, 2);
	cfreq = Lag3.kr(cfreq, 0.1);
	mfreq = Lag3.kr(mfreq, 0.1);
	rq   = Ramp.kr(rq, 0.1);
	zout = RLPF.ar(zin, LFNoise1.kr(rate, mfreq, cfreq), rq, 10).distort 
					* 0.15;

	// replace the incoming bus with the effected version
	ReplaceOut.ar( out , zout ); 
	
}).add;

SynthDef("modulate",{ arg out = 0, freq = 1, center = 440, plusMinus = 110;
	Out.kr(out, SinOsc.kr(freq, 0, plusMinus, center));
}).add;
)

// execute these one at a time

// y is playing on bus 0
y = Synth("moto-rev",["out",0]);

// z is reading from bus 0 and replacing that; It must be *after* y
z = Synth.after(y,"wah",["out",0]);

// stop the wah-ing
z.run(false);

// resume the wah-ing
z.run(true);

// add a rlpf after that, reading and writing to the same buss
x = Synth.after(z,"rlpf",["out",0]);

// create another rlpf after x
t = Synth.after(x,"rlpf",["out",0]);

x.set("ffreq", 400);

x.set(\ffreq, 800); // Symbols work for control names too

// Now let's modulate x's ffreq arg
// First get a control Bus
b = Bus.control(s, 1);

// now the modulator, *before* x
m = Synth.before(x, "modulate", [\out, b]);

// now map x's ffreq to b
x.map("ffreq", b);

m.set("freq", 4, "plusMinus", 20);

x.free;
z.free;
m.free;

// now place another synth after y, on the same bus
// they both write to the buss, adding their outputs
r = Synth.after(y,"bubbles",["out",0]);

y.free;

r.free;

// look at the Server window
// still see 4 Ugens and 1 synth?
// you can't hear me, but don't forget to free me
t.free;










