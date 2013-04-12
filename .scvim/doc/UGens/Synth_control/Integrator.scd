Integrator			leaky integrator

Inherits from: Object : AbstractFunction : UGen : Filter 

Integrator.ar(in, coef, mul, add)
Integrator.kr(in, coef, mul, add)


Integrates an input signal with a leak. The formula implemented is:

out(0) = in(0) + (coef * out(-1))

in - input signal
coef - leak coefficient.





{ Integrator.ar(LFPulse.ar(300, 0.2, 0.1), MouseX.kr(0.001, 0.999, 1)) }.play

// used as an envelope
{ Integrator.ar(LFPulse.ar(3, 0.2, 0.0004), 0.999, FSinOsc.ar(700), 0) }.play


// scope, using the internal server:

{ Integrator.ar(LFPulse.ar(1500 / 4, 0.2, 0.1), MouseX.kr(0.01, 0.999, 1)) }.scope


