Pause		 when triggered pauses a node

superclass: UGen



	*kr(gate, nodeID)
	
	gate		when gate is 0,  node is paused, when 1 it runs
	
	nodeID	node to be paused	
	
	
	//example
	
	s.boot;

	SynthDef("a", { Out.ar(0, SinOsc.ar(800, 0, 0.2)) }).send(s);
	
	SynthDef("b", { arg gate=1; Out.ar(1, PinkNoise.ar(0.3)); Pause.kr(gate, 1001); }).send(s);
	
	s.sendMsg(\s_new, \a, 1001, 0, 0);
	
	s.sendMsg(\s_new, \b, 1002, 0, 0);
	
	s.sendMsg(\n_set, 1002, \gate, 0);
	
	s.sendMsg(\n_set, 1002, \gate, 1);
	


