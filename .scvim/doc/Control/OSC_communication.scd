OSC_communication

OSC communication between programs is often done to send messages from one application to another, possibly with the applications running on different computers. In SuperCollider this communication is done by creating a NetAddr of the target application and creating an OSCresponderNode to listen to another application. The underlying protocol of OSC is either UDP or TCP.



Sending OSC to another application
To establish communication to another application, you need to know on which port that application is listening. For example if an application is listening on port 7771, we can create a NetAddr and send it a message:

	b = NetAddr.new("127.0.0.1", 7771); // create the NetAddr
	b.sendMsg("/hello", "there");// send the application the message "hello" with the parameter "there"


Receiving OSC from another application

To listen to another application, that application needs to send a message to the port SuperCollider is listening on, normally this is 57120, but it can change. The current port can be retrieved with
	
	NetAddr.langPort; // retrieve the current port SC is listening to

Or you can retrieve both the IP and the port with:

	NetAddr.localAddr; // retrieve the current IP and port

To listen to incoming messages, an OSCresponderNode needs to be created in SuperCollider. If the sending application has a fixed port it sends message from, you can set the OSCresponderNode to listen only to messages coming from that IP and port:

	n = NetAddr.new("127.0.0.1", 7771); // create the NetAddr
	// create the OSCresponderNode
	o = OSCresponderNode.new(n, "/goodbye", { arg time, resp, msg; [time,resp].postln; } ).add; 
	o.remove; // remove the OSCresponderNode when you are done.

Why OSCresponderNode rather than OSCresponder? If you create two OSCresponders with the same message name -- e.g. "/goodbye" above -- the second OSCresponder will overwrite the first. You can have only one OSCresponder per message name at the same time. OSCresponderNodes do not have that restriction -- many OSCresponderNodes with the same name can coexist. (This also means you have to keep track of your OSCresponderNodes to remove them when they are no longer needed.) See also OSCpathResponder.


Receiving from an application that is sending from a variable port

Some applications (notably Pd and Max) do not send messages from a fixed port, but instead use a different port each time they send out a message. In that case the OSCresponderNode needs to be set up, so that it listens to messages coming from anywhere:

	o = OSCresponderNode.new(nil, "/goodbye", { arg time, resp, msg; [time,resp].postln; } ).add; // create the OSCresponderNode
	o.remove; // remove the OSCresponderNode when you are done.




Testing incoming traffic
All incoming OSC messages call the message recvOSCmessage, or recvOSCbundle in Main. 
To see the incoming traffic, one may set a function called recvOSCfunc in Main:

// post all incoming traffic except the server status messages
(
thisProcess.recvOSCfunc = { |time, addr, msg| 
	if(msg[0] != '/status.reply') {
		"time: % sender: %\nmessage: %\n".postf(time, addr, msg); 
	}  
}
);

// stop posting.
thisProcess.recvOSCfunc = nil;



