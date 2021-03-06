Efficient coding with NodeProxy


NodeProxy (and, in disguise ProxySpace) represent "pronouns", placeholders for all kinds
of sound producing objects that are able to write to a specific bus on the server.

To prepare such an object for playing, different objects require different things,
some very little, some more. As working with the placeolders does not show directly
which actions are very efficient and whic ones are not, it is shown here more in detail.

This is also important if you want to automate certain processes (e.g. for control by an external interface or a task) - some things (a) are not meant to be used in certain ways and better solutions should be used instead then, others are much more efficient (b, c)



a = NodeProxy.audio;
ProxySpace.push;

a.source = ... is equivalent to ~a = ...
a.add(...) a.put(0,...) a[0] = ... ~a[0] = ... are equivalent in cpu load.

a) rebuild and send: manual rate
the following code requires a rebuild and send of a SynthDef and is thus most cpu-expensive.
though fine for slower use (esp.hand-use) for automatisation it is better to build a synthdef and assign it

	~a = { someUGenFunction }; 
	~a = Patch(instrname, args);
	~a = SynthDef(\name, { someUGenFunction });
	
	
	// the same applies to rebuilding the graphs:
	~a.rebuild
	
	// this rebuild is also used when setting one of the following properties:
	server, bus, setRates
	
b) starting synths and tasks
the following code sends commands to the server to start synths, which is load mainly on the server
and depends on the characteristics of the synthdef:

	~a = \synthDefName; // the synthdef is already on the server
	~a = Pbind(\instrument, name, \freq, ...);
	~a = Routine({ loop({ s.sendMsg("/s_new", name, ...)})  });
	
	~a.refresh; ~a.wakeUp; // waking up a stopped proxy does not require a resend
	
	these resend the synth with new properies

	~a.send(...) // directly sends a message. the mapping bundle of the proxy is cached
	~a.sendAll(...)
	
				// for the following the bundle is recalculated if a new key is assigned.
				// if you use the same key with a different value, the bundle is modified
				
	~a.xset(...) ~a.xmap(...) 	
	~a.nodeMap_(a map) 
	~a.fadeToMap(a map)
	
	// synthdefs for these things are on the server already.
	
	~a.gate, ~a.env, ~a.line, ~a.xline
	
	// some more calculations have to be made on client side, so if automated, it is better to use
	// the above or a lag in the synth. 
	
	~a.lineAt(key), ~a.xlineAt(key)
	 
	 
	
c) sending messages to running synths: for these the least calculation has to be done


	~a.set(\freq, 400, \dt, 0.2); ~a.unset(\freq); // if running the bundle will be recalculated
	~a.map(\freq, ~lfo); ~a.unmap(\freq);
	~a.fadeTime = 2;
	~a.gateAt(key)	
	
	// for avoiding bundle recalculation you can directly talk to the group.
	// this setting will not be kept when you exchange the synth
	~a.group.set(\freq, 500);
	 
	
	
	
	
switching audio (this can now be done with map!)
todo: rewrite this part.

	control rate sources can be easily and efficiently switched using map or xmap.
	here is an example of how already running audio rate inputs can be switched.
	it is about as efficient as (b) - first example (setting a defname)
	it works only for 1 or 2 channels right now.


(
s.boot;
p = ProxySpace.push(s);
)



~out.play;

~s1 = { Blip.ar(Rand(32,15), 100, 0.5) };
~s2 = { SinOsc.ar(740, 0, 0.1) };
~s3 = { Pulse.ar(140, 0.2, 0.1) };


~out = {  Pan2.ar(~mix.ar(1), MouseX.kr(-1,1)) };

~mix.read(~s1);
~mix.read(~s2);
~mix.read(~s3);

//resetting the source stops reading
~mix = \default;

//now you can also crossfade audio efficiently:
~mix.fadeTime = 1.5;

~mix.read(~s1);
~mix.read(~s2);
~mix.read(~s3);

// automation:
(
t = Task({
	var dt;
	loop({
		dt = rrand(0.01, 0.3);
		~mix.fadeTime = dt;
		~mix.read([~s1, ~s2, ~s3].choose);
		dt.wait;
	});
});
)

t.play(SystemClock);


// change the sources meanwhile:
~s1 = { Blip.ar(105, 100, 0.2) };
~s2 = { SinOsc.ar(350, 0, 0.1) };
~s3 = { Pulse.ar(60, 0.2, 0.1) };

~freq = { MouseX.kr(200, 600, 2) };

~s1 = { Blip.ar(~freq.kr * 0.3, 10, 0.2) };
~s2 = { SinOsc.ar(~freq.kr, 0, 0.1) };
~s3 = { Pulse.ar(~freq.kr * 0.2, 0.2, 0.1) };

	
t.stop;
	
// note that when restarting ~out, the inputs have to be woken up.
// to avoid this, you can add the inputs to the mix nodeMap parents:

~mix.nodeMap.parents.putAll( (s1: ~s1, s2: ~s2, s3: ~s3) );

// also the task can be added to the proxy:
(
~mix.task = Routine({
	loop({
		~mix.fadeTime = rrand(0.01, 0.1);
		~mix.read([~s1, ~s2, ~s3].choose);
		[0.2, 0.4].choose.wait;
	});
});
)



