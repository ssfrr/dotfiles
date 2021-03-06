Phasor			a resettable linear ramp between two levels

superclass: UGen

Phasor is a linear ramp between start and end values. When its trigger input crosses from non-positive to positive, Phasor's output will jump to its reset position. Upon reaching the end of its ramp Phasor will wrap back to its start. N.B. Since end is defined as the wrap point, its value is never actually output.

Phasor is commonly used as an index control with BufRd and BufWr.

	
	*ar(trig, rate, start, end, resetPos)
	*kr(trig, rate, start, end, resetPos)

		trig
			when triggered, reset value to resetPos (default: 0, Phasor outputs start initially)
		rate
			the amount of change per sample
			i.e at a rate of 1 the value of each sample will be 1 greater than the preceding sample
		
		start, end
			start and end points of ramp. 
		
		resetPos
			the value to jump to upon receiving a trigger.


	
// phasor controls sine frequency: end frequency matches a second sine wave.

(
{ var trig, rate, x, sr;
	rate = MouseX.kr(0.2, 2, 1);
	trig = Impulse.ar(rate);
	sr = SampleRate.ir;
	x = Phasor.ar(trig, rate / sr);
	SinOsc.ar(
		[
			LinLin.kr(x, 0, 1, 600, 1000), // convert range from 0..1 to 600..1000
			1000 // constant second frequency
		], 0, 0.2)

}.play;
)


// two phasors control two sine frequencies: mouse y controls resetPos of the second
(
{ var trig, rate, x, sr;
	rate = MouseX.kr(1, 200, 1);
	trig = Impulse.ar(rate);
	sr = SampleRate.ir;
	x = Phasor.ar(trig, rate / sr, 0, 1, [0, MouseY.kr(0, 1)]);
	SinOsc.ar(x * 500 + 500, 0, 0.2)
}.play;
)


// use phasor to index into a sound file

// allocate a buffer with a sound file
b = Buffer.read(s, "sounds/a11wlk01.wav");

// simple playback (more examples: see BufRd)
// Start and end here are defined as 0 and the number of frames in the buffer.
// This means that the Phasor will output values from 0 to numFrames - 1 before looping,
// which is perfect for driving BufRd. (See note above)
{ BufRd.ar(1, b, Phasor.ar(0, BufRateScale.kr(b), 0, BufFrames.kr(b))) }.play;


// two phasors control two sound file positions: mouse y controls resetPos of the second
(
{ var trig, rate, framesInBuffer;
	rate = MouseX.kr(0.1, 100, 1);
	trig = Impulse.ar(rate);
	framesInBuffer = BufFrames.kr(b);
	x = Phasor.ar(trig, BufRateScale.kr(b), 0, framesInBuffer, 
		[0, MouseY.kr(0, framesInBuffer)]);
	BufRd.ar(1, b, x);
}.play;
)





