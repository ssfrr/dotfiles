midicps		convert MIDI note to cycles per second

a.midicps
midicps(a)

(
{
	Saw.ar(Line.kr(24,108,10).midicps, 0.2)
}.play)


