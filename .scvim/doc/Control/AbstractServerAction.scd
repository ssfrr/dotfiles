AbstractServerAction			register actions to be taken for a server	

Inherits from: Object : AbstractSystemAction 


This is an abstract superclass for singletons like ServerQuit, which provides a place for registering functions and objects for events that should happen when something happens in the server. 
No direct call to AbstractServerAction is required.

See also: Server, ServerBoot, ServerTree, ServerQuit


Note: not fully working on linux and windows.

Setting the computer to sleep on these systems causes the actions to be called.
As to date in linux, JACK does not survive a sleep, it nevertheless behaves correctly for the time being.


Class Methods

	*functionSelector
		subclasses return specific function selectors for objects that implement this as interface. 
		selectors are:
			doOnServerBoot - 	ServerBoot
			doOnServerQuit -	ServerQuit
			doOnServerTree - 	ServerTree
		
		not for registry with a server, but analogous are:	
			doOnCmdPeriod - 	CmdPeriod
			doOnStartUp - 	StartUp
	
	*add(object, server)
	
		Add an action or object for registry
		object - Can either be a function to be evaluated (as first arg the server is passed in),
				or an Object that implements the message returned by functionSelector.
				One object is only registered once, so that multiple additions don't cause multiple calls.
				
		server  - Server for which to register. 
				If the symbol \default is passed in, the action is called for the current default server.
				If the symbol \all is passed in, the action is called for all current servers.
				if server is nil, it is added to \default.
		
	*remove(object, server)
	
		Remove an item or object from registry. If server is nil, remove from default key.
		
	*removeServer(server)
	
		Remove all items that are registered for a given server
		
	*removeAll
	
		Remove all items from registry	
		
		
		// examples
		
		
		
		// ServerBoot
		s.boot;
		f = { |server| "------------The server '%' has booted.------------\n".postf(server) };
		ServerBoot.add(f, \default);
		s.quit; // quit the server and observe the post
		s.boot;
		ServerBoot.remove(f, \default); // remove it again
		s.quit; 
		s.boot;// no post.
		ServerBoot.add(f, Server.internal);
		Server.internal.quit;
		Server.internal.boot;
		ServerBoot.removeAll; // clear all
		
		// ServerQuit
		s.boot;
		f = { |server| "------------The server '%' has quit.------------\n".postf(server) };
		ServerQuit.add(f, \default);
		s.quit; // quit the server and observe the post
		s.boot;
		ServerQuit.remove(f, \default); // remove it again
		s.quit; // no post.
		ServerQuit.add(f, Server.internal);
		Server.internal.boot;
		Server.internal.quit;
		ServerQuit.removeAll; // clear all
		
		
	
		// ServerTree
		s.quit;
		f = { |server| "-------The server '%' has initialised tree.-------\n".postf(server) };
		g = { |server| 10.do { Group(server).postln } };
		ServerBoot.add(f, \default);
		ServerTree.add(g, \default);
		s.boot; // boot and see how the actions are evaluated in order
		// "cmd-period" (or equivalent) resends the grous.
		
		ServerBoot.removeAll; // clear all
		ServerTree.removeAll; // clear all

	
	


