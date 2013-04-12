HenonC		hénon map chaotic generator

HenonC.ar(freq, a, b, x0, x1, mul, add)

	freq - iteration frequency in Hertz
	a, b - equation variables
	x0 - initial value of x
	x1 - second value of x

A cubic-interpolating sound generator based on the difference equation:
	
	xn+2 = 1 - axn+12 + bxn
	
This equation was discovered by French astronomer Michel Hénon while studying the orbits of stars
in globular clusters.


// default initial params
{ HenonC.ar(MouseX.kr(20, SampleRate.ir)) * 0.2 }.play(s);

// mouse-control of params
{ HenonC.ar(SampleRate.ir/4, MouseX.kr(1,1.4), MouseY.kr(0,0.3)) * 0.2 }.play(s);

// randomly modulate params
(
{ HenonC.ar(
	SampleRate.ir/8, 
	LFNoise2.kr(1, 0.2, 1.2), 
	LFNoise2.kr(1, 0.15, 0.15)
) * 0.2 }.play(s);
)

// as a frequency control
{ SinOsc.ar(HenonC.ar(40, MouseX.kr(1,1.4), MouseY.kr(0,0.3))*800+900)*0.4 }.play(s);


