StandardN		standard map chaotic generator

StandardN.ar(freq, k, xi, yi, mul, add)

	freq - iteration frequency in Hertz
	k - perturbation amount
	xi - initial value of x
	yi - initial value of y

A non-interpolating sound generator based on the difference equations:
	
	xn+1 = (xn + yn+1) % 2pi
	yn+1 = (yn + ksin(xn)) % 2pi

The standard map is an area preserving map of a cylinder discovered by the plasma 
physicist Boris Chirikov.
.
// vary frequency
{ StandardN.ar(MouseX.kr(20, SampleRate.ir)) * 0.3 }.play(s);

// mouse-controlled param
{ StandardN.ar(SampleRate.ir/2, MouseX.kr(0.9,4)) * 0.3 }.play(s);

// as a frequency control
{ SinOsc.ar(StandardN.ar(40, MouseX.kr(0.9,4))*800+900)*0.4 }.play(s);


