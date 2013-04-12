asin			arcsine

a.asin
asin(a)



SimpleNumber

asin(1);
1.asin;

asin(1) == 0.5pi; // true
asin(2); // nan: no value of absolute value greater 1.0


SequenceableCollection

[0.5, 0.8, [-1, 1]].asin;
// asin is the reverse of sin:
asin(sin([-1, -0.5, 0, 0.5, 1]));

Symbol

\foo.asin; // returns itself. this is used in Envelopes see Env.


Function

f = asin({|x| 1 / x });
f.value((0..1000).normalize(1, 8)).plot;

UGen

(
{
	var a = LFSaw.ar(100);
	[a, a.asin]
}.plot(minval: -2pi, maxval: 2pi)
)

(
{
	var a;
	a = Line.ar(-1, 1, 0.01);
	(a.asin / 0.5pi) - 1
}.plot(minval: -2pi, maxval: 2pi)
)



