DelayN			simple delay line with no interpolation

DelayN.ar(in, maxdelaytime, delaytime, mul, add)
DelayN.kr(in, maxdelaytime, delaytime, mul, add)

Simple delay line with no interpolation. See also DelayL which uses linear interpolation, and DelayC which uses cubic interpolation. Cubic interpolation is more computationally expensive than linear, but more accurate.

See also BufDelayN.

in - the input signal.
maxdelaytime - the maximum delay time in seconds. used to initialize the delay buffer size.
delaytime - delay time in seconds.

(
// Dust randomly triggers Decay to create an exponential 
// decay envelope for the WhiteNoise input source
{
z = Decay.ar(Dust.ar(1,0.5), 0.3, WhiteNoise.ar);
DelayN.ar(z, 0.2, 0.2, 1, z); // input is mixed with delay via the add input
}.play
)

(
// recursive application of delay.
{
z = Decay2.ar(Dust.ar(1, 0.5), 0.01, 0.1, Saw.ar(100 + [0, 1]));
5.do { |i| z = DelayN.ar(RLPF.ar(z, Rand(100, 3000), 0.03), 1, 1 / (2**i), 1, z * 0.5) };
z
}.play
)


