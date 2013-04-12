atan			arctangent

a.atan
atan(a)



SimpleNumber

atan(1);
1.atan;

atan(1) == 0.25pi; // true
atan(2000.1); // any value can be mapped into the range of -0.5pi .. 0.5pi by atan


SequenceableCollection

(-100..100).atan.plot;
// atan is the reverse of tan:
atan(tan([-1, -0.5, 0, 0.5, 1]));

Symbol

\foo.atan; // returns itself. this is used in Envelopes see Env.


Function

f = atan({|x| sin(x) });
f.value((0..1000).normalize(1, 8)).plot;

UGen


(
{
	var a;
	a = Line.ar(0, 100, 0.01);
	(a.atan / 0.25pi) - 1
}.plot
)



