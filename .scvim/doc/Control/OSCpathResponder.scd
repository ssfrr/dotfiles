OSCpathResponder			client side responder

superclass: OSCresponder

Register a function to be called upon receiving a  command with a specific path.

Other applications sending messages to SuperCollider should distinguish between sending messages to the server or the language. Server messages are documented in the Server-Command-Reference and should be sent to the server's port - s.addr.port - which is 57110 by default. Messages sent to the server will not be processed by any OSCresponder in the language.

Messages from external clients that should be processed by OSCresponders must be sent to the language port, 57120 by default. Use NetAddr.langPort to confirm which port the SuperCollider language is listening on.

See OSC_communication for more details.

	
	*new(addr, cmdName, action);
		
		addr
			an instance of NetAddr, usually obtained from your server:  server-addr
			an address of nil will respond to messages from anywhere.
		
		cmdName
			a command path, such as ['\c_set', bus index]
		
		action 
			a function that will be evaluated when a cmd of that name is received from addr.
			args: time, theResponder, message
			note that OSCresponderNode evaluates its function in the system process.
			in order to access the application process (e.g. for GUI access ) use { ... }.defer;

Command paths

	OSC commands sometimes include additional parameters to specify the right responder. 

	For example  /tr commands, which are generated  on the server by the SendTrig Ugen create
	an OSC packet consisting of:						[ /tr,  nodeID, triggerID, value]
	This array actually specifies the source of value : 		[ /tr, nodeID, triggerID].
	We will refer to that array as a command path.
 
	To create an OSCpathResponder for a specific trigger, the cmdName parameter is simply replaced by 
	the complete command path.  

Path defaults

	Any element of the command path array can be set to nil to create a responder that will 
	handle multiple command paths.

	For example, setting the commandpath = ['/tr', nil, triggerID]  makes a responder that 
	responds to /tr messages from any Synth but with a specific triggerID.
	/tr messages from one Synth but with any triggerID.



//Here is an example:

s.boot;

(
	var s, commandpath, response, aSynth, nodeID, triggerID;
	s = Server.local;
	s.boot;
	triggerID = 1;
	aSynth = { arg freq = 1, triggerID = 1; SendTrig.kr(SinOsc.kr(freq), triggerID, 666); }.play;
	nodeID = aSynth.nodeID;
	commandpath = ['/tr', nodeID, triggerID];
	response = { arg time, responder, message; message.postln };

	o = OSCpathResponder(s.addr, commandpath, response);
	o.add;

)

// switch on and off:
o.remove;
o.add;



