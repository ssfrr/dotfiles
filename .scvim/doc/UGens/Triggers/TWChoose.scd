TWChoose		randomly select one of several inputs


An output is selected randomly on recieving a trigger from an array of inputs.
the weights of this choice are determined from the weights array.
If normalize is set to 1 the weights are continuously normalized (this is an extra overhead)
	when using fixed values the normalizeSum method can be used to normalize the values

superclass: Object (TWChoose is a composite of TWindex and Select )


	*ar(trig,array,weights,normalize)
	*kr(trig,array,weights,normalize)



(
{ 
	var a;
	a = [
			SinOsc.ar,
			Saw.ar,
			Pulse.ar
		];
	TWChoose.ar(Dust.ar(MouseX.kr(1, 1000, 1)), a, [0.99, 0.05, 0.05].normalizeSum) * 0.2
	
}.play;
)
	
Note: all the ugens are continously running. This may not be the most efficient way if each input is  cpu-expensive.


