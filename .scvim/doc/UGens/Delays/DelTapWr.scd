DelTapWr			write to a buffer for a DelTapRd UGen

phase = DelTapWr.ar(buffer, in )
phase = DelTapWr.kr(buffer, in )

buffer - the buffer to write signal into. Max delay time is based on buffer size.
in - the signal to write to the buffer.
phase - DelTapWr outputs its current sample value for use in the phase argument in DelTapRd

DelTapRd			tap a delay line from a DelTapWr UGen

DelTapRd.ar(buffer, phase, delTime, interp, mul, add )
DelTapRd.kr(buffer, phase, delTime, interp, mul, add )

buffer - buffer where DelTapWr has written signal.  Max delay time is based on buffer size.
phase - the current phase of the DelTapWr UGen. This is the output of DelTapWr.
delTime - A delay time in seconds.
interp - the kind of interpolation to be used. 1 is none, 2 is linear, 4 is cubic. 

// a Buffer for the UGens to use
b = Buffer.alloc(s, 44100, 1);

// write a signal into a delay, tap it at mutiple times
SynthDef(\test, {arg buffer;
	var src, tapPhase, tap1, tap2, tap3;
	src = WhiteNoise.ar(0.2) * Decay.kr(Dust.kr(3), 0.2);
	tapPhase = DelTapWr.ar(buffer, src);
	#tap1, tap2, tap3 = DelTapRd.ar(buffer, tapPhase, 
		[0.2, 0.27, 0.303],  	// tap times
		1,  					// no interp
		[1.0, 0.4, 0.2] 		// muls for each tap
		);
	Out.ar(0, [src + tap2, tap1 + tap3])
	}).send(s);
	
x = Synth(\test, [\buffer, b]);
x.free;
b.free;


// a Buffer for the UGens to use
b = Buffer.alloc(s, 44100, 1);

// write a signal into a delay, tap it at mutiple times
SynthDef(\write, {arg buffer, cout;
	var src, tapPhase, tap1, tap2, tap3;
	src = WhiteNoise.ar(0.2) * Decay.kr(Dust.kr(3), 0.7);
	tapPhase = DelTapWr.ar(buffer, src);
	Out.kr(cout, tapPhase);
	}).send(s);
	
SynthDef(\readFilt, {arg buffer, cin;
	var phase, src, filt;
	phase = In.kr(cin);
	src = DelTapRd.ar(buffer, phase, [0.01, 0.2]);
	filt = BPF.ar(src, 880, 0.01) * 10;
	Out.ar(0, filt);
	}).send(s);
	
c = Bus.control;

x = Synth(\write, [\buffer, b, \cout, c]);
y = Synth(\readFilt, [\buffer, b, \cin, c]);

x.free;
b.free;


