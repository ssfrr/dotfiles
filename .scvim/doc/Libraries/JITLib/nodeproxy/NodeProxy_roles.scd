Roles in NodeProxy

Similar to Adverbs (see J Concepts In SC), roles allow to specify how a source for a NodeProxy is being used. A role is an association of a Symbol and the new proxy source object.

see also: NodeProxy, Ndef, ProxySpace

The below examples can equally be used for Ndef and in ProxySpace.

// Thus, the following expressions behave in an equivalent way:

a = NodeProxy(s);
a[0] = ...

ProxySpace.push(s);
~a[0] = ...

Ndef(\a, ...) 

Existing roles:

	\set -> event pattern:
		Set the proxy controls with an event pattern of type \set
		
 	// example:
	a = NodeProxy(s);
	a[0] = { |freq = 440, dt=0.1, rate=2| Ringz.ar(Impulse.ar(rate * [1, 1.2]), freq, dt)*0.1 };
	a.play;
	(
	a[1] = \set -> Pbind(
					\dur, Prand([1, 0.5], inf), 
					\freq, Pwhite(200.0, 1000, inf), 
					\rate, Pstutter(4, Prand([1, 3, 6, 10], inf)),
					\dt, Pwhite(0.01, 0.1, inf)
				)
	);
	// modify the source in the meanwhile:
	a[0] = { |freq = 440, dt=0.1, rate=2| Ringz.ar(Dust.ar(rate * 10.dup), freq, dt)*0.1 };

	a.clear(3);
	
	\setbus -> event pattern:
		Set the proxy bus with an event pattern of type \c_set
		
 	// example:
	a = NodeProxy(s);
	b = NodeProxy(s).play;
	b[0] = { SinOsc.ar(a.kr(4)).sum * 0.2 };
	(
	a[0] = \setbus -> Pbind(
					\dur, Prand([1, 0.5], inf), 
					\value, Pfunc { var z = rrand(300, 4000); [300, 400, z, z + 30.rand2] }
				)
	);
	// modify the other source in the meanwhile:
	b[0] = { Pulse.ar(a.ar(4)).sum * 0.2 };

	a.clear; b.clear;
	
	\setsrc -> event pattern:
		Set the proxy source at the next index with any object, controlled by a pattern.
		Note that any existing source at the next index (in the example below it is index 1) is overridden by the procedure.
		
 	// example:
	a = NodeProxy(s);
	a.play;
	(
	a[0] = \setsrc -> Pbind(
					\dur, Prand([1, 0.5, 2], inf), 
					\source, Prand ([
						{ SinOsc.ar(SinOsc.ar({5.rand}.dup + 4) * 50 + 400 + 50.rand) * 0.1 },
						{ SinOsc.ar(LFSaw.ar({5.rand}.dup + 4) * 50 + 400 + 50.rand) * 0.1},
						{ LFSaw.ar(SinOsc.ar({5.rand}.dup + 4) * 50 + 400 + 50.rand) * 0.1 },
						{ LFSaw.ar(LFSaw.ar({5.rand}.dup + 4) * 50 + 400 + 50.rand) * 0.1 }
					], inf)
				)
	);

	a.clear(3);
	
	\filter -> function:
		Filter the audio on the proxy's own bus, using the first argument to pass in the sound. 
		The function is any valid UGen function, which may be control or audio rate.
		Default controls are wet++index, where index is the slot of the proxy (default 0), in the example below, the control is \wet1.
		
 	// example:
	a = NodeProxy(s);
	a[0] = { PinkNoise.ar(0.1.dup) };
	a.play;
	a[1] = \filter -> { |in| RLPF.ar(in, LFNoise2.kr(1).exprange(300, 1000), 0.1) };
	a.set(\wet1, 0.2);
	a.clear(3); 

	\filterIn -> function:
		Like \filter, only that the input is controlled by the \wet control, not the output.
	
	// example:
	a = NodeProxy(s);
	a[0] = { PinkNoise.ar(0.1.dup) };
	a.play;
	a[1] = \filterIn -> { |in| RLPF.ar(in, LFNoise2.kr(1).exprange(300, 1000), 0.1) };
	a.set(\wet1, 0.2);
	a.clear(3); 
	
	\filterIn -> mix:
		Mix in the UGen in the function.
	
	// example:
	a = NodeProxy(s);
	a[0] = { PinkNoise.ar(0.1.dup) };
	a.play;
	a[1] = \mix -> { Dust.ar(30.dup) };
	a.set(\mix1, 0.2);
	a.clear(3);
	

Adding new roles:

Roles can be added on the fly. They are kept in a dictionary (buildMethods) in AbstractPlayControl. A second dictionary (proxyControlClasses) provides the wrapper class for a given key.

Here is a new role that allows you to set a control rate node proxy with the help of an event pattern. The new values are in a key namd \value. 


// add the new role:
(
AbstractPlayControl.proxyControlClasses.put(\stream, PatternControl);
AbstractPlayControl.buildMethods.put(\stream, 
		#{ arg pattern, proxy, channelOffset=0, index;
			Pbindf(
				pattern,
				\type, \bus,
				\id, Pfunc { proxy.group.nodeID },
				\array, Pkey(\value),
				\out, Pfunc { proxy.index }
			).buildForProxy( proxy, channelOffset, index )
		});
)



// test:
a = NodeProxy.control(s);
a.source = \stream -> Pbind(\value, Pseq([1, 2, 3], inf), \dur, 1.5).trace;

b = NodeProxy(s);
b.source =  { SinOsc.ar([340, 440] * a.kr) * 0.1 };
b.play;

a.source = \stream -> Pbind(\value, Pseq([1, 2, 3], inf) + Pwhite(0.0, 0.2, inf), \dur, 0.05);
b.source =  { SinOsc.ar([5.6, 10.3] ** a.kr + 300) * 0.1 };



