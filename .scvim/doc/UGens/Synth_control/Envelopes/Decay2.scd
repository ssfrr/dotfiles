Decay2			exponential decay

Inherits from: Object : AbstractFunction : UGen : Filter 

Decay2.ar(in, attackTime, decayTime, mul, add)
Decay2.kr(in, attackTime, decayTime, mul, add)

Decay has a very sharp attack and can produce clicks. Decay2 rounds off the attack by subtracting one Decay from another. Decay2.ar(in, attackTime, decayTime) is equivalent to:

Decay.ar(in, decayTime) - Decay.ar(in, attackTime)

in - input signal
attackTime - 60 dB attack time in seconds.
decayTime - 60 dB decay time in seconds.



// since attack and decay are a difference of two Decays, 
// swapping the values, the envelope turns upside down:
plot({ Decay2.ar(Impulse.ar(1), 0.001, 0.01) })
plot({ Decay2.ar(Impulse.ar(1), 0.01, 0.001) })

// used as an envelope
{ Decay2.ar(Impulse.ar(XLine.kr(1,50,20), 0.25), 0.01, 0.2, FSinOsc.ar(600)) }.play;

// compare the above with Decay used as the envelope
{ Decay.ar(Impulse.ar(XLine.kr(1,50,20), 0.25), 0.2, FSinOsc.ar(600), 0)  }.play;



