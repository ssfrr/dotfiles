TDuty				demand results as trigger from demand rate ugens

Inherits from: Object : AbstractFunction : UGen : Duty

TDuty.ar(dur, reset,  level, doneAction)
TDuty.kr(dur, reset,  level, doneAction)


(Note that for sc 3.2, TDuty has changed. For the old behaviour, use TDuty_old.) 

A value is demanded each ugen in the list and output  as a trigger according to a stream of duration values. 
The unit generators in the list should be 'demand' rate.

When there is a trigger at the reset input, the demand rate ugens in the list and the duration are reset.
The reset input may also be a demand ugen, providing a stream of reset times.

see also: Demand, Duty

dur			time values. Can be a demand ugen or any signal. 
			The next trigger value is acquired after the duration provided by the last time value.
		
reset		trigger or reset time values. Resets the list of ugens and the duration ugen when triggered.
			The reset input may also be a demand ugen, providing a stream of reset times.


level			demand ugen providing the output values.


doneAction	a doneAction that is evaluated when the duration stream ends.
			See UGen-doneActions for more detail.






// examples

s.boot;


// play a little rhythm

{ TDuty.ar(Dseq([0.1, 0.2, 0.4, 0.3], inf)) }.play; // demand ugen as durations



// amplitude changes
(
	{
		var trig;
		trig = TDuty.ar(
				Dseq([0.1, 0.2, 0.4, 0.3], inf), // demand ugen as durations
				0, 
				Dseq([0.1, 0.4, 0.01, 0.5, 1.0], inf) // demand ugen as amplitude
			); 
		Ringz.ar(trig, 1000, 0.1)
	
	}.play;
)

(
	{
		var trig;
		trig = TDuty.ar(
				MouseX.kr(0.001, 2, 1), // control rate ugen as durations
				0, 
				Dseq([0.1, 0.4, 0.01, 0.5, 1.0], inf)
			); 
		Ringz.ar(trig, 1000, 0.1)
	
	}.play;
)




// demand ugen as audio oscillator

(
	{
		var a, trig, n=5, m=64;
		a = {
			var x;
			x = { 0.2.rand2 } ! m;
			x = x ++ ({  Drand({ 0.2.rand2 } ! n) } ! m.rand);
			Dseq(x.scramble, inf)
		} ! n;
		trig = TDuty.ar(
				MouseX.kr(1, 2048, 1) * SampleDur.ir * [1, 1.02],
				0,
				Dswitch1(a, MouseY.kr(0, n-1))
			);
		Ringz.ar(trig, 1000, 0.01)
	
	}.play;
)


// single impulses

(
SynthDef("delta_demand", { arg amp=0.5, out;
	OffsetOut.ar(out,
		TDuty.ar(Dseq([0]), 0, amp, 2)
	)
}).send(s);
)

fork { 10.do { s.sendBundle(0.2, ["/s_new", "delta_demand", -1]); 1.0.rand.wait } };


// chain of impulses
(
SynthDef("delta_demand2", {
	OffsetOut.ar(0,
		TDuty.ar(Dgeom(0.05, 0.9, 20), 0, 0.5, 2)
	)
}).send(s);
)

fork { 10.do { s.sendBundle(0.2, ["/s_new", "delta_demand2", -1]); 1.0.rand.wait } };



// multichannel expansion

(
	{
		var t;
		t = TDuty.ar(
				Drand([Dgeom(0.1, 0.8, 20), 1, 2], inf) ! 2,
				0, 
				[Drand({ 1.0.rand } ! 8, inf), Dseq({ 1.0.rand } ! 8, inf)] * 2
			); 
		x = Ringz.ar(t, [400, 700], 0.1) * 0.1;
	
	}.play;
)




