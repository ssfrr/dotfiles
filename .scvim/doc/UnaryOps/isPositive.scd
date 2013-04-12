isPositive		test if signal is >= 0

a.isPositive
isPositive(a)

(
{
	var a;
	a = Line.ar(-1, 1, 0.01);
	a.isPositive
}.plot)


