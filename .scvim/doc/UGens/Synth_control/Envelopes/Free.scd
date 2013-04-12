Free		 when triggered frees a node

superclass: UGen



	*kr(trig, nodeID)
	
	trig		when triggered, frees node
	
	nodeID	node to be freed	
	
	
	//example 
	
	s.boot;
	
	SynthDef("a", { Out.ar(0, SinOsc.ar(800, 0, 0.2)) }).send(s);
	
	SynthDef("b", { arg t_t=0; Out.ar(1, PinkNoise.ar(0.3)); Free.kr(t_t, 1001); }).send(s);
	
	s.sendMsg(\s_new, \a, 1001, 0, 0);
	
	s.sendMsg(\s_new, \b, 1002, 0, 0);
	
	s.sendMsg(\n_set, 1002, \t_t, 1);
	
	s.sendMsg(\s_new, \a, 1001, 0, 0);
	
	s.sendMsg(\n_set, 1002, \t_t, 1);
	
	s.sendMsg(\s_new, \a, 1001, 0, 0);
	
	s.sendMsg(\n_set, 1002, \t_t, 1);
	


