SpecPcile	Find a percentile of FFT magnitude spectrum

	SpecPcile.kr(chain, fraction)

Given an FFT chain this calculates the cumulative distribution of the frequency spectrum, and outputs the frequency value which corresponds to the desired percentile.

For example, to find the frequency at which 90% of the spectral energy lies below that frequency, you want the 90-percentile, which means the value of fraction should be 0.9. The 90-percentile or 95-percentile is often used as a measure of spectral roll-off.

The optional third argument interpolate specifies whether interpolation should be used to try and make the percentile frequency estimate more accurate, at the cost of a little higher CPU usage. Set it to 1 to enable this.


Examples:

s = Server.internal.boot; 
b = Buffer.alloc(s,2048,1);

// Simple demo with filtering white noise, and trying to infer the cutoff freq.
// Move the mouse.
(
{
var in, chain, realcutoff, estcutoff;
realcutoff = MouseX.kr(0.00001,22050);
in = LPF.ar(WhiteNoise.ar, realcutoff);
chain = FFT(b, in);
estcutoff = Lag.kr(SpecPcile.kr(chain, 0.9), 1);
realcutoff.poll(Impulse.kr(1), "real cutoff");
estcutoff.poll(Impulse.kr(1), "estimated cutoff");
Out.ar(0, in);
Out.kr(0, estcutoff * 22050.0.reciprocal);
}.scope;
)

// Audio input - try different vowel/long-consonant sounds and see what comes out.
// Specifically, change from "ssss" through to "aaaa" through to "wwww".
(
{
var in, chain, perc;
in = SoundIn.ar([0,1]).mean;
chain = FFT(b, in);
//Out.ar(0, in * 0.1);
perc = SpecPcile.kr(chain, 0.5);
Out.ar(1, LPF.ar(WhiteNoise.ar, perc)); //NB Outputting to right channel - handy on PowerBooks
Out.kr(0, perc * 22050.0.reciprocal);
}.scope;
)


