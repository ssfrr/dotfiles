Saw			band limited sawtooth

Saw.ar(freq, mul, add)

Band limited sawtooth wave generator.
freq - Frequency in Hertz (control rate).

See also: LFSaw

// modulating the frequency

{ Saw.ar(XLine.kr(40,4000,6),0.2) }.play;

// two band limited sawtooth waves through a resonant low pass filter

{ RLPF.ar(Saw.ar([100,250],0.1), XLine.kr(8000,400,5), 0.05) }.play;


