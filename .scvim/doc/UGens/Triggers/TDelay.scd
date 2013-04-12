TDelay			trigger delay

TDelay.ar(trigger, delayTime)

Delays a trigger by a given time. Any triggers which arrive in the time between
an input trigger and its delayed output, are ignored.
trigger - input trigger signal.
delayTime - delay time in seconds.


(
{
	z = Impulse.ar(2);
	[z * 0.1, ToggleFF.ar(TDelay.ar(z, 0.5)) * SinOsc.ar(mul: 0.1)]
}.scope)




