FreqShift					Frequency Shifter
add
FreqShift.ar(input, shift, phase, mul, add)

FreqShift implements single sideband amplitude modulation, also known as frequency shifting, but not to be confused with pitch shifting.  Frequency shifting moves all the components of a signal by a fixed amount but does not preserve the original harmonic relationships.

input - audio input
shift - amount of shift in cycles per second
phase - phase of the frequency shift (0 - 2pi) 


Examples

// shifting a 100Hz tone by 1 Hz rising to 500Hz
{FreqShift.ar(SinOsc.ar(100),XLine.kr(1,500,5),0,[0.5,0.5])}.play(s);

// shifting a complex tone by 1 Hz rising to 500Hz
{FreqShift.ar(Klang.ar(`[[101,303,606,808]]),XLine.kr(1,500,10),0,[0.25,0.25])}.play(s);

// modulating shift and phase
{FreqShift.ar(SinOsc.ar(10),LFNoise2.ar(0.3,1500),SinOsc.ar(500).range(0,2pi),[0.5,0.5])}.play(s);

// the ubiquitous houston example
(
b = Buffer.read(s,"sounds/a11wlk01.wav");
{FreqShift.ar(PlayBuf.ar(1,b,BufRateScale.kr(b),loop:1),LFNoise0.kr(0.45,1000),0,[1,1])}.play(s);
)

// shifting bandpassed noise
{FreqShift.ar(BPF.ar(WhiteNoise.ar(1),1000,0.001),LFNoise0.kr(5.5,1000),0,[32,32])}.play(s);


More Examples (send a SynthDef, run the routine then send a different SynthDef)

(// simple detune & pitchmod via FreqShift
SynthDef("frqShift1",{arg frq,detune=1.5;
	var e1,left,right;	
	e1 = EnvGen.ar(Env.new([0,1,0],[1,2.3]),1,doneAction:2);
	left = SinOsc.ar(frq,0,e1); // original tone
	left = left + FreqShift.ar(left,frq*detune); // shift and add back to original 
	right = FreqShift.ar(left,SinOsc.kr(3.23,0,5));
	Out.ar(0, [left,right] * 0.25);
}).add;
)

(// the routine
r = Routine({
	var table,pitch;
	table = [0,2,4,5,7,9,11,12];
	inf.do{
		pitch = (48+(12*2.rand) + table.choose).midicps;
		s.sendMsg("s_new","frqShift1",-1,1,1,"frq",pitch);
		3.wait;
		};
	};
).play;
)

(// shift pulse wave in opposite directions
SynthDef("frqShift1",{arg frq,detune=0.15;
	var e1,snd,left,right;	
	e1 = EnvGen.ar(Env.new([0,1,0],[0.02,3.2]),1,doneAction:2);
	snd = Pulse.ar(frq,SinOsc.kr(2.3).range(0.2,0.8),e1); // original tone
	left = FreqShift.ar(snd,XLine.kr(-0.1,-200,2)); // shift and add back to original 
	right = FreqShift.ar(snd,XLine.kr(0.1,200,2));
	Out.ar(0, [left,right] * 0.25);
}).add
)

(// FreqShift >> feedback >>> FreqShift
SynthDef("frqShift1",{arg frq;
	var e1,snd,snd2,in;
	in = FreqShift.ar(InFeedback.ar(0,1)*3.2,XLine.ar(0.01,frq*1.5,1)); // shift the feedback
	e1 = Env.new([0,1,0],[0.02,2.98]);
	snd = SinOsc.ar(frq,0,EnvGen.ar(e1,1,doneAction:2));
	snd2 = FreqShift.ar(snd+in,SinOsc.ar(4.24,0.5,3),0,0.5); // subtle modulating shift
	OffsetOut.ar([0,1], Limiter.ar(snd2+snd * 0.5,1,0.005));
}).add;
)

r.stop; // stop old routine

(// ssllooww columbia tuned shift detune

b = Buffer.read(s,"sounds/a11wlk01.wav");

SynthDef("frqShift1",{arg frq, bufnum;
	var e1,snd,left,right;
	e1 = Env.new([0,1,0],[3,1],-4);
	snd = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum) * 0.01, loop:1);
	left = FreqShift.ar(snd,frq*2,0,EnvGen.ar(e1,1,doneAction:2)); // subtle shift of the output
	right = FreqShift.ar(snd,frq*3,0,EnvGen.ar(e1,1,doneAction:2));
	Out.ar(0, [left,right] * 3);
}).add;
(// the routine
r = Routine({
	var table,pitch;
	table = [0,2,4,5,7,9,11,12];
	inf.do{
		pitch = (48+(12*2.rand) + table.choose).midicps;
		s.sendMsg("s_new","frqShift1",-1,1,1, "frq", pitch, "bufnum", b);
		3.wait;
		};
	};
).play;
)

)


