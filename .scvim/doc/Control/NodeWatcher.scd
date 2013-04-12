NodeWatcher		notify sc-lang side node objects of their server sided state


Node instances (Synths and Groups) can be registered with the NodeWatcher.  
It watches for server node status messages:
		
		n_go 
		n_end
		n_off
		n_on
		

and sets the isPlaying and isRunning variables on the Node instance accordingly.  A Node that ends is unregistered at that time.

In some cases this can be an invaluable service.  The use of an independant object to maintain the state keeps the implementation of the Node classes simple. 
Note that server notification should be on. (this is default. see: aServer.notify)

	the most common use: 
		NodeWatcher.register(aNode);


	*new(server)
		create a new instance listening to the server's address

	*newFrom(server)
		 create a new instance listening to the server's address
		 if there is one present already return that one
	
	*register(aNode, assumePlaying)
		aNode can be a Group or a Synth.
		the NodeWatcher is created internally
		assumePlaying: if true, the node's isPlaying field is set to true
	
	*unregister(aNode)
		remove the node from the list of nodes.
		this happens also when a node is freed.
	
	start
		add the OSCresponderNode to listen to the address
	
	stop
		remove the OSCresponderNode to stop listen to the address 
	


// example:

	(
	b = s.makeBundle(false, {
		a = Group.new(s); //create a node object
		NodeWatcher.register(a); // register before creating on the server
	});
	)
	a.isPlaying;
	s.listSendBundle(nil, b); //start the node on the server
	a.isPlaying;
	a.isRunning;
	a.run(false);
	a.isRunning;
	s.freeAll; //free all nodes
	a.isPlaying;
	a.isRunning;
	


DebugNodeWatcher

	for debugging, it can be useful to see every node start and end
	it doesn't require registration, reacts to each message.

	

// example:
	n = DebugNodeWatcher(s);
	n.start;
	x = Group(s);
	x.run(false);
	x.free;
	n.stop;
	
	



