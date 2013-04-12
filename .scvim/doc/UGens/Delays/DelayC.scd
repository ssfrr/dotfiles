DelayC 	simple delay line with cubic interpolation

DelayC.ar(in, maxdelaytime, delaytime, mul, add)
DelayC.kr(in, maxdelaytime, delaytime, mul, add)

Simple delay line with cubic interpolation. See also DelayN which uses no interpolation, and DelayL which uses linear interpolation. Cubic interpolation is more computationally expensive than linear, but more accurate.

See also BufDelayC.

in - the input signal.
maxdelaytime - the maximum delay time in seconds. used to initialize the delay buffer size.
delaytime - delay time in seconds.

(
// Dust randomly triggers Decay to create an exponential 
// decay envelope for the WhiteNoise input source
{
z = Decay.ar(Dust.ar(1,0.5), 0.3, WhiteNoise.ar);
DelayC.ar(z, 0.2, 0.2, 1, z); // input is mixed with delay via the add input
}.play
)

(
// recursive application of delay.
{
z = Decay2.ar(Dust.ar(1, 0.5), 0.01, 0.1, Saw.ar(100 + [0, 1]));
5.do { |i| z = DelayC.ar(RLPF.ar(z, Rand(100, 3000), 0.03), 1, 1 / (2**i), 1, z * 0.5) };
z
}.play
)



