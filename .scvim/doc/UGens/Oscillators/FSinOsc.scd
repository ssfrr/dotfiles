FSinOsc		fast sine oscillator

FSinOsc.ar(freq, iphase,mul, add)
FSinOsc.kr(freq, iphase,mul, add)

Very fast sine wave generator (2 PowerPC instructions per output sample!) implemented using a ringing
filter.  This generates a much cleaner sine wave than a table lookup oscillator and is a lot faster.
However, the amplitude of the wave will vary with frequency. Generally the amplitude will go down as
you raise the frequency and go up as you lower the frequency.
WARNING: In the current implementation, the amplitude can blow up if the frequency is modulated 
by certain alternating signals.
freq - frequency in Hertz

{ FSinOsc.ar(800, 0.0, 0.25) }.play;

{ FSinOsc.ar(XLine.kr(200,4000,1),0.0, 0.25) }.play;

// loses amplitude towards the end
{ FSinOsc.ar(FSinOsc.ar(XLine.kr(4,401,8),0.0, 200,800),0.0, 0.25) }.play;



