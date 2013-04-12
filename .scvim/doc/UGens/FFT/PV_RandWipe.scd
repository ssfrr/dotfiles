PV_RandWipe				crossfade in random bin order

Inherits from: Object : AbstractFunction : UGen : PV_ChainUGen 

PV_RandWipe(bufferA,  bufferB,  wipe,  trig)

Cross fades between two sounds by copying bins in a random order.
bufferA - fft buffer A.
bufferB - fft buffer B.
wipe - copies bins from bufferB in a random order as wipe goes from 0 to 1.
trig - a trigger selects a new random ordering.

See also FFT Overview.



(
// trig with MouseY
{
	var inA, chainA, inB, chainB, chain;
	inA = Mix.fill(6, { LFSaw.ar(exprand(200, 1000), 0, 0.1) });	
	inB = Mix.fill(6, { 
		LFPulse.ar(exprand(80, 400), 0, 0.2, SinOsc.kr(4.0.linrand, 0, 0.2).max(0)) 
	});
	chainA = FFT(LocalBuf(2048), inA);
	chainB = FFT(LocalBuf(2048), inB);
	chain = PV_RandWipe(chainA, chainB, MouseX.kr, MouseY.kr > 0.5); 
	0.5 * IFFT(chain).dup;
}.play;
)



