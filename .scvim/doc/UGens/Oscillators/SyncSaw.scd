SyncSaw				hard sync sawtooth wave

SyncSaw.ar(ksyncFreq, ksawFreq, mul, add)

A sawtooth wave that is hard synched to a fundamental pitch. This produces an effect similar to  moving formants or pulse width modulation. The sawtooth oscillator has its phase reset when the sync oscillator completes a cycle. This is not a band limited waveform, so it may alias.

ksyncFreq - frequency of the fundamental.
ksawFreq - frequency of the slave synched sawtooth wave. sawFreq should always be greater than syncFreq.



{ SyncSaw.ar(100, Line.kr(100, 800, 12), 0.1) }.play;


(
plot { [
	SyncSaw.ar(800, 1200),
	Impulse.ar(800) // to show sync rate
] }
)

(
plot { [
	SyncSaw.ar(800, Line.kr(800, 1600, 0.01)), // modulate saw freq
	Impulse.ar(800) // to show sync rate
] }
)

// scoping the saw: hit 's' when focused on the scope window to compare the channels
(
scope { 
	var freq = 400;
	[
	SyncSaw.ar(freq, freq * MouseX.kr(1, 3)), // modulate saw freq
	Impulse.ar(freq) // to show sync rate
] * 0.3 }
)





