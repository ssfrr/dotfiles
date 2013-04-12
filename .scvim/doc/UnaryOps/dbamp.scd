dbamp			convert decibels to linear amplitude 

a.dbamp
dbamp(a)

-20.dbamp.postln

{ FSinOsc.ar(800, 0.0, Line.kr(-3,-40,10).dbamp) }.play;


