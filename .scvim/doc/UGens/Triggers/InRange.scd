InRange			tests if a signal is within a given range

inRange.ar(in, lo, hi)
InRange.kr(in, lo, hi)

If in is >= lo and <= hi output 1.0, otherwise output 0.0. Output is initially zero.

in - signal to be tested
lo - low threshold
hi - high threshold

Server.internal.boot;

{ InRange.kr(SinOsc.kr(1, 0, 0.2), -0.15, 0.15)}.scope; // see the trigger

{ InRange.kr(SinOsc.kr(1, 0, 0.2), -0.15, 0.15) * BrownNoise.ar(0.1)}.scope; // trigger noise Burst


