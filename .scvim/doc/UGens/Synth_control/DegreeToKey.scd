DegreeToKey		convert signal to modal pitch

DegreeToKey.ar(bufnum, in, octave, mul, add)

The input signal value is truncated to an integer value and used as an index into an octave repeating table of note values. Indices wrap around the table and shift octaves as they do.

bufnum - index of the buffer which contains the steps for each scale degree.
in - the input signal.
octave - the number of steps per octave in the scale. The default is 12.


(
// modal space
// mouse x controls discrete pitch in dorian mode
var scale;
scale = FloatArray[0, 2, 3.2, 5, 7, 9, 10]; // dorian scale

play({
	var mix;
	
	mix = 
	
	// lead tone
	SinOsc.ar(
		(
			DegreeToKey.kr(
				LocalBuf.newFrom(scale),
				MouseX.kr(0,15),		// mouse indexes into scale
				12,					// 12 notes per octave
				1,					// mul = 1
				72					// offset by 72 notes
			) 
			+ LFNoise1.kr([3,3], 0.04)	// add some low freq stereo detuning
		).midicps,						// convert midi notes to hertz
		0,
		0.1)
		
	// drone 5ths
	+ RLPF.ar(LFPulse.ar([48,55].midicps, 0.15),
		SinOsc.kr(0.1, 0, 10, 72).midicps, 0.1, 0.1);
		
	// add some 70's euro-space-rock echo
	CombN.ar(mix, 0.31, 0.31, 2, 1, mix)
})
)



