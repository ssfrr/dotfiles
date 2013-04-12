GbmanL		gingerbreadman map chaotic generator

GbmanL.ar(freq, xi, yi, mul, add)
GbmanL.kr(freq, xi, yi, mul, add)


	freq - iteration frequency in Hertz
	xi - initial value of x
	yi - initial value of y

A linear-interpolating sound generator based on the difference equations:
	
	xn+1 = 1 - yn + |xn|
	yn+1 = xn
	
The behavior of the system is dependent only on its initial conditions and cannot
be changed once it's started.

Reference:
Devaney, R. L. "The Gingerbreadman." Algorithm 3, 15-16, Jan. 1992.


// default initial params
{ GbmanL.ar(MouseX.kr(20, SampleRate.ir)) * 0.1 }.play(s);

// different initial params
{ GbmanL.ar(MouseX.kr(20, SampleRate.ir), -0.7, -2.7) * 0.1 }.play(s);

// wait for it...
{ GbmanL.ar(MouseX.kr(20, SampleRate.ir), 1.2, 2.0002) * 0.1 }.play(s);

// as a frequency control
{ SinOsc.ar(GbmanL.ar(40)*400+500)*0.4 }.play(s);


