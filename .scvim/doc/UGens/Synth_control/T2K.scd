T2K		audio rate trigger to control rate trigger converter


T2K.kr(in)



Converts audio rate trigger into control rate trigger, 
using the maxiumum trigger in the input during each control period.

in - input signal


// this does not work:
(
{
	var trig = Dust.ar(4);
	Trig.kr(trig, 0.1) * SinOsc.ar(800) * 0.1
}.play;
)

// this works:
(
{
	var trig = T2K.kr(Dust.ar(4));
	Trig.kr(trig, 0.1) * SinOsc.ar(800) * 0.1
}.play;
)


