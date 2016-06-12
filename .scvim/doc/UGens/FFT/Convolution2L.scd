Convolution2L			real-time convolver with linear interpolation

Convolution2L.ar(in, kernel, trigger, framesize, crossfade, mul, add)

Strict convolution with fixed kernel which can be updated using a trigger signal. There is a linear crossfade between the buffers upon change.

See Steven W Smith, The Scientist and Engineer's Guide to Digital Signal Processing: 
chapter 18: http:// www.dspguide.com/ch18.htm 

in - processing target
kernel- buffer index for the fixed kernel, may be modulated in combination with the trigger
trigger - update the kernel on a change from <=0 to >0
framesize - size of FFT frame, must be a power of two. Convolution uses twice this number internally, maximum value you can give this argument is 2^16=65536. Note that it gets progressively more expensive to run for higher powers! 512, 1024, 2048, 4096 standard.
crossfade - The number of periods over which a crossfade is made. The default is 1. This must be an integer.

See also Convolution2 and StereoConvolution2L.

s = Server.local.boot;

(// allocate three buffers
b = Buffer.alloc(s, 2048);
c = Buffer.alloc(s, 2048);
d = Buffer.alloc(s, 2048);

b.zero;
c.zero;
d.zero;
)

(
50.do({ |it| c.set(20*it+10, 1.0.rand); });
3.do({ |it| b.set(400*it+100, 1); });
20.do({ |it| d.set(40*it+20, 1); });
)


(
SynthDef(\conv_test, { arg kernel, t_trig=0;
	var input;
		
	input=Impulse.ar(1);

	// must have power of two framesize
	Out.ar(0, Convolution2L.ar(input, kernel, t_trig, 2048, 1, 0.5));
}).add

)


x = Synth(\conv_test, [\kernel, b]);

// changing the buffer number:
x.set(\kernel, c);
x.set(\t_trig, 1); // after this trigger, the change will take effect.
x.set(\kernel, d);
x.set(\t_trig, 1); // after this trigger, the change will take effect.

d.zero;
40.do({ |it| d.set(20*it+10, 1); });// changing the buffers' contents
x.set(\t_trig, 1); // after this trigger, the change will take effect.

x.set(\kernel, b);
x.set(\t_trig, 1); // after this trigger, the change will take effect.

x.free;

// longer crossfade
(
SynthDef( \conv_test2, { arg kernel, t_trig=0;
	var input;
		
	input=Impulse.ar(1);

	// must have power of two framesize
	Out.ar(0, Convolution2L.ar(input, kernel, t_trig, 2048, 5, 0.5));
}).add

)


x = Synth(\conv_test2, [\kernel, b]);

// changing the buffer number:
x.set(\kernel, c);
x.set(\t_trig, 1); // after this trigger, the change will take effect.
x.set(\kernel, d);
x.set(\t_trig, 1); // after this trigger, the change will take effect.

d.zero;
40.do({ |it| d.set(20*it+10, 1); });// changing the buffers' contents
x.set(\t_trig, 1); // after this trigger, the change will take effect.

x.set(\kernel, b);
x.set(\t_trig, 1); // after this trigger, the change will take effect.

x.free;

// // next example

b = Buffer.read(s, "sounds/a11wlk01.wav");

(
	{ var input, kernel;
		
	input= SoundIn.ar(0);

	// must have power of two framesize
	Convolution2L.ar(input, b, 0, 512, 1, 0.5);
	}.play;

)


// another example

(
// must have power of two framesize- FFT size will be sorted by Convolution2 to be double this
// maximum is currently a=8192 for FFT of size 16384
a=2048;
// kernel buffer
g = Buffer.alloc(s, a, 1);
)

(
g.set(0, 1.0);
100.do({arg i; g.set(a.rand, (i+1).reciprocal)});
)

(
// random impulse response

	{
	var input, inputAmp, threshold, gate;

	input = SoundIn.ar(0); 
	inputAmp = Amplitude.kr(input);
	threshold = 0.02;	// noise gating threshold
	gate = Lag.kr(inputAmp > threshold, 0.01);	
	
	Convolution2L.ar(input*gate, g, 0, a, 1, 0.5);
	}.play;

)






// one last example
(
b = Buffer.alloc(s, 512, 1);
b.sine1(1.0/[1, 2, 3, 4, 5, 6], true, true, true);
)

(
	{ var input, kernel;
		
	input=SoundIn.ar(0);

	// must have power of two framesize
	Convolution2L.ar(input, b, 0, 512, 1, 0.5);
	}.play;

)



