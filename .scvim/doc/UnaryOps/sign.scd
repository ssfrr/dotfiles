sign			sign function

a.sign
sign(a)

-1 when a < 0, +1 when a > 0, 0 when a is 0

(
{
	var a;
	a = Line.ar(-1, 1, 0.01);
	[ a, a.sign ]
}.plot)



