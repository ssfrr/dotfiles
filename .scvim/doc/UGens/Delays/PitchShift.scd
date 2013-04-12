PitchShift

PitchShift.ar(in, windowSize, pitchRatio, pitchDispersion, timeDispersion, mul, add)

A time domain granular pitch shifter.
Grains have a triangular amplitude envelope and an overlap of 4:1.
in - the input signal.
windowSize - the size of the grain window in seconds. This value cannot be modulated.
pitchRatio - the ratio of the pitch shift. Must be from 0.0 to 4.0.
pitchDispersion - the maximum random deviation of the pitch from the pitchRatio.
timeDispersion - a random offset of from zero to timeDispersion seconds is added to the delay
of each grain. Use of some dispersion can alleviate a hard comb filter effect due to uniform
grain placement. It can also be an effect in itself. timeDispersion can be no larger than windowSize.

(
play({
	z = Blip.ar(800, 6, 0.1);
	PitchShift.ar(z, 0.02, Line.kr(0.1,4,20), 0, 0.0001)
}))

(
// pitch shift input - USE HEADPHONES to prevent feedback.
play({
	PitchShift.ar(
		SoundIn.ar([0,1]),	// stereo audio input
		0.1, 			// grain size
		MouseX.kr(0,2),	// mouse x controls pitch shift ratio
		0, 				// pitch dispersion
		0.004			// time dispersion
	)
}))

(
// use PitchShift to granulate input - USE HEADPHONES to prevent feedback.
// upper left corner is normal playback. x = pitch dispersion, y = time dispersion
var grainSize;
grainSize = 0.5;
play({
	PitchShift.ar(
		SoundIn.ar([0,1]), 
		grainSize, 		
		1,						// nominal pitch rate = 1
		MouseX.kr(0,1), 			// pitch dispersion
		MouseY.kr(0, grainSize)	// time dispersion
	)
}))



