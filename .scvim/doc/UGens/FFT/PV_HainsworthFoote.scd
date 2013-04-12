PV_HainsworthFoote

FFT onset detector based on work described in 

Hainsworth, S. (2003) Techniques for the Automated Analysis of Musical Audio. PhD, University of Cambridge engineering dept. See especially p128. The Hainsworth metric is a modification of the Kullback Liebler distance. 

The onset detector has general ability to spot spectral change, so may have some ability to track chord changes  aside from obvious transient jolts, but there's no guarantee it won't be confused by frequency modulation artifacts.   

Hainsworth metric on it's own gives good results but Foote might be useful in some situations: experimental. 


*ar(buffer, proph=0.0, propf=0.0, threshold=1.0, waittime=0.04)

buffer- FFT buffer to read from

proph- What strength of detection signal from Hainsworth metric to use.

propf- What strength of detection signal from Foote metric to use. The Foote metric is normalised to [0.0,1.0]

threshold- Threshold hold level for allowing a detection

waittime- If triggered, minimum wait until a further frame can cause another spot (useful to stop multiple detects on heavy signals)

See also FFT Overview.



// Examples


// just Hainsworth metric with low threshold
// external sound in
(
{
	var source1, signal, detect;
	
	source1 = SoundIn.ar(0);
	detect = PV_HainsworthFoote.ar(FFT(LocalBuf(2048), source1), 1.0, 0.0);
	signal = SinOsc.ar([440,445], 0, Decay.ar(0.1 * detect, 0.1));
	signal
}.play;	
)	



// spot note transitions		
(
{
 var source1, signal, detect;
	
	source1 = LFSaw.ar(LFNoise0.kr(1, 90, 400), 0, 0.5);
	detect = PV_HainsworthFoote.ar(FFT(LocalBuf(2048), source1), 1.0, 0.0, 0.9, 0.5);
	signal = SinOsc.ar(440, 0, Decay.ar(0.1 * detect, 0.1));
	[source1, signal];
}.play;	
)

// not so sucessful with this test sound: 
// mouse y is difficulty, mouse x is threshold
(
{
	var source1, detect, difficulty, rate, trig, n = 20;
	rate = LFNoise1.kr(0.3).exprange(1, 5);
	difficulty = MouseY.kr(0, 1);
	trig = Impulse.kr(rate);
	source1 = { |i|
		var t = CoinGate.kr(1 - difficulty, trig);
		SinOsc.ar(TExpRand.kr(300, 1000, t) * (i + 1)) * TRand.kr(0, 1, t) 
	}.dup(10).sum;
	// source1 = source1 * Decay.kr(trig, 0.5);
	detect = PV_HainsworthFoote.ar(FFT(LocalBuf(2048), source1), threshold: MouseX.kr(0.01, 1.0));
	WhiteNoise.ar * Decay.ar(detect, 0.1) + (source1 * 0.2);
}.play;	
)


// tests using sound in

// Foote solo - never triggers with threshold over 1.0, threshold under mouse control
	
(
{
 var source1, signal, detect;
	
	source1 = SoundIn.ar(0); 
	
	detect = PV_HainsworthFoote.ar(FFT(LocalBuf(2048), source1), 0.0, 1.0, 
		MouseX.kr(0.0,1.1), 0.02);
	signal = SinOsc.ar(440, 0, Decay.ar(0.1 * detect, 0.1));
	[source1, signal];
}.play;	
)


// compare to Amplitude UGen
(
{
 var source1, signal, detect;
	
	source1= SoundIn.ar(0); 
	
	detect= (Amplitude.ar(source1)) > (MouseX.kr(0.0,1.1));
	signal = SinOsc.ar(440, 0, Decay.ar(0.1 * detect, 0.1));
	[source1, signal];
}.play;	
)









