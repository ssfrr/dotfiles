PV_PhaseShift270			shift phase by 270 degrees					

Inherits from: Object : AbstractFunction : UGen : PV_ChainUGen : PV_MagSquared

PV_PhaseShift270.new(buffer)

Shift phase of all bins by 270 degrees.
buffer - fft buffer

See also FFT Overview.

Server.internal.boot;


(
{
	var in, fft, fft2, shifted;
	in = SinOsc.ar(500, 0, 0.4);
	fft = FFT(LocalBuf(2048), in);
	fft2 = FFT(LocalBuf(2048), in);
	shifted = PV_PhaseShift270(fft); 
	[IFFT(fft2), IFFT(shifted)];  
}.scope;
)


