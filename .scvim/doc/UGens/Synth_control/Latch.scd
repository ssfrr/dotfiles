Latch				sample and hold

Latch.ar(in, trig)


Holds input signal value when triggered.
in - input signal.
trig - trigger. Trigger can be any signal. A trigger happens when the signal changes from
non-positive to positive.





{ Blip.ar(Latch.ar(WhiteNoise.ar, Impulse.ar(9)) * 400 + 500, 4, 0.2) }.play;


The above is just meant as example. LFNoise0 is a faster way to generate random steps :

{ Blip.ar(LFNoise0.kr(9, 400 ,500), 4, 0.2) }.play;



