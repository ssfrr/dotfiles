Schmidt			Schmidt trigger

Schmidt.ar(in, lo, hi)
Schmidt.kr(in, lo, hi)

When in crosses to greater than hi, output 1.0, then when signal crosses lower than lo output 0.0. Uses the formula if(out == 1, { if(in < lo, { out = 0.0 }) }, { if(in > hi, { out = 1.0 }) }). Output is initially zero.

in - signal to be tested
lo - low threshold
hi - high threshold

Server.internal.boot;

{ Schmidt.kr(SinOsc.kr(1, 0, 0.2), -0.15, 0.15)}.scope; // see the trigger

{ Schmidt.kr(MouseX.kr(0, 1), 0.2, 0.8)}.scope; // try it with the cursor

// threshold octave jumps
(
{ 
	var in = LFNoise1.kr(3);
	var octave = Schmidt.kr(in, -0.15, 0.15) + 1;
	SinOsc.ar(in * 200 + 500 * octave, 0, 0.1)
}.scope;
)


