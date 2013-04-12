ProxySpace 		an environment of references on a server 

superclass: Object: EnvironmentRedirect : LazyEnvir 


Generally a proxy is a placeholder for something.  A node proxy is a placeholder for something playing on a server that writes to a limited number of busses (e.g. a synth or an event stream). NodeProxy objects can be replaced and recombined while they play. Also they can be used to build a larger structure which is used and modified later on. Overview: JITLib

When accessed, ProxySpace returns a NodeProxy. A similar class without environment: Ndef

For more examples see: 
	proxyspace_examples 
	jitlib_basic_concepts_01

For GUI overview, see ProxyMixer.
See NodeProxy for many relevant methods.




First Example

	s.boot;
	
	p = ProxySpace.new;
	p.fadeTime = 2; // fadeTime specifies crossfade
	// set the source
	p[\out] = { SinOsc.ar([350, 351.3], 0, 0.2) };
	p[\out] = { Pulse.ar([350, 351.3] / 4, 0.4) * 0.2 };
	p[\out] = Pbind(\dur, 0.03, \freq, Pbrown(0, 1, 0.1, inf).linexp(0, 1, 200, 350));
	

	p[\out] = { Ringz.ar(p[\in].ar, [350, 351.3] * 8, 0.2) * 4 };
	p[\in] = { Impulse.ar([5, 7]/2, [0, 0.5]) };
	
	a.clear(3); // clear after 3 seconds
	b.clear(3);
	

Creation / Class Methods


	*new(server, name, clock)
		
		server: 	a Server object. Note that on remote computers the clock must be in sync.
		name: 	a symbol. If a name is given, the proxy space is stored in ProxySpace.all under this name.
		clock: 	for event-based or beat-sync playing use a TempoClock.
		
	*push(server, name, clock)
				
				replace the currentEnvironment with a new ProxySpace and clear the current one, if
				it is a ProxySpace (this is to avoid piling up proxy spaces).
				
				In order to move to another ProxySpace while keeping the current,
				use pop and then push a new one. To have multiple levels of proxy spaces, 
				use .new.push;
		
	*pop
				restore the previous currentEnvironment
			

	
	
Play back and access	
	

	play(key, out, numChannels)
				returns a group that plays the NodeProxy at that key. default key: \out
				out: output channel offset
				numChannels: play this number of channels.
	
	record(key, path, headerFormat, sampleFormat)
		
				returns a RecNodeProxy that records the NodeProxy at that key
	
	ar(key, numChannels, offset)
	kr(key, numChannels, offset)
		
				returns a NodeProxy output that plays the NodeProxy at that key,
				to be used within a function used as input to a node proxy
	
	wakeUp	
				when the proxyspace is created without a running server this method can be used
				to run it (internally this is done by play(key) as well.
		
		
	fadeTime_	set the fadetime of all proxies as well as the default fade time
	
	clock_		set the clock of all proxies as well as the default clock.
	
	quant_		set the quant of all proxies as well as the default quant.
	
	free(fadeTime)		free all proxies (i.e. free also the groups,  do not stop the monitors)
	
	release(fadeTime)		release all proxies (i.e. keep the groups running)
	
	stop(fadeTime)		stop all proxies (stop only monitors, do not stop synths)
	
	end(fadeTime)			end all proxies (free and stop the monitors)
	
	clear(fadeTime)		clear the node proxy and remove it from the environment. 
						this frees all buses. If a fadeTime is given, first fade out, then clear.
	
	
	*clearAll				clear all registered spaces
	
	add					add the ProxySpace to the repository (name required)
	remove				remove the ProxySpace from the repository
	

Setting the sources:


	put(key, obj)
		Gets the NodeProxy at key (if none exists, returns a new one) and sets its source to obj. For how this works, see also LazyEnvir and NodeProxy.
		
	at(key)
		Return the proxy source object at that key.


	The rate and numChannels of the NodeProxy determined in a lazy way from the first object put into this environment (see helpfile). Once it is created it can only be set to a function that returns the same rate and a number of channels equal to the intial one or smaller. For details, see the_lazy_proxy


"garbage collecting":
	
	clean(exclude)
				free and remove all proxies that are not needed in order to play the 
				ones passed in with 'exclude'. if none are passed in, all proxies
				that are monitoring (with the .play message) are kept as well as their parents etc. 
				
	reduce(to)
				free all proxies that are not needed in order to play the 
				ones passed in with 'to'. if none are passed in, all proxies
				that are monitored (with the play message) are kept as well as their parents etc.
				

Coding
	
	document(keys)
				creates a new document with the current proxyspace state. This does not allow
				open functions as proxy sources. see: jitlib_asCompileString
				keys: list of keys to document a subset of proxies
				







// ProxySpace returns instances of NodeProxy:
a = NodeProxy(s) 		is equivalent to  ~a;
a.source = ...		is equivalent to  ~a = ...
a[3] = ...			is equivalent to  ~a[3] = ...

// the two expressions are equivalent: 
~out = something;   
currentEnvironment.put(\out, something);


// examples

p = ProxySpace.push(s.boot); // use ProxySpace as current environment.

~out.play;

~out = { SinOsc.ar([400, 407] * 0.9, 0, 0.2) };

~out = { SinOsc.ar([400, 437] * 0.9, 0, 0.2) * LFPulse.kr([1, 1.3]) };

~out = { SinOsc.ar([400, 437] * 0.9, 0, 0.2) * ~x.kr(2) };

~x = { LFPulse.kr([1, 1.3] * MouseX.kr(1, 30, 1)) };

~out = { SinOsc.ar([400, 437] * Lag.kr(0.1 + ~x, 0.3), 0, 0.2) * ~x };

p.fadeTime = 5;

~out = { SinOsc.ar([400, 437] * 1.1, 0, 0.2) * ~x.kr(2) };

p.clear(8); // end and clear all in 8 sec.


p.pop; // move out.


	





