BufDelayL	buffer based simple delay line with linear interpolation

BufDelayL.ar(buf, in, delaytime, mul, add)
BufDelayL.kr(buf, in, delaytime, mul, add)

Simple delay line with linear interpolation which uses a buffer for its internal memory. See also BufDelayN which uses no interpolation, and BufDelayC which uses cubic interpolation. Cubic interpolation is more computationally expensive than linear, but more accurate.

See also: DelayL

buf - buffer number.
in - the input signal.
delaytime - delay time in seconds.
Warning: For reasons of efficiency, the effective 
buffer size is limited to the previous power of two. So, if 44100 
samples are allocated, the maximum delay would be 32768 samples.


// allocate buffer
b = Buffer.alloc(s,44100,1);

(
// Dust randomly triggers Decay to create an exponential 
// decay envelope for the WhiteNoise input source
{
z = Decay.ar(Dust.ar(1,0.5), 0.3, WhiteNoise.ar);
BufDelayL.ar(b, z, 0.2, 1, z); // input is mixed with delay via the add input
}.play
)



