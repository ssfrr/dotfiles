OSCBundle			network bundle object


superclass: Object

a bundle object that allows to add preparation messages for async processes.
if this feature is not needed, a list object can be used instead.


add(msg)				add an osc message to the bundle

addAll(array)			add an array of osc messages to the bundle

addPrepare(msg)		add a preparation osc message, which is sent
					before the bundle is sent.



send(server, delta)	send the bundle to a server.  If preparation messages are given,
					they are sent, the process waits for their reception abd then sends the
					bundle.

schedSend(server, clock, quant) 
					like send, but the sending is synced to a given clock (TempoClock) to the next beat.
					quant can be a pair of values: [quant, offset]



// example


	// create a new, empty instance
	a = OSCBundle.new; 
	
	// a synthdef that needs to be sent to the server, an operation that is asynchronous,
	// i.e. we have to wait until it is finished.
	x = SynthDef("test", { OffsetOut.ar(0, BPF.ar(Impulse.ar(4) * 10, Rand(9000, 1000), 0.1)) });
	// this is why addPrepare is used.
	a.addPrepare(["/d_recv", x.asBytes]);
	// add is used with synchronous operations, like starting synths.
	a.add(["/s_new", "test", -1]);

	// the bundle has now the synchronous separated from the asynchronous bundles:
	a.messages;
	a.preparationMessages;
	
	// this can be simply sent - the bundle takes care of the server client communication
	// like waiting for the synthdef to be loaded. the synth is started when the preparation
	// is finished.
	
	s.boot; // boot the server
	a.send(s);

	s.freeAll; // free all nodes on the server

	// scheduled sending: the synths are started on the next beat.

	a.schedSend(s, TempoClock.default, 1); 	
	a.schedSend(s, TempoClock.default, 1);		
	a.schedSend(s, TempoClock.default, 1);
	
	s.freeAll; // free all nodes on the server

	// the bundle can contain several preparation messages and messages at a time.
	// the proparationMessages are sent first and only when they are all completed,
	// the other bundles are sent.
	// the bundle can also be reused, if there is no specific allocated buffers/node ids.		
	


