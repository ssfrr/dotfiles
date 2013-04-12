abs			absolute value

a.abs
abs(a)


SimpleNumber

abs(-5);
-5.abs;

SequenceableCollection

[-2, -4, 3, 7, -2, [-1, -1, -2], [100, -100], -2, 1, 3].abs;

Symbol

\foo.abs; // returns itself. this is used in Envelopes see Env.

Point

Point(-1, 2).abs;

Function

f = abs({|x| sin(x) });
f.value((0..1000).normalize(0, 8pi)).plot;

UGen

(
{
	var a = SyncSaw.ar(100, 440, 0.1);
	a.abs // Absolute value
}.play
)

// compared to
(
{
	var a = SyncSaw.ar(100, 440, 0.1);
	a
}.play
)


