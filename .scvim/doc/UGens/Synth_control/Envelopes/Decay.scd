Decay			exponential decay

Inherits from: Object : AbstractFunction : UGen : Filter 

Decay.ar(in, decayTime, mul, add)
Decay.kr(in, decayTime, mul, add)


This is essentially the same as Integrator except that instead of supplying the coefficient directly, it is caculated from a 60 dB decay time. This is the time required for the integrator to lose 99.9 % of its value or -60dB. This is useful for exponential decaying envelopes triggered by impulses.

in - input signal
decayTime - 60 dB decay time in seconds.

plot({ Decay.ar(Impulse.ar(1), 0.01) });

// used as an envelope
play({ Decay.ar(Impulse.ar(XLine.kr(1,50,20), 0.25), 0.2, PinkNoise.ar, 0) });



