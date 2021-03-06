PanB2			2D Ambisonic B-format panner

PanB2.kr(in, azimuth, gain)

Encode a mono signal to two dimensional ambisonic B-format.
in - input signal
azimuth - position around the circle from -1 to +1. 
-1 is behind, -0.5 is left, 0 is forward, +0.5 is right, +1 is behind.
gain - amplitude control


(
{
	var w, x, y, p, a, b, c, d;
	
	p = PinkNoise.ar; // source
	
	// B-format encode
	#w, x, y = PanB2.ar(p, MouseX.kr(-1,1), 0.1); 
	
	// B-format decode to quad
	#a, b, c, d = DecodeB2.ar(4, w, x, y);
	
	[a, b, d, c] // reorder to my speaker arrangement: Lf Rf Lr Rr
}.play;
)


