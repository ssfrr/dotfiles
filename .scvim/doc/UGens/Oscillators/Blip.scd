Blip			band limited impulse oscillator

Blip.ar(freq, numharm, mul, add)

Band Limited ImPulse generator. All harmonics have equal amplitude. This is the equivalent of 'buzz' in MusicN languages. 

WARNING: This waveform in its raw form could be damaging to your ears at high amplitudes or for long periods.

Implementation notes: 
It is improved from other implementations in that it will crossfade in a control period when the number of  harmonics changes, so that there are no audible pops. It also eliminates the divide in the formula by using a 1/sin table (with special precautions taken for 1/0).  The lookup tables are linearly interpolated for better quality.

(Synth-O-Matic (1990) had an impulse generator called blip, hence that name here rather than 'buzz').

freq - Frequency in Hertz (control rate)
numharm - Number of harmonics. This may be lowered internally if it would cause aliasing.

// modulate frequency
{ Blip.ar(XLine.kr(20000,200,6),100,0.2) }.play;

// modulate numharmonics
{ Blip.ar(200,Line.kr(1,100,20),0.2) }.play;



