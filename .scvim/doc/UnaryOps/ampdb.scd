ampdb			convert linear amplitude to decibels

a.ampdb
ampdb(a)


SimpleNumber

0.1.ampdb;
(ampdb(0.1).asString ++ " decibels");


SequenceableCollection

[0.001, 0.01, 0.1, 1, 10].ampdb;

Symbol

\foo.ampdb; // returns itself. this is used in Envelopes see Env.


Function

f = ampdb({|x| sin(x) + 1 });
f.value((0..1000).normalize(0, 8pi)).plot;

UGen

(
{
	var a = LFSaw.ar(100).range(0.0001, 10);
	[a, a.ampdb]
}.plot(minval: -60, maxval: 10)
)


