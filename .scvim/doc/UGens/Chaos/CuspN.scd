CuspN		cusp map chaotic generator

CuspN.ar(freq, a, b, xi, mul, add)

	freq - iteration frequency in Hertz
	a, b - equation variables
	xi - initial value of x

A non-interpolating sound generator based on the difference equation:
	
	xn+1 = a - b*sqrt(|xn|)


// vary frequency
{ CuspN.ar(MouseX.kr(20, SampleRate.ir), 1.0, 1.99) * 0.3 }.play(s);

// mouse-controlled params
{ CuspN.ar(SampleRate.ir/4, MouseX.kr(0.9,1.1,1), MouseY.kr(1.8,2,1)) * 0.3 }.play(s);

// as a frequency control
{ SinOsc.ar(CuspN.ar(40, MouseX.kr(0.9,1.1,1), MouseY.kr(1.8,2,1))*800+900)*0.4 }.play(s);


