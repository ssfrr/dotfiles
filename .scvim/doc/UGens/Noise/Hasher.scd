Hasher				randomized value

Hasher.ar(in, mul, add)

Returns a unique output value from zero to one for each input value according to a hash function. The same input value will always produce the same output value. The input need not be from zero to one.
in - input signal



{ Hasher.ar(Line.ar(0,1,1), 0.2) }.play;

(
{
	SinOsc.ar(
		Hasher.kr(MouseX.kr(0,10).round(1), 300, 500)
	) * 0.1 
}.play;
)

(
{
	SinOsc.ar(
		Hasher.kr(MouseX.kr(0,10).round(1) + 0.0001, 300, 500)
	) * 0.1 
}.play;
)

(
{
	SinOsc.ar(
		Hasher.kr(MouseX.kr(0,10), 300, 500)
	) * 0.1 
}.play;
)



