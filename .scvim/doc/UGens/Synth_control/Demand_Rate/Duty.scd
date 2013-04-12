Duty				demand results from demand rate ugens

Inherits from: Object : AbstractFunction : UGen

Duty.ar(dur, reset, level, doneAction)
Duty.kr(dur, reset, level, doneAction)

See also: TDuty, Demand

A value is demanded each ugen in the list and output according to a stream of duration values. 
The unit generators in the list should be 'demand' rate.

When there is a trigger at the reset input, the demand rate ugens in the list and the duration are reset.
The reset input may also be a demand ugen, providing a stream of reset times.


dur			time values. Can be a demand ugen or any signal. 
			The next level is acquired after duration.
		
reset		trigger or reset time values. Resets the list of ugens and the duration ugen when triggered.
			The reset input may also be a demand ugen, providing a stream of reset times.


level			demand ugen providing the output values.

doneAction	a doneAction that is evaluated when the duration stream ends.
			See UGen-doneActions for more detail.






// examples


(
	{
		var freq;
		freq = Duty.kr(
				Drand([0.01, 0.2, 0.4], inf), // demand ugen as durations
				0, 
				Dseq([204, 400, 201, 502, 300, 200], inf)
			); 
		SinOsc.ar(freq * [1, 1.01]) * 0.1
	
	}.play;
)

(
	{
		var freq;
		freq = Duty.kr(
				MouseX.kr(0.001, 2, 1), // control rate ugen as durations
				0, 
				Dseq([204, 400, 201, 502, 300, 200], inf)
			); 
		SinOsc.ar(freq * [1, 1.01]) * 0.1
	
	}.play;
)



// resetting the demand ugens

(
	{
		var freq;
		freq = Duty.kr(
				Dseq([0.2, 0.3, 0.4, Dseq([1, 1, 1, 2, 1, 2], inf)]) / 2, 
				Dust.kr(1), // control rate reset
				Dseq([0, 1, 2, Dseq([1, 2, 3, 4, 5], inf)])
			) * 30 + 250; 
		SinOsc.ar(freq * [1, 1.01]) * 0.1
	
	}.play;
)

(
	{
		var freq;
		freq = Duty.kr(
				Dseq([0.2, 0.3, 0.4, Dseq([1, 1, 1, 2, 1, 2], inf)]) / 2, 
				Dseq([1, 2, 4, 5], inf), // demand rate reset
				Dseq([0, 1, 2, Dseq([1, 2, 3, 4, 5], inf)])
			) * 30 + 250; 
		SinOsc.ar(freq * [1, 1.01]) * 0.1
	
	}.play;
)


// demand ugen as audio oscillator

(
	{
		var a, n=5, m=64;
		a = {
			var x;
			x = { 0.2.rand2 } ! m;
			x = x ++ ({  Drand({ 0.2.rand2 } ! n) } ! m.rand);
			Dseq(x.scramble, inf)
		} ! n;
		Duty.ar(
				MouseX.kr(1, 125, 1) * SampleDur.ir * [1, 1.02],
				0,
				Dswitch1(a, MouseY.kr(0, n-1))
			)
	
	}.play;
)

// single sample feedback: a lin cong algorithm
(
b = Buffer.alloc(s, 1);
{
var x, y, rate, a, c, m;
	rate = MouseX.kr(100, SampleRate.ir);
	a = 1.1;
	c = 0.13;
	m = 1.0;
	x = Dbufrd(b); // read from buffer
	x = x * a + c % m;
	y = Dbufwr(x, b); // write to buffer
	Duty.ar(1 / rate, 0, y) * 0.1;
}.play;
)



