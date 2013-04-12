T2A		control rate trigger to audio rate trigger converter

inherits from: Object : AbstractFunction : UGen : K2A

Converts control rate trigger into audio rate trigger (maximally one per control period).

T2K.ar(in, offset)
in - input signal
offset - sample offset within control period

// example
(
{
	var trig = Impulse.kr(MouseX.kr(1, 100, 1));
	Ringz.ar(T2A.ar(trig), 800, 0.01) * 0.4
}.play;
)

// compare with K2A
(
{
	var trig = Impulse.kr(200);
	[T2A.ar(trig), K2A.ar(trig)].lag(0.001)
}.plot2(10/200);
)

// removing jitter by randomising offset
(
{
	var trig = Impulse.kr(MouseX.kr(1, 100, 1));
	Ringz.ar(T2A.ar(trig, WhiteNoise.kr.range(0, s.options.blockSize - 1)), 800, 0.01) * 0.4
}.play;
)



