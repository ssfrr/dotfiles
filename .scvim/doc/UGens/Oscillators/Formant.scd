Formant			formant oscillator

Formant.ar(fundfreq, formfreq, bwfreq, mul, add)
Formant.kr(fundfreq, formfreq, bwfreq, mul, add)


Generates a set of harmonics around a formant frequency at a given fundamental frequency.

The frequency inputs are read at control rate only, so if you use an audio rate UGen as an input, it will only be sampled at the start of each audio synthesis block. 

fundfreq - fundamental frequency in Hertz (control rate)
formfreq - formant frequency in Hertz (control rate)
bwfreq - pulse width frequency in Hertz. Controls the bandwidth of the formant (control rate)
Widthfreq must be greater than or equal fundfreq.


// modulate fundamental frequency, formant freq stays constant
{ Formant.ar(XLine.kr(400,1000, 8), 2000, 800, 0.125) }.play

// modulate formant frequency, fundamental freq stays constant
{ Formant.ar(200, XLine.kr(400, 4000, 8), 200, 0.125) }.play

// modulate width frequency, other freqs stay constant
{ Formant.ar(400, 2000, XLine.kr(800, 8000, 8), 0.125) }.play


