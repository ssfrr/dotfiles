MantissaMask				reduce precision

MantissaMask.ar(in, bits, mul, add)

Masks off bits in the mantissa of the floating point sample value. This introduces a quantization noise, but is less severe than linearly quantizing the signal.

in - input signal
bits - the number of mantissa bits to preserve. a number from 0 to 23.


// preserve only 3 bits of mantissa.
{ MantissaMask.ar(SinOsc.ar(SinOsc.kr(0.2,0,400,500), 0, 0.4), 3) }.play

// the original
{ SinOsc.ar(SinOsc.kr(0.2,0,400,500), 0, 0.4) }.play

// the difference.
(
{ 
	var in;
	in = SinOsc.ar(SinOsc.kr(0.2,0,400,500), 0, 0.4);
	Out.ar(0, in - MantissaMask.ar(in, 3));
}.play
)


// preserve 7 bits of mantissa. 
// This makes the lower 16 bits of the floating point number become zero.
{ MantissaMask.ar(SinOsc.ar(SinOsc.kr(0.2,0,400,500), 0, 0.4), 7) }.play

// the original
{ SinOsc.ar(SinOsc.kr(0.2,0,400,500), 0, 0.4) }.play

// the difference.
(
{ 
	var in;
	in = SinOsc.ar(SinOsc.kr(0.2,0,400,500), 0, 0.4);
	Out.ar(0, in - MantissaMask.ar(in, 7));
}.play
)




