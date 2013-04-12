COsc			chorusing wavetable oscillator

COsc.ar(bufnum, freq, beats, mul, add)

Chorusing wavetable lookup oscillator. Produces sum of two signals at  (freq +/- (beats / 2)). Due to summing, the peak amplitude is twice that of the wavetable.
bufnum - the number of a buffer filled in wavetable format
freq - frequency in Hertz
beats - beat frequency in Hertz


(
b = Buffer.alloc(s, 512, 1, {arg buf; buf.sine1Msg(1.0/[1,2,3,4,5,6,7,8,9,10])}); 
{ COsc.ar(b, 200, 0.7, 0.25) }.play;
)


