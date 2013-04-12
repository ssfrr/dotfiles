SendTrig			send a value from the server to all notified clients

On receiving a trigger (a non-positive to positive transition), send a trigger message from the server back to the client.

	SendTrig.kr( input, id, value )
		input 	the trigger
		id 		an integer that will be passed with the trigger message.
					this is useful if you have more than one SendTrig in a SynthDef
		value 	a UGen or float that will be polled at the time of trigger,
					and its value passed with the trigger message
					
The nodeID is the node that is sending the trigger. The triggerID and value are determined by inputs to the SendTrig unit generator which is the originator of this message.

The trigger message sent back to the client is this:				
/tr						a trigger message
	int - node ID
	int - trigger ID
	float - trigger value

This command is the mechanism that synths can use to trigger events in clients. A message is sent to all notified clients. see Server. For sending an array of values, or an arbitrary reply command, see SendReply





{ SendTrig.kr(Dust.kr(1.0),0,0.9) }.play;

// register to receive this message
(
OSCresponder(s.addr,'/tr',{ arg time,responder,msg;
	[time,responder,msg].postln;
}).add
);



