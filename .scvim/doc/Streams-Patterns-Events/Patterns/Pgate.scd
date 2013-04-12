Pgate			gated stream advances only when an event key is true	

Inherits from: Object : AbstractFunction : Pattern : FilterPattern : Pn

Pgate(pattern, n, key)

Pgate advances its subpattern whenever key is true.  
Pgate must be used within an Event pattern

See also:  Pn

Examples

// Pn advances Pgate each time its subpattern is repeated
(
Pbind(

	\degree,		Pn(Pseq((0..7)), inf, \step),
	\mtranspose,	Pgate(Pwhite(0,5), inf, \step),
	\dur, 0.2
).play
)


// Two different Pgates advanced at two different rates
(
Pbind(

	foo,			Pn(Pseq((0..3)),inf,  \step1),
	degree,		Pn(Pseq((0..7)), inf, \step),
	mtranspose,	Pgate(Pwhite(0,5), inf, \step) + 
				Pgate(Pseq([0,7,0,-7]), inf, \step1),
	dur, 0.2
).play
)


