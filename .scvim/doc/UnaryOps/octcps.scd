octcps			convert decimal octaves to cycles per second

a.octcps
octcps(a)

(
{
	Saw.ar(Line.kr(2,9,10).octcps, 0.2)
}.play)


