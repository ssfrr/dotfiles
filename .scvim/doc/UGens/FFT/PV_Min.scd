PV_Min					minimum magnitude

PV_Min(bufferA,  bufferB)

Output copies bins with the minimum magnitude of the two inputs.
bufferA - fft buffer A.
bufferB - fft buffer B.

See also FFT Overview.

s.boot;

(
{
	var inA, chainA, inB, chainB, chain ;
	inA = Saw.ar(LFNoise1.kr(2).exprange(10, 1000));
	inB =  Pulse.ar(LFNoise1.kr(2).exprange(10, 1000));
	chainA = FFT(LocalBuf(2048), inA);
	chainB = FFT(LocalBuf(2048), inB);
	chain = PV_Min(chainA, chainB); 
	0.1 * IFFT(chain).dup;
}.play
);


// stereo version:

(
{
	var inA, chainA, inB, chainB, chain ;
	inA = Saw.ar(LFNoise1.kr(2).exprange(10, 1000)); // same saw through different pulses
	inB =  Pulse.ar(LFNoise1.kr(2.dup).exprange(10, 1000));
	chainA = FFT(LocalBuf(2048.dup), inA);
	chainB = FFT(LocalBuf(2048.dup), inB);
	chain = PV_Min(chainA, chainB); 
	0.1 * IFFT(chain);
}.play
);



(
SynthDef(\help_max, { arg out=0, soundBufnum1=0, soundBufnum2 = 0;
	var inA, chainA, inB, chainB, chain ;
	inA = PlayBuf.ar(1, soundBufnum1, BufRateScale.kr(soundBufnum1), loop: 1);
	inB =  PlayBuf.ar(1, soundBufnum2, BufRateScale.kr(soundBufnum2), loop: 1);
	chainA = FFT(LocalBuf(2048), inA);
	chainB = FFT(LocalBuf(2048), inB);
	chain = PV_Min(chainA, chainB); 
	Out.ar(out,  0.5 * IFFT(chain).dup);
}).store;
);


(
q = q ? (); // use global dictionary

	q[\bufferA] = Buffer.read(s,"sounds/a11wlk01.wav");
	CocoaDialog.getPaths({ arg paths; // get a second soundfile;
	paths.do({ arg p; 
		q[\bufferB] = Buffer.read(s, p);
		Synth(\help_max, [\out, 0, \soundBufnum1, q[\bufferA], \soundBufnum2, q[\bufferB]]);
	})
},{
	"cancelled".postln;
});
)

q[\bufferA].free;
q[\bufferB].free;


