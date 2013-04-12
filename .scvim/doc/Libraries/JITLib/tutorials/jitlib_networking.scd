networked programming		

please note any problems, I'll try to add solutions here.


1) using ProxySpace with more than one client, with separate bus spaces

		Note: 	if only one client is using a remote server, only step (a) and step (d) are relevant. 
				The clientID argument can be left out then.
	
		before you start:
				remember to synchronize your system clocks. This can be done by:
				in OS X: SystemPreferences>Date&Time: set "Set Date & Time automatically"  to true.
				in linux: set the ntp clock
				a local time server is better than the apple time server.
					if you cannot sync the time, you can set the server latency to nil.
					This will break the pattern's functionality though.
					
		
		a) boot the (remote) server and create a local model
			(you cannot directly boot a remote server instance)
			
			s = Server("serverName", NetAddr(hostname, port), clientID);
				
				serverName 	can be any name
				hostname 	is an ip address, or if you have a name resolution, a network name
				port 			the port on which the server is listening. default is 57110
				clientID		for each client (each sc-lang) a different integer number has to be given 
				see Server
				
		b) from each client, initialize the default node and set notify to true:
			 	
			 	s.boot; // this will initialize the tree and start notification
			 	
			 	// if needed, a server window can be created:
			 	s.makeWindow;
		
		c) preallocate a range of busses in each client. 
			If there is conflicts, increase the number of busses in the server options before booting: 											(s.options.numAudioBusChannels = 1024;)
				
			(
				var numberOfParticipants, n;
				numberOfParticipants = 4;
				
				
				n = s.options.numAudioBusChannels / numberOfParticipants;
				n = n.floor.asInteger * s.clientID;
				s.audioBusAllocator.alloc(n);
				
				
				n = s.options.numControlBusChannels / numberOfParticipants;
				n = n.floor.asInteger * s.clientID;
				s.controlBusAllocator.alloc(n);
			)
		
		
		d) now create a ProxySpace from the server:
				
				p = ProxySpace.push(s); 
				
				
2) using ProxySpace with more than one client, with a partly shared bus space
		
			step a, b like in (1), skip (d)
			
			c) before allocating a number of busses for each client, create shared busses:
				p = ProxySpace.push(s);
				~shared1.ar(2);
				~shared2.ar(2);
				~sharedkr.kr(1); // or other names.
			
			then do (c) like in (1), just take care that the shared busses are taking number space
			already, so the easiest is to increase the numberOfParticipants by one, so no overrun
			happens.
		



			
3) writing a chat
	
			see example in Client
	
	
	
see also Public
					
			


