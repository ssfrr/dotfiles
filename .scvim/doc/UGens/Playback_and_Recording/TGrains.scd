TGrains		buffer granulator

Triggers generate grains from a single channel (mono) buffer. Each grain has a Hann envelope (sin^2(x) for x from 0 to pi) and is panned between two channels of multiple outputs.

TGrains.ar(numChannels, trigger, bufnum, rate, centerPos, dur, pan, amp, interp)

	numChannels - number of output channels.
	trigger - at each trigger, the following arguments are sampled and used 
		as the arguments of a new grain. 
		A trigger occurs when a signal changes from <= 0 to > 0.
		If the trigger is audio rate then the grains will start with sample accuracy.
	bufnum - the index of the buffer to use. It must be a one channel (mono) buffer.
	rate   -  1.0 is normal, 2.0 is one octave up, 0.5 is one octave down
			-1.0 is backwards normal rate ... etc.
		Unlike PlayBuf, the rate is multiplied by BufRate, so you needn't do that yourself.
	centerPos - the position in the buffer in seconds at which the grain envelope will reach 
			maximum amplitude.
	dur    -   duration of the grain in seconds.
	pan    -   a value from -1 to 1. Determines where to pan the output in the same manner as PanAz.
	amp   - amplitude of the grain.
	interp - 1,2,or 4. Determines whether the grain uses (1) no interpolation, (2) linear interpolation, 
			or (4) cubic interpolation.


(
s = Server.internal;
Server.default = s;
s.boot;
)


s.sendMsg(\b_allocRead, 10, "sounds/a11wlk01.wav");


(
{
	var b = 10, trate, dur, rate;
	trate = MouseY.kr(2,200,1);
	dur = 4 / trate;
	rate = Dseq([10, 1, 1, 0.5, 0.5, 0.2, 0.1], inf);
	TGrains.ar(2, Impulse.ar(trate), b, rate, MouseX.kr(0,BufDur.kr(b)), dur, Dseq([-1, 1], inf), 0.1, 2);
}.scope(zoom: 4);
)

(
{
	var b = 10, trate, dur, clk, pos, pan;
	trate = MouseY.kr(8,120,1);
	dur = 12 / trate;
	clk = Impulse.kr(trate);
	pos = MouseX.kr(0,BufDur.kr(b)) + TRand.kr(0, 0.01, clk);
	pan = WhiteNoise.kr(0.6);
	TGrains.ar(2, clk, b, 1, pos, dur, pan, 0.1);
}.scope(zoom: 4);
)

// 4 channels
(
{
	var b = 10, trate, dur, clk, pos, pan;
	trate = MouseY.kr(8,120,1);
	dur = 12 / trate;
	clk = Impulse.kr(trate);
	pos = MouseX.kr(0,BufDur.kr(b)) + TRand.kr(0, 0.01, clk);
	pan = WhiteNoise.kr(0.6);
	TGrains.ar(4, clk, b, 1, pos, dur, pan, 0.1);
}.scope(4, zoom: 4);
)

(
{
	var b = 10, trate, dur, clk, pos, pan;
	trate = MouseY.kr(8,120,1);
	dur = 4 / trate;
	clk = Dust.kr(trate);
	pos = MouseX.kr(0,BufDur.kr(b)) + TRand.kr(0, 0.01, clk);
	pan = WhiteNoise.kr(0.6);
	TGrains.ar(2, clk, b, 1, pos, dur, pan, 0.1);
}.scope(zoom: 4);
)



(
{
	var b = 10, trate, dur, clk, pos, pan;
	trate = LinExp.kr(LFTri.kr(MouseY.kr(0.1,2,1)),-1,1,8,120);
	dur = 12 / trate;
	clk = Impulse.ar(trate);
	pos = MouseX.kr(0,BufDur.kr(b));
	pan = WhiteNoise.kr(0.6);
	TGrains.ar(2, clk, b, 1, pos, dur, pan, 0.1);
}.scope(zoom: 4);
)


(
{
	var b = 10, trate, dur, clk, pos, pan;
	trate = 12;
	dur = MouseY.kr(0.2,24,1) / trate;
	clk = Impulse.kr(trate);
	pos = MouseX.kr(0,BufDur.kr(b)) + TRand.kr(0, 0.01, clk);
	pan = WhiteNoise.kr(0.6);
	TGrains.ar(2, clk, b, 1, pos, dur, pan, 0.1);
}.scope(zoom: 4);
)

(
{
	var b = 10, trate, dur, clk, pos, pan;
	trate = 100;
	dur = 8 / trate;
	clk = Impulse.kr(trate);
	pos = Integrator.kr(BrownNoise.kr(0.001));
	pan = WhiteNoise.kr(0.6);
	TGrains.ar(2, clk, b, 1, pos, dur, pan, 0.1);
}.scope(zoom: 4);
)

(
{
	var b = 10, trate, dur, clk, pos, pan;
	trate = MouseY.kr(1,400,1);
	dur = 8 / trate;
	clk = Impulse.kr(trate);
	pos = MouseX.kr(0,BufDur.kr(b));
	pan = WhiteNoise.kr(0.8);
	TGrains.ar(2, clk, b, 2 ** WhiteNoise.kr(2), pos, dur, pan, 0.1);
}.scope(zoom: 4);
)




(
{
	var b = 10, trate, dur;
	trate = MouseY.kr(2,120,1);
	dur = 1.2 / trate;
	TGrains.ar(2, Impulse.ar(trate), b, (1.2 ** WhiteNoise.kr(3).round(1)), MouseX.kr(0,BufDur.kr(b)), dur, WhiteNoise.kr(0.6), 0.1);
}.scope(zoom: 4);
)




// demand ugens as inputs
(
{
	var trate, dur, z, d;
	trate = MouseX.kr(1, 100, 1);
	d = { Dwhite(0.1, 0.2, 1) };
	z = { 
		Drand([Dgeom(0.1, 1 + d.value, Diwhite(20, 40)), Dgeom(1, 1 - d.value, Diwhite(20, 40))]) 
	};
	TGrains.ar(2, 
		Impulse.ar(trate),
		bufnum: 10, 
		rate: Dseq([1, 1, z.value, 0.5, 0.5, 0.2, 0.1, 0.1, 0.1, 0.1], inf) * 2 + 1, 
		centerPos: Dseq(z.dup(8), inf),
		dur: Dseq([1, d.value, 1, z.value, 0.5, 0.5, 0.1, z.value] * 2, inf) / trate,
		pan: Dseq([1, 1, 1, 0.5, 0.2, 0.1, 0, 0, 0], inf) * 2 - 1,
		amp: Dseq([1, 0, z.value, 0, 2, 1.0, 1, 0.1, 0.1], inf)
	);
}.scope(zoom: 4);
)


