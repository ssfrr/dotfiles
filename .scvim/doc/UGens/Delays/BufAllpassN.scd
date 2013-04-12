BufAllpassN		buffer based all pass delay line with no interpolation

BufAllpassN.ar(buf, in, delaytime, decaytime, mul, add)
BufAllpassN.kr(buf, in, delaytime, decaytime, mul, add)

All pass delay line with no interpolation which uses a buffer for its internal memory. See also BufAllpassC which uses cubic interpolation, and BufAllpassL which uses linear interpolation. Cubic interpolation is more computationally expensive than linear, but more accurate.

See also AllpassN.

buf - buffer number.
in - the input signal.
delaytime - delay time in seconds.
decaytime - time for the echoes to decay by 60 decibels. If this time is negative then the feedback
coefficient will be negative, thus emphasizing only odd harmonics at an octave lower.
Warning: For reasons of efficiency, the effective 
buffer size is limited to the previous power of two. So, if 44100 
samples are allocated, the maximum delay would be 32768 samples.

// allocate buffer
b = Buffer.alloc(s,44100,1);

// Since the allpass delay has no audible effect as a resonator on
// steady state sound ... 

{ BufAllpassC.ar(b, WhiteNoise.ar(0.1), XLine.kr(0.0001, 0.01, 20), 0.2) }.play;

// ...these examples add the input to the effected sound and compare variants so that you can hear
// the effect of the phase comb:

(
{
	z = WhiteNoise.ar(0.2);
	z + BufAllpassN.ar(b, z, XLine.kr(0.0001, 0.01, 20), 0.2)
}.play)

(
{
	z = WhiteNoise.ar(0.2);
	z + BufAllpassL.ar(b, z, XLine.kr(0.0001, 0.01, 20), 0.2)
}.play)

(
{
	z = WhiteNoise.ar(0.2);
	z + BufAllpassC.ar(b, z, XLine.kr(0.0001, 0.01, 20), 0.2)
}.play)

// used as an echo - doesn't really sound different than Comb,
// but it outputs the input signal immediately (inverted) and the echoes
// are lower in amplitude.
{ BufAllpassN.ar(b, Decay.ar(Dust.ar(1,0.5), 0.2, WhiteNoise.ar), 0.2, 3) }.play;


