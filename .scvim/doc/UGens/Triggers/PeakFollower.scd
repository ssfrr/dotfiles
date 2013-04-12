PeakFollower				track peak signal amplitude

PeakFollower.ar(in, decay)

Outputs the peak amplitude of the signal received at the input. 
if level is below maximum, the level decreases by the factor given in decay.

in - input signal.
decay - decay factor.

Internally, the absolute value of the signal is used, to prevent underreporting the peak value if there is a negative DC offset. To obtain the minimum and maximum values of the signal as is, use the RunningMin and RunningMax UGens.

s.boot;

// no decay
(
{ 
	SinOsc.ar(
			PeakFollower.ar(Dust.ar(20, Line.kr(0, 1, 4)), 1.0) * 1500 + 200, 
			0, 0.2
	)
	
}.play;
)

// a little decay
(
{ 
	SinOsc.ar(
			PeakFollower.ar(Dust.ar(20, Line.kr(0, 1, 4)), 0.999) * 1500 + 200, 
			0, 0.2
	)
	
}.play;
)

// mouse x controls decay, center of the
(
{ 
	var decay;
	decay = MouseX.kr(0.99, 1.00001).min(1.0);
	SinOsc.ar(
			PeakFollower.ar(Dust.ar(20), decay) * 1500 + 200, 
			0, 0.2
	);
	
}.play;
)




// follow a sine lfo, decay controlled by mouse x
(
{ 
	var decay;
	decay = MouseX.kr(0, 1.1).min(1.0);
	SinOsc.ar(
			PeakFollower.kr(SinOsc.kr(0.2), decay) * 200 + 500, 
			0, 0.2
	)
	
}.play;
)





