Amplitude		amplitude follower

Amplitude.kr(in, attackTime, releaseTime, mul, add)


Tracks the peak amplitude of a signal.
in - input signal.
attackTime - 60dB convergence time for following attacks.
releaseTime - 60dB convergence time for following decays.



(
// use input amplitude to control SinOsc frequency
{
	SinOsc.ar(
			Amplitude.kr(
						Blip.ar(3, 20) * LFNoise1.kr(0.1).range(0, 1),
						MouseX.kr(0.001, 1, 1),
						MouseY.kr(0.001, 1, 1),
						1200,
						400
			),
			0, 0.3)
}.play;
)


// use input amplitude to control Pulse amplitude - use headphones to prevent feedback.
{ Pulse.ar(90, 0.3, Amplitude.kr(SoundIn.ar(0))) }.play;


(
// use input amplitude to control SinOsc frequency - use headphones to prevent feedback.
{
	SinOsc.ar(
			Amplitude.kr(
						SoundIn.ar(0),
						0.01,
						0.01,
						1200,
						400
			),
			0, 0.3)
}.play;
)



