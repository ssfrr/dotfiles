PV_ConformalMap			complex plane attack 

PV_ConformalMap(buffer, real, imag)

Applies the conformal mapping z -> (z-a)/(1-za*) to the phase vocoder bins z with a given by the real and imag inputs to the UGen.

ie, makes a transformation of the complex plane so the output is full of phase vocoder artifacts but may be musically fun. Usually keep |a|<1 but you can of course try bigger values to make it really noisy. a=0 should give back the input mostly unperturbed.

See http://mathworld.wolfram.com/ConformalMapping.html

buffer - buffer number of buffer to act on, passed in through a chain (see examples below).
real - real part of a. 
imag - imaginary part of a.

See also FFT Overview.


// examples

(
{
	var in, chain;
	in = SinOsc.ar(450) * 0.1;
	chain = FFT(LocalBuf(2048), in);
	chain = PV_ConformalMap(chain, MouseX.kr(-1.0,1.0), MouseY.kr(-1.0,1.0));
	IFFT(chain).dup;
}.play;
)


// microphone input - use headphones to prevent feedback
(
{
	var in, chain;
	in = SoundIn.ar(0, 0.5);
	chain = FFT(LocalBuf(2048), in);
	chain = PV_ConformalMap(chain, MouseX.kr(-1.0,1.0), MouseY.kr(-1.0,1.0));
	IFFT(chain).dup;
}.play;
)



(
{
	var in, chain, signal;
	var real = MouseX.kr(0.01,2.0, 'exponential');
	var imag = MouseY.kr(0.01,10.0, 'exponential');
	in = Mix(
		LFSaw.ar(
			SinOsc.kr(Array.rand(3, 0.1, 0.5), 0, 10, [1, 1.1, 1.5, 1.78, 2.45, 6.7] * 220),
			0, 0.3
		)
	);
	chain = FFT(LocalBuf(2048), in);
	chain = PV_ConformalMap(chain, real, imag);
	signal = IFFT(chain);
	
	(CombN.ar(signal, 0.1, 0.1, 10, 0.5) + signal).dup;
}.play;
)


