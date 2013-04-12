BiPanB2			2D Ambisonic B-format panner

BiPanB2.kr(inA, inB, azimuth, gain)

Encode a two channel signal to two dimensional ambisonic B-format.
This puts two channels at opposite poles of a 2D ambisonic field.
This is one way to map a stereo sound onto a soundfield.
It is equivalent to:

PanB2(inA, azimuth, gain) + PanB2(inB, azimuth + 1, gain)

inA - input signal A
inB - input signal B
azimuth - position around the circle from -1 to +1. 
-1 is behind, -0.5 is left, 0 is forward, +0.5 is right, +1 is behind.
gain - amplitude control


(
{
	var w, x, y, p, q, a, b, c, d;
	
	p = LFSaw.ar(200);
	q = LFSaw.ar(301);
	
	// B-format encode
	#w, x, y = BiPanB2.ar(p, q, MouseX.kr(-1,1), 0.1); 
	
	// B-format decode to quad
	#a, b, c, d = DecodeB2.ar(4, w, x, y);
	
	[a, b, d, c] // reorder to my speaker arrangement: Lf Rf Lr Rr
}.play;
)


