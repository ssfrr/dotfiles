PV_JensenAndersen

FFT feature detector for onset detection based on work described in 

Jensen,K. & Andersen, T. H. (2003). Real-time Beat Estimation Using Feature Extraction. 
In Proceedings of the Computer Music Modeling and Retrieval Symposium, Lecture Notes in Computer Science. Springer Verlag.

First order derivatives of the features are taken. Threshold may need to be set low to pick up on changes. 

*ar(buffer, propsc=0.25, prophfe=0.25, prophfc=0.25, propsf=0.25, threshold=1.0, waittime=0.04)

buffer- FFT buffer to read from.

propsc- Proportion of spectral centroid feature.

prophfe- Proportion of high frequency energy feature.

prophfc- Proportion of high frequency content feature.

propsf- Proportion of spectral flux feature.

threshold- Threshold level for allowing a detection

waittime- If triggered, minimum wait until a further frame can cause another spot (useful to stop multiple detects on heavy signals)

See also FFT Overview.



// Examples

// external sound in		
(
{
	var source1, detect;
	source1 = SoundIn.ar(0); 
	detect = PV_JensenAndersen.ar(FFT(LocalBuf(2048), source1), threshold:MouseX.kr(0.1,1.0));
	SinOsc.ar([440, 445], 0, Decay.ar(0.1 * detect, 0.1));
}.play;	
)


// using test sound: 
// mouse y is difficulty, mouse x is threshold
(
{
	var source1, detect, difficulty, rate;
	rate = LFNoise1.kr(0.3).exprange(1, 5);
	difficulty = MouseY.kr(0.01, 0.4, 1);
	source1 = Decay.ar(Impulse.ar(rate), 0.5 / rate, 1 - difficulty, difficulty);
	source1 = source1 * PinkNoise.ar(1.dup);
	detect = PV_JensenAndersen.ar(FFT(LocalBuf(2048), source1), threshold: MouseX.kr(0.1,1.0));
	SinOsc.ar([440, 445], 0, Decay.ar(0.1 * detect, 0.1)) + source1;
}.play;	
)




