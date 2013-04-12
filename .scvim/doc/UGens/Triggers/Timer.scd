Timer			ugen that returns time since last triggered

Inherits from: Object : AbstractFunction : UGen

Timer.ar(trig)
Timer.kr(trig)

Timer returns time since last triggered. A trigger occurs when trig signal crosses from non-positive to positive.


	
// using timer to modulate sine frequency: the slower the trigger is the higher the frequency
(
{ var trig;
	trig = Impulse.kr(MouseX.kr(0.5, 20, 1));
	SinOsc.ar(Timer.kr(trig) * 500 + 500, 0, 0.2)
}.play;
)





