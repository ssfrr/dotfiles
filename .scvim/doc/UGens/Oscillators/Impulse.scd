Impulse		impulse oscillator

Impulse.ar(freq, phase, mul, add)

Outputs non band limited single sample impulses.
freq - frequency in Hertz
phase - phase offset in cycles ( 0..1 )

{ Impulse.ar(800, 0.0, 0.5, 0) }.play

{ Impulse.ar(XLine.kr(800,100,5), 0.0,  0.5, 0) }.play

modulate phase:

{ Impulse.ar(4, [0, MouseX.kr(0, 1)], 0.2) }.play;

an Impulse with frequency 0 returns a single impulse:

SynthDef(\imp, { OffsetOut.ar(0, Impulse.ar(0)); FreeSelf.kr(Impulse.kr(0)); }).add;
fork { (1 / (1..60).scramble).do { |dt| Synth.grain(\imp);  dt.wait } };


