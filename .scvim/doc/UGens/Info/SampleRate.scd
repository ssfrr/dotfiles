SampleRate			server sample rate

superclass: InfoUGenBase

returns the current sample rate of the server

	*ir
			
// example

{ SampleRate.ir.poll }.play;

// compares a 441 Hz sine tone derived from sample rate (44100 * 0.01, left) 
// with a 440 Hz tone (right), resultin in a 1 Hz beating
(
{ 
	var freq;
	freq = [ SampleRate.ir(0) * 0.01, 440];
	SinOsc.ar(freq, 0, 0.1) 
}.play; 
)

// play a pulse chord at power of two divisions of sample rate

{ LFPulse.ar(SampleRate.ir * (2 ** (1..14).neg).postln).mean * 0.1 }.play;


