MidEQ			parametric filter

MidEQ.ar(in, freq, rq, db, mul, add)

Attenuates or boosts a frequency band.

in - input signal to be processed
freq - center frequency of the band in Hertz.
rq - the reciprocal of Q.  bandwidth / cutoffFreq. 
db - amount of boost (db > 0) or attenuation (db < 0) of the frequency band.  


// mixer parametric eq as wahwah
{ MidEQ.ar(Saw.ar(200,0.2), FSinOsc.kr(1, 0, 24, 84).midicps, 0.3, 12) }.play


// notch filter
(
{ var in; 
  in = PinkNoise.ar(0.2) + SinOsc.ar(600, 0, 0.1);
  MidEQ.ar(in, SinOsc.kr(0.2, 0.5pi) * 2 + 600, 0.01, -24) 
}.play
)

/////
// first start the synth
(
x = {| freq=400, db=0, rq=0.1 |
	 var in;
	 in =  SinOsc.ar([ 400, 420 ], 0, 0.4); 
	 MidEQ.ar(in, freq, Lag.kr(rq, 0.3), db)
	}.play
)

// now play with its parameters to hear how the filter affects two frequencies 
// that are very close to each other

x.set(\db, -12)
x.set(\rq, 0.1) 
x.set(\rq, 0.03) 
x.set(\freq, 410) 
x.set(\freq, 420) 
x.set(\freq, 400) 
x.set(\freq, 500) 


