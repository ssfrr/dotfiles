Warp1			Warp a buffer with a time pointer

Inspired by Chad Kirby's SuperCollider2 Warp1 class, which was inspired by Richard Karpen's sndwarp for CSound. A granular time strecher and pitchshifter.

Warp1.ar(numChannels, bufnum, pointer, freqScale, windowSize, envbufnum, overlaps, 
		windowRandRatio, interp, mul, add)

	numChannels - the number of channels in the soundfile used in bufnum.
	bufnum - the buffer number of a mono soundfile.
	pointer - the position in the buffer.  The value should be between 0 and 1, with 0 being the begining
		of the buffer, and 1 the end.
	freqScale- the amount of frequency shift. 1.0 is normal, 0.5 is one octave down, 2.0 is one octave up.
		Negative values play the soundfile backwards.
	windowSIze - the size of each grain window.
	envbufnum - the buffer number containing a singal to use for the grain envelope. -1 uses a built-in 
		Hanning envelope.
	overlaps - the number of overlaping windows.
	windowRandRatio - the amount of randomness to the windowing function.  Must be between 0 (no
		randomness) to 1.0 (probably to random actually)
	interp - the interpolation method used for pitchshifting grains. 1 = no interpolation. 2 = linear. 
		4 = cubic interpolation (more computationally intensive).


Examples:

s.boot;

(
var winenv;
// a custom envelope - not a very good one, but you can hear the difference between this 
// and the default
winenv = Env([0, 1, 0], [0.5, 0.5], [8, -8]);
b = Buffer.read(s, "sounds/a11wlk01-44_1.aiff");
z = Buffer.sendCollection(s, winenv.discretize, 1);

SynthDef(\warp, {arg buffer = 0, envbuf = -1;
	var out, pointer, filelength, pitch, env, dir;
	// pointer - move from beginning to end of soundfile over 15 seconds
	pointer = Line.kr(0, 1, 15);
	// control pitch with MouseX
	pitch = MouseX.kr(0.5, 2);
	env = EnvGen.kr(Env([0.001, 1, 1, 0.001], [0.1, 14, 0.9], 'exp'), doneAction: 2);
	out = Warp1.ar(1, buffer, pointer, pitch, 0.1, envbuf, 8, 0.1, 2);
	Out.ar(0, out * env);
}).send(s);

)

// use built-in env
x = Synth(\warp, [\buffer, b, \envbuf, -1])

// switch to the custom env
x.set(\envbuf, z)
x.set(\envbuf, -1);

x.free;


