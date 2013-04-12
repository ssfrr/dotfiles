GbmanN		gingerbreadman map chaotic generator

GbmanN.ar(freq, xi, yi, mul, add)

	freq - iteration frequency in Hertz
	xi - initial value of x
	yi - initial value of y

A non-interpolating sound generator based on the difference equations:
	
	xn+1 = 1 - yn + |xn|
	yn+1 = xn
	
The behavior of the system is only dependent on its initial conditions.

Reference:
Devaney, R. L. "The Gingerbreadman." Algorithm 3, 15-16, Jan. 1992.


// default initial params
{ GbmanN.ar(MouseX.kr(20, SampleRate.ir)) * 0.1 }.play(s);

// change initial params
{ GbmanN.ar(MouseX.kr(20, SampleRate.ir), -0.7, -2.7) * 0.1 }.play(s);

// wait for it...
{ GbmanN.ar(MouseX.kr(20, SampleRate.ir), 1.2, 2.0002) * 0.1 }.play(s);

// as a frequency control
{ SinOsc.ar(GbmanN.ar(40)*400+500)*0.4 }.play(s);


