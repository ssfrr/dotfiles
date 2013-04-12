sqrt			square root

a.sqrt
sqrt(a)

The definition of square root is extended for signals so that sqrt(a) when a<0 returns
-sqrt(-a).

(
{
	var a;
	a = Line.ar(-1, 1, 0.01);
	[ a, a.sqrt ]
}.plot)



