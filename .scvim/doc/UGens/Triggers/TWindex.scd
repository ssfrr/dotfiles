TWindex				triggered windex

	*kr(trig,array,normalize)
	
When triggered, returns a random index value based on array as a list of probabilities.
by default the list of probabilities should sum to 1.0, when the normalize flag is set to 1,
the values get normalized by the ugen (less efficient)


//assuming normalized values
(

a = SynthDef("help-TWindex",{ arg w1=0.0, w2=0.5, w3=0.5;

	var trig, index;
	trig = Impulse.kr(6);
	index = TWindex.kr(trig, [w1, w2, w3]);
	
	Out.ar(0,
		SinOsc.ar(
			Select.kr(index,[400, 500, 600]),
			0, 0.2
		)
	)
}).play;

)

a.setn(0, [0,0,1].normalizeSum);
a.setn(0, [1,1,1].normalizeSum);
a.setn(0, [1,0,1].normalizeSum);


//modulating probability values
(

a = SynthDef("help-TWindex",{ arg w1=0.0, w2=0.5;

	var trig, index;
	trig = Impulse.kr(6);
	index = TWindex.kr(
					trig, 
					[w1, w2, SinOsc.kr(0.3, 0, 0.5, 0.5)],//modulate probability
					1 //do normalisation
		); 
	
	Out.ar(0,
		SinOsc.ar(
			Select.kr(index,[400, 500, 600]),
			0, 0.2
		)
	)
}).play;

)

a.setn(0, [0,0]);
a.setn(0, [1,1]);
a.setn(0, [1,0]);
a.setn(0, [0,1]);




