RunningMax				track maximum level


RunningMax.ar(in, trig)



Outputs the maximum value received at the input. 
When triggered, the maximum output value is reset to the current value.
in - input signal.
trig - A trigger resets the output value to the current input value.
A trigger happens when the signal changes from non-positive to positive.



(
{ 
	SinOsc.ar(
			RunningMax.ar(Dust.ar(20), Impulse.ar(0.4)) * 500 + 200, 
			0, 0.2
	)
	
}.play;
)

// follow a sine lfo, reset rate controlled by mouse x
(
{ 
	SinOsc.ar(
			RunningMax.kr(SinOsc.kr(0.2), Impulse.kr(MouseX.kr(0.01, 2, 1))) * 500 + 200, 
			0, 0.2
	)
	
}.play;
)



