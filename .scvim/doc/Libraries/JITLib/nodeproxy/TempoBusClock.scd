TempoBusClock		a clock that synchronizes its tempo with the server

superclass: TempoClock


	*new(control, tempo, beats, seconds)
		return a new instance. 
		control can be anything that responds to the message set(key, val, ...)
			e.g. a Synth or a NodeProxy. The control key set is "tempo"
			
	otherwise TempoBusClock works just like a TempoClock
	
	
	// example
	
	(
	a = { |tempo=1| Ringz.ar(Impulse.ar(tempo), [501, 500], 1/tempo) }.play;
	t = TempoBusClock(a);
	Task { loop { "klink".postln; 1.wait } }.play(t);
	);
	
	t.tempo = 1.3;
	t.tempo = 0.5;
	t.tempo = 1.0;
	
	
	// in ProxySpace, a TempoBusClock can be added together with a ~tempo NodeProxy:
	
	p = ProxySpace.push(s);
	p.makeTempoClock;
	p.clock; // now the ProxySpace's clock is a TempoBusClock
	
	~out.play;
	~out = { Ringz.ar(Impulse.ar(~tempo.kr), [501, 500], 1/~tempo.kr) * 0.3 };
	p.clock.tempo = 1.3;
	
	// patterns and tasks are synchronized:
	
	~out2.play;
	~out2 = Pbind(\dur, 1, \note, Pwhite(0, 7, inf));
	
	p.clock.tempo = 3;	
	p.clock.tempo = 1;	

	
	
	


