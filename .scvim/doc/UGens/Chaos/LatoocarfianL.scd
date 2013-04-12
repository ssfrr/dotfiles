LatoocarfianL		latoocarfian chaotic generator

LatoocarfianL.ar(freq, a, b, c, d, xi, yi, mul, add)

	freq - iteration frequency in Hertz
	a, b, c, d - equation variables
	xi - initial value of x
	yi - initial value of y

A linear-interpolating sound generator based on a function given in Clifford Pickover's 
book Chaos In Wonderland, pg 26. 
The function is:
	
	xn+1 = sin(byn) + c*sin(bxn)
	yn+1 = sin(ayn) + d*sin(axn)

According to Pickover, parameters a and b should be in the range from -3 to +3,
and parameters c and d should be in the range from 0.5 to 1.5.
The function can, depending on the parameters given, give continuous chaotic
output, converge to a single value (silence)  or oscillate in a cycle (tone).
This UGen is experimental and not optimized currently, so is rather hoggish of CPU.


// default initial params
{ LatoocarfianL.ar(MouseX.kr(20, SampleRate.ir)) * 0.2 }.play(s);

// randomly modulate all params
(
{ LatoocarfianL.ar(
	SampleRate.ir/4,
	LFNoise2.kr(2,1.5,1.5), 
	LFNoise2.kr(2,1.5,1.5),
	LFNoise2.kr(2,0.5,1.5),
	LFNoise2.kr(2,0.5,1.5)
) * 0.2 }.play(s);
)


