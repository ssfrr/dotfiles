MostChange 			output most changed


MostChange.ar(in1, in2)
MostChange.kr(in1, in2)

output the input that changed most

in1, in2 -  inputs


see also: LeastChange, InRange



(
d = { arg amp=1.0;
	var in1, in2;
	in1 = LFNoise1.ar(800, amp);
	in2 = SinOsc.ar(800);
	MostChange.ar(in1, in2) * 0.1;
}.play;
)

d.set(\amp, 0.1);
d.set(\amp, 0);
d.set(\amp, 3);
d.free;


the control that changed most is used as output:


(
d = { arg freq=440;
	var internalFreq;
	internalFreq = LFNoise0.ar(0.3, 300, 800);
	SinOsc.ar(
			MostChange.kr(freq, internalFreq) // two sources of change: one external, one internal
	) * 0.1
}.play
);

d.set(\freq, 800);
d.set(\freq, 800); // nothing changed in this input
d.set(\freq, 900);
d.free;




