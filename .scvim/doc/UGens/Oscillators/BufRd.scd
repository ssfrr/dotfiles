BufRd		buffer reading oscillator



read the content of a buffer at an index. 
see also BufWr



BufRd.ar(numChannels, bufnum, phase, loop, interpolation)

	numChannels 	number of channels that the buffer will be.
				this must be a fixed integer. The architecture of the SynthDef
				cannot change after it is compiled.
				warning: if you supply a bufnum of a buffer that has a different
				numChannels then you have specified to the BufRd, it will
				fail silently.
	
	bufnum		the index of the buffer to use
	phase &nbsp; 		audio rate modulatable index into the buffer. Warning: The phase argument only offers precision for addressing 2**24 samples (about 6.3 minutes at 44100Hz).
	loop&nbsp; &nbsp; &nbsp; 		1 means true, 0 means false.&nbsp; this is modulatable.
	interpolation&nbsp; &nbsp; 1 means no interpolation, 2 is linear, 4 is cubic interpolation



in comparison to PlayBuf:
	PlayBuf plays through the buffer by itself,
	BufRd only moves its read point by the phase input
		and therefore has no pitch input
			
	BufRd has variable interpolation



(
// read a whole sound into memory
s = Server.local;
// note: not *that* columbia, the first one
s.waitForBoot{
	s.sendMsg("/b_allocRead", 0, "sounds/a11wlk01.wav");
}
)

//use any AUDIO rate ugen as an index generator

{ BufRd.ar(1, 0, SinOsc.ar(0.1) * BufFrames.ir(0)) }.play;
{ BufRd.ar(1, 0, LFNoise1.ar(1) * BufFrames.ir(0)) }.play;
{ BufRd.ar(1, 0, LFNoise1.ar(10) * BufFrames.ir(0)) }.play;
{ BufRd.ar(1, 0, LFTri.ar(0.1) + LFTri.ar(0.23) * BufFrames.ir(0)) }.play;
// original duration
{ BufRd.ar(1, 0, LFSaw.ar(BufDur.ir(0).reciprocal).range(0, BufFrames.ir(0)) ) }.play;


//use a phasor index into the file

{ BufRd.ar(1, 0, Phasor.ar(0, BufRateScale.kr(0), 0, BufFrames.kr(0))) }.play;


//change rate and interpolation
(
x = { arg rate=1, inter=2; 
	BufRd.ar(1, 0, Phasor.ar(0, BufRateScale.kr(0) * rate, 0, BufFrames.kr(0)), 1, inter) 
}.play;
)

x.set(\rate, 0.9);
x.set(\rate, 0.6);
x.set(\inter, 1);
x.set(\inter, 0);


//write into the buffer with a BufWr
(
y = { arg rate=1; 
	var in;
	in = SinOsc.ar(LFNoise1.kr(2, 300, 400), 0, 0.1);
	BufWr.ar(in, 0, Phasor.ar(0, BufRateScale.kr(0) * rate, 0, BufFrames.kr(0)));
	0.0 //quiet
}.play;
)

//read it with a BufRd
(
x = { arg rate=1; 
	BufRd.ar(1, 0, Phasor.ar(0, BufRateScale.kr(0) * rate, 0, BufFrames.kr(0))) 
}.play;
)



x.set(\rate, 5);
y.set(\rate, 2.0.rand);
x.set(\rate, 2);







