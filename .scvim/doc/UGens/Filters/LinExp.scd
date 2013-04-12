LinExp		convert a linear range to an exponential range

LinExp.ar(in, srclo, srchi, dstlo, dsthi)
LinExp.kr(in, srclo, srchi, dstlo, dsthi)

Converts a linear range of values to an exponential range of values.
The dstlo and dsthi arguments must be nonzero and have the same sign.
in - input to convert.
srclo - lower limit of input range.
srchi - upper limit of input range.
dstlo - lower limit of output range.
dsthi - upper limit of output range.


// compare:
(
{ 
	var mod = SinOsc.kr(Line.kr(1, 10, 10));
	SinOsc.ar(mod * 400 + 500) * 0.1 
}.play;
)

(
{ 
	var mod = SinOsc.kr(Line.kr(1, 10, 10));
	SinOsc.ar(LinExp.kr(mod, -1,1, 100, 900)) * 0.1 
}.play;
)

// modulating destination values.
(
{ 
	var mod = LFNoise2.ar(80);
	SinOsc.ar(LinExp.ar(mod, -1,1, MouseX.kr(200, 8000, 1), MouseY.kr(200, 8000, 1))) * 0.1 
}.play;
)


linexp and exprange can be used to create a LinExp implicitly from a ugen, mapping its output values from linear range to an exponential one. The rate is derived from the ugen.


// linexp
(
{ 
	var mod = LFNoise2.ar(80);
	SinOsc.ar(mod.linexp(-1,1, MouseX.kr(200, 8000, 1), MouseY.kr(200, 8000, 1))) * 0.1 
}.play;
)

// exprange
(
{ 
	var mod = LFNoise2.ar(80).exprange(MouseX.kr(200, 8000, 1), MouseY.kr(200, 8000, 1));
	SinOsc.ar(mod) * 0.1 
}.play;
)






