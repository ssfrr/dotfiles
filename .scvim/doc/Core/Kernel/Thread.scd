Thread			represents an individual operating system thread 

Inherits from: Object : AbstractFunction : Stream

Normally there is no need to instantiate a Thread, but its subclass Routine is very useful. 

It is wise not to fiddle with the source code for this class; see the warnings in the class file. 

thisThread always returns the enclosing thread running the given code. A Thread is aware of its own attached clock and associated beats and seconds timing, and has an individual random number seed and exception handler.

See also: Routine


Creation / Class Methods

	*new (func, stackSize)
	
		Create a Thread. You will not typically do this yourself but as a result of creating Routines, for example. 
		func - A function with code for the thread to run.
		stackSize - defaults to 64 depth call stack. 
		
		// example
		g = Thread({"hello".postln;});
		g.seconds; //time of creation, cannot advance without a clock



Instance Methods

	
		beats - return the elapsed beats (logical time) of the thread	
		seconds - return the elapsed seconds (logical time) of the thread.
		clock - return the thread's clock
		isPlaying - return true if it is playing

		// example
		thisThread.beats;
		thisThread.seconds;
		thisThread.clock;
		
		
		state - The internal state values for a Thread instance can be polled:
		
		0 = not started
		7 = running
		8 = stopped
				
				
Seeding the random number generator

	see also: randomSeed

	
	randSeed_ (seed)
	
		seed - Set the random number generator seed using a single integer
		
		// inline example
		g = thisThread.randSeed_(4);
		10.do{1.0.rand2.postln};


	randData
	
		Get the three integer array which defines the internal basis for the random number generator.  You can use this to get back the exact same random number sequence, and it provides a mechanism for automatic replay for generative music. 
		
		// inline example
		g = thisThread.randData;
		10.do{1.0.rand2.postln};	
		
	randData_ (data)
	
		Get the three integer array which defines the internal basis for the random number generator. Equivalent to load for a generative music piece, as long as the program is the same as last time! 
		data - three integer array in the format previously obtained from the getter function. 
		
		// each time the seed is reset, the random number generation should give the same sequence
		thisThread.randData_(Int32Array[ -662787342, 1546785953, 1661466823 ]);
		10.do{1.0.rand2.postln};
			




