PV_PhaseShift				shift phase of all bins

Inherits from: Object : AbstractFunction : UGen : PV_ChainUGen

PV_PhaseShift(buffer, shift)

buffer - fft buffer.
shift - phase shift in radians.

See also FFT Overview.

// internal server for scoping
Server.default = s = Server.internal; s.boot;



(
{
	var in, chain;
	in = SinOsc.ar(500);
	chain = FFT(LocalBuf(2048), in);
	chain = PV_PhaseShift(chain, LFNoise2.kr(1, pi, pi)); 
	0.2 * [in, IFFT(chain)];  
}.scope;
)

(
{
	var in, chain;
	in = Impulse.ar(130);
	chain = FFT(LocalBuf(2048), in);
	chain = PV_PhaseShift(chain, LFNoise2.kr(1, pi, pi)); 
	0.2 * [in, IFFT(chain)];  
}.scope(zoom: 9);
)


b = Buffer.alloc(s, 2048);
c = Buffer.alloc(s, 2048);

(
{
	var in, chainA, chainB;
	in = SinOsc.ar(500);
	chainA = FFT(b, in);
	chainB = PV_Copy(chainA, c);
	chainB = PV_PhaseShift(chainB, pi); // shifted by 180 degrees
	0.2 * IFFT([chainA, chainB]);  // normal, shifted
}.scope;
)

(
{ var in, chain, chainB, pan;
	in = PlayBuf.ar(1, d, BufRateScale.kr(d), loop: 1) * 2;
	chain = FFT(b, in);
	chainB = PV_Copy(chain, c);
	pan = MouseX.kr(0.001, 1.001, 'exponential') - 0.001;
	chain = PV_BrickWall(chain, pan); 
	chainB = PV_BrickWall(chainB, -1 + pan);  
	0.5 * IFFT([chain, chainB]);
}.scope;
)




// LocalBuf does not work for PV_PhaseShift and PV_Copy yet. Reason still unclear.


(
{
	var in, chainA, chainB;
	in = SinOsc.ar(500);
	chainA = FFT(LocalBuf(2048), in);
	chainB = PV_Copy(chainA, LocalBuf(2048));
	0.2 * IFFT([chainA, chainB]);  // normal, shifted
}.scope;
)



(
{
	var in, chainA, chainB;
	in = SinOsc.ar(500);
	chainA = FFT(LocalBuf(2048), in);
	chainB = PV_Copy(chainA, LocalBuf(2048));
	chainB = PV_PhaseShift(chainB, pi); // shifted by 180 degrees
	0.2 * IFFT([chainA, chainB]);  // normal, shifted
}.scope;
)

d = Buffer.read(s,"sounds/a11wlk01.wav");

(
{ var in, chain, chainB, pan;
	in = PlayBuf.ar(1, d, BufRateScale.kr(d), loop: 1) * 2;
	chain = FFT(LocalBuf(2048), in);
	//chainB = PV_Copy(chain, LocalBuf(2048));
	pan = MouseX.kr(0.001, 1.001, 'exponential') - 0.001;
	chain = PV_BrickWall(chain, pan); 
	//chainB = PV_BrickWall(chainB, -1 + pan);  
	//0.5 * IFFT([chain, chainB]);
	0.5 * IFFT(chain)
}.scope;
)


