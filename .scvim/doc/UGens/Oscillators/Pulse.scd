Pulse			band limited pulse wave

Pulse.ar(freq, width, mul, add)

Band limited pulse wave generator with pulse width modulation.
freq - Frequency in Hertz (control rate)
width - Pulse width ratio from zero to one. 0.5 makes a square wave (control rate)

See also: LFPulse

// modulate frequency
{ Pulse.ar(XLine.kr(40,4000,6),0.1, 0.2) }.play;

// modulate pulse width
{ Pulse.ar(200, Line.kr(0.01,0.99,8), 0.2) }.play;

// two band limited square waves thru a resonant low pass filter
{ RLPF.ar(Pulse.ar([100,250],0.5,0.1), XLine.kr(8000,400,5), 0.05) }.play;



