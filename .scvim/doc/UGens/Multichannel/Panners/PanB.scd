PanB			Ambisonic B format panner

PanB.ar(in, azimuth, elevation, gain)

in - input signal
azimuth -  in radians, -pi to +pi
elevation -  in radians, -0.5pi to +0.5pi
gain - a control rate level input.

Output channels are in order W,X,Y,Z.

// You'll only hear the first two channels on a stereo setup.
play({ 
	#w, x, y, z = PanB.ar(WhiteNoise.ar, LFSaw.kr(0.5,pi), FSinOsc.kr(0.31, 0.5pi), 0.3);
	//decode for 4 channels
	DecodeB2.ar(4, w, x, y, 0.5);
});


