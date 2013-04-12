TChoose		randomly select one of several inputs

superclass: Object (TChoose returns a combination of Select and TIRand)

An output is selected randomly on recieving a trigger from an array of inputs.

see also: TWChoose


	*ar(trig,array)
	*kr(trig,array)



(
{ 
	var a;
	a = [
			SinOsc.ar,
			Saw.ar,
			Pulse.ar
		];
	TChoose.ar(Dust.ar(MouseX.kr(1, 1000, 1)), a) * 0.2
	
}.play;
)
	
Note: all the ugens are continously running. This may not be the most efficient way if each input is  cpu-expensive.


