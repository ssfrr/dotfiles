OscN			noninterpolating wavetable oscillator

OscN.ar(table, freq, phase, mul, add)

Noninterpolating wavetable lookup oscillator with frequency and phase modulation inputs.
It is usually better to use the interpolating oscillator.
buffer - buffer index.  the buffer size must be a power of 2.  The buffer should NOT be filled using Wavetable format (b_gen commands should set wavetable flag to false.  Raw signals (not converted with asWavetable) can be saved to disk and loaded into the buffer.
freq - frequency in Hertz
phase - phase offset or modulator in radians

// compare examples below with interpolating Osc examples.

(
s = Server.local;
b = Buffer.alloc(s,512,1);
b.sine1(1.0/[1,2,3,4,5,6],true,false,true);

SynthDef("help-OscN",{ arg out=0,bufnum=0;
	Out.ar(out, 
		OscN.ar(bufnum, 500, 0, 0.5)
	)
}).play(s,[0,0,1,b]);

)
b.free;



(
// noninterpolating - there are noticeable artifacts
// modulate freq

s = Server.local;
b = Buffer.alloc(s,512,1);
b.sine1(1.0/[1,2,3,4,5,6].squared,true,false,true);

SynthDef("help-OscN",{ arg out=0,bufnum=0;
	Out.ar(out, 
		OscN.ar(bufnum, XLine.kr(2000,200), 0, 0.5)
	)
}).play(s,[\out,0,\bufnum,b]);

)
b.free;

( 
// sounds very different than the Osc example
s = Server.local;
b = Buffer.alloc(s, 512, 1);
b.sine1([1.0], true, true, true);

SynthDef("help-OscN",{ arg out=0,bufnum=0;
	Out.ar(out,
		OscN.ar(bufnum, 
			OscN.ar(bufnum,
				XLine.kr(1,1000,9),
				0,
				200,
				800), 
			0, 
			0.25)
	)
}).play(s,[\out, 0, \bufnum, b]);

)
b.free;

(
// modulate phase
s = Server.local;
b = Buffer.alloc(s, 512, 1);
b.sine1([1.0], true, true, true);

SynthDef("help-OscN",{ arg out=0,bufnum=0;
	Out.ar(out,
		OscN.ar(bufnum, 
				800, 
				OscN.ar(bufnum,
						XLine.kr(20,8000,10),
						0,
						2pi), 
				0.25)
	)
}).play(s,[\out, 0, \bufnum, b]);
)
b.free;


(
// change the buffer while its playing
s = Server.local;
b = Buffer.alloc(s, 4096, 1);
b.sine1(1.0/[1,2,3,4,5,6], true, true, true);

SynthDef("help-OscN",{ arg out=0,bufnum=0;
	Out.ar(out,
		OscN.ar(bufnum, [80,80.2], 0, 0.2)
	)
}).play(s,[\out, 0, \bufnum, b]);
)

(
Routine({
	var n = 32;
	50.do({
		b.sine1(Array.rand(n,0,1).cubed, true, true, true);
		0.25.wait;
	});
}).play;
)
b.free;



