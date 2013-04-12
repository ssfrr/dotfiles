AllpassN		all pass delay line with no interpolation

AllpassN.ar(in, maxdelaytime, delaytime, decaytime, mul, add)
AllpassN.kr(in, maxdelaytime, delaytime, decaytime, mul, add)

All pass delay line with no interpolation. See also AllpassC which uses cubic interpolation, and AllpassL which uses linear interpolation. Cubic interpolation is more computationally expensive than linear, but more accurate.

See also BufAllpassN.

in - the input signal.
maxdelaytime - the maximum delay time in seconds. used to initialize the delay buffer size.
delaytime - delay time in seconds.
decaytime - time for the echoes to decay by 60 decibels. If this time is negative then the feedback
coefficient will be negative, thus emphasizing only odd harmonics at an octave lower.

// Since the allpass delay has no audible effect as a resonator on
// steady state sound ... 

{ AllpassC.ar(WhiteNoise.ar(0.1), 0.01, XLine.kr(0.0001, 0.01, 20), 0.2) }.play;

// ...these examples add the input to the effected sound and compare variants so that you can hear
// the effect of the phase comb:

(
{
	z = WhiteNoise.ar(0.2);
	z + AllpassN.ar(z, 0.01, XLine.kr(0.0001, 0.01, 20), 0.2)
}.play)

(
{
	z = WhiteNoise.ar(0.2);
	z + AllpassL.ar(z, 0.01, XLine.kr(0.0001, 0.01, 20), 0.2)
}.play)

(
{
	z = WhiteNoise.ar(0.2);
	z + AllpassC.ar(z, 0.01, XLine.kr(0.0001, 0.01, 20), 0.2)
}.play)

// used as an echo - doesn't really sound different than Comb,
// but it outputs the input signal immediately (inverted) and the echoes
// are lower in amplitude.
{ AllpassN.ar(Decay.ar(Dust.ar(1,0.5), 0.2, WhiteNoise.ar), 0.2, 0.2, 3) }.play;


