NodeControl

encapsulates in an object a node and an index.  this object can be held by a client and have its value set without otherwise having to store the details about where the node's input is.



d = SynthDef("help-NodeControl",{ arg out=0,freq=400;
	Out.ar(out,
		 SinOsc.ar(freq, 0, 0.5)
	)
});
y = d.play; // the synth

c = NodeControl(y,1);

c.value = 500;

c.value = 300;




