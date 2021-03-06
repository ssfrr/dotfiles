Ppar				embed event streams in parallel

superclass: ListPattern

Embeds several event streams so that they form a single output stream with all their events in temporal order.
When one stream ends, the other streams are further embedded until all have ended.

Ppar(list, repeats)
			
			list:			list of patterns or streams
			repeats:		repeat the whole pattern n times (default: 1)




// see the delta values in the resulting events
(
var a, b, c, t;
a = Pbind(\x, Pseq([1, 2, 3, 4]), \dur, 1);
b = Pbind(\x, Pseq([10, 20, 30, 40]), \dur, 0.4);
c = Ppar([a, b]);
t = c.asStream;
20.do({ t.next(Event.default).postln; });
)

// sound example
(
var a, b;
a = Pbind(\note, Pseq([7, 4, 0], 4), \dur, Pseq([1, 0.5, 1.5], inf));
b = Pbind(\note, Pseq([5, 10, 12], 4), \dur, 1);
Ppar([ a, b ]).play;
)



