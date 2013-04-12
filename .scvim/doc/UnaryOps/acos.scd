acos			arccosine

a.acos
acos(a)



SimpleNumber

acos(0);
0.acos;

acos(0) == 0.5pi; // true
acos(2); // nan: no value of absolute value greater 1.0


SequenceableCollection

[0.5, 0.8, [-1, 1]].acos;
// acos is the reverse of cos:
c = sin(_ + 0.5pi); // cos function
c.([-1, -0.5, 0, 0.5, 1]).acos;

Symbol

\foo.acos; // returns itself. this is used in Envelopes see Env.


Function

f = acos({|x| sin(x) });
f.value((0..1000).normalize(0, 8pi)).plot;

UGen

(
{
	var a = LFSaw.ar(100);
	[a, a.acos]
}.plot
)

(
{
	var a;
	a = Line.ar(-1, 1, 0.01);
	(a.acos / 0.5pi) - 1
}.plot
)



