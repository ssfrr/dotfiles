Pitch						autocorrelation pitch follower

#freq, hasFreq = Pitch.kr(in, initFreq, minFreq, maxFreq, execFreq, maxBinsPerOctave, median, ampThreshold, peakThreshold, downSample, clar)
			
This is a better pitch follower than ZeroCrossing, but more costly of CPU. For most purposes the default settings can be used and only in needs to be supplied. Pitch returns two values (via an Array of OutputProxys, see the OutputProxy help file), a freq which is the pitch estimate and hasFreq, which tells whether a pitch was found. Some vowels are still problematic, for instance a wide open mouth sound somewhere between a low pitched short 'a'  sound as in 'sat', and long 'i' sound as in 'fire', contains enough overtone energy to confuse the algorithm. 

Examples: (use headphones!)


s = Server.local;

(
SynthDef("pitchFollow1",{
	var in, amp, freq, hasFreq, out;
	in = Mix.new(SoundIn.ar([0,1]));
	amp = Amplitude.kr(in, 0.05, 0.05);
	# freq, hasFreq = Pitch.kr(in, ampThreshold: 0.02, median: 7);
	//freq = Lag.kr(freq.cpsmidi.round(1).midicps, 0.05);
	out = Mix.new(VarSaw.ar(freq * [0.5,1,2], 0, LFNoise1.kr(0.3,0.1,0.1), amp));
	6.do({
		out = AllpassN.ar(out, 0.040, [0.040.rand,0.040.rand], 2)
	});
	Out.ar(0,out)
}).play(s);
)

(
SynthDef("pitchFollow2",{
	var in, amp, freq, hasFreq, out;
	in = Mix.new(SoundIn.ar([0,1]));
	amp = Amplitude.kr(in, 0.05, 0.05);
	# freq, hasFreq = Pitch.kr(in, ampThreshold: 0.02, median: 7);
	out = CombC.ar(LPF.ar(in, 1000), 0.1, (2 * freq).reciprocal, -6).distort * 0.05;
	6.do({
		out = AllpassN.ar(out, 0.040, [0.040.rand,0.040.rand], 2)
	});
	Out.ar(0,out);
}).play(s);
)


How it works:
The pitch follower executes periodically at the rate specified by execFreq in cps. execFreq is clipped to be between minFreq and maxFreq . First it detects whether the input peak to peak amplitude is above the ampThreshold. If it is not then no pitch estimation is performed, hasFreq is set to zero and freq is held at its previous value. It performs an autocorrelation on the input and looks for the first peak after the peak around the lag of zero that is above peakThreshold times the amplitude of the peak at lag zero. 

If the clar argument is greater than zero (it is zero by default) then hasFreq is given additional detail. Rather than simply being 1 when a pitch is detected, it is a "clarity" measure in the range between zero and one. (Technically, it's the height of the autocorrelation peak normalised by the height of the zero-lag peak.) It therefore gives a kind of measure of "purity" of the pitched signal.

Using a peakThreshold of one half does a pretty good job of eliminating overtones, and finding the first peak above that threshold rather than the absolute maximum peak does a good job of eliminating estimates that are actually multiple periods of the wave. 

The autocorrelation is done coarsely at first using a maximum of maxBinsPerOctave lags until the peak is located. Then a fine resolution search is performed until the peak is found. (Note that maxBinsPerOctave does NOT affect the final pitch resolution; a fine resolution search is always performed. Setting maxBinsPerOctave larger will cause the coarse search to take longer, and setting it smaller will cause the fine search to take longer.)

The three values around the peak are used to find a fractional lag value for the pitch. If the pitch frequency is higher than maxFreq, or if no peak is found above minFreq, then hasFreq is set to zero and freq is held at its previous value.

It is possible to put a median filter of length median on the output estimation so that outliers and jitter can be eliminated. This will however add latency to the pitch estimation for new pitches, because the median filter will have to become half filled with new values before the new one becomes the median value. If median is set to one then that is equivalent to no filter, which is the default.

When an in range peak is found, it is inserted into the median filter, a new pitch is read out of the median filter and output as freq, and hasFreq is set to one.

It is possible to down sample the input signal by an integer factor downSample in order to reduce CPU overhead. This will also reduce the pitch resolution.

Until Pitch finds a pitch for the first time, it will output initFreq.

None of these settings are time variable.

Default Argument values:
	initFreq = 440.0
	minFreq = 60.0
	maxFreq = 4000.0
	execFreq = 100.0
	maxBinsPerOctave = 16
	median = 1
	ampThreshold = 0.01
	peakThreshold = 0.5
	downSample = 1
	clar = 0



