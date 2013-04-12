LeakDC		remove DC offset

Inherits from: Object : AbstractFunction : UGen : Filter 


LeakDC.ar(in, coef, mul, add)
LeakDC.kr(in, coef, mul, add)

This filter removes a DC offset from a signal.
in - input signal.
coef - leak coefficient. Defaults to 0.995 for audiorate and 0.9 for controlrate.


Server.internal.boot;

(
{
	var a;
	a = LFPulse.ar(800, 0.5, 0.5, 0.5);
	[a, LeakDC.ar(a, 0.995)]
}.scope(bufsize: 22050)
)


