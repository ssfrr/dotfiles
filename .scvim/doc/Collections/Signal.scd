Signal						sampled audio buffer

Inherits from: Object : Collection : SequenceableCollection : ArrayedCollection : RawArray : FloatArray

A Signal is a FloatArray that represents a sampled function of time buffer. 
Signals support math operations.

See also: Wavetable


Creation

*sineFill(size, amplitudes, phases)

Fill a Signal of the given size with a sum of sines at the given amplitudes and phases.
The Signal will be normalized.
size - the number of samples in the Signal.
amplitudes - an Array of amplitudes for each harmonic beginning with the fundamental.
phases - an Array of phases in radians for each harmonic beginning with the fundamental.

Signal.sineFill(1000, 1.0/[1, 2, 3, 4, 5, 6]).plot;


*chebyFill(size, amplitudes, phases)

Fill a Signal of the given size with a sum of Chebyshev polynomials at the given amplitudes.
For eventual use in waveshaping by the Shaper ugen; see Shaper helpfile and Buffer:cheby too.
size - the number of samples in the Signal.
amplitudes - an Array of amplitudes for each Chebyshev polynomial beginning with order 1.

Signal.chebyFill(1000, [1]).plot;

Signal.chebyFill(1000, [0, 1]).plot;

Signal.chebyFill(1000, [0, 0, 1]).plot;

Signal.chebyFill(1000, [0.3, -0.8, 1.1]).plot;


*hanningWindow(size, pad)

Fill a Signal of the given size with a Hanning window.
size - the number of samples in the Signal.
pad - the number of samples of the size that is zero padding.

Signal.hanningWindow(1024).plot;

Signal.hanningWindow(1024, 512).plot;


*hammingWindow(size)

Fill a Signal of the given size with a Hamming window.
size - the number of samples in the Signal.
pad - the number of samples of the size that is zero padding.

Signal.hammingWindow(1024).plot;

Signal.hammingWindow(1024, 512).plot;


*welchWindow(size)

Fill a Signal of the given size with a Welch window.
size - the number of samples in the Signal.
pad - the number of samples of the size that is zero padding.

Signal.welchWindow(1024).plot;

Signal.welchWindow(1024, 512).plot;


*rectWindow(size)

Fill a Signal of the given size with a rectangular window.
size - the number of samples in the Signal.
pad - the number of samples of the size that is zero padding.

Signal.rectWindow(1024).plot;

Signal.rectWindow(1024, 512).plot;






Instance Methods

plot(name, bounds)

Plot the Signal in a window. The arguments are not required and if not given defaults will be used.
name - a String, the name of the window.
bounds - a Rect giving the bounds of the window.

Signal.sineFill(512, [1]).plot;

Signal.sineFill(512, [1]).plot("Signal 1", Rect(50, 50, 150, 450));


play(loop, mul, numChannels, server)

loads the signal into a buffer on the server and plays it. 
returns the buffer so you can free it again. 
loop - A Boolean whether to loop the entire signal or play it once. Default is to loop.
mul - volume at which to play it, 0.2 by default.
numChannels - if the signal is an interleaved multichannel file, number of channels, default is 1.
server - the server on which to load the signal into a buffer. 

b = Signal.sineFill(512, [1]).play(true, 0.2);
b.free; 	// free the buffer again. 


waveFill(function, start, end)

Fill the Signal with a function evaluated over an interval.
function - a function that should calculate the value of a sample.
The function is called with two arguments.
	x - the value along the interval.
	i - the sample index.
start - the starting value of the interval
end - the ending value of the interval.
	
(
s = Signal.newClear(512);
s.waveFill({ arg x, i; sin(x).max(0) }, 0, 3pi);
s.plot;
)

asWavetable

Convert the Signal into a Wavetable.

Signal.sineFill(512, [1]).asWavetable.plot;


fill(val)

Fill the Signal with a value.

Signal.newClear(512).fill(0.2).plot;


scale(scale)

Scale the Signal by a factor in place.

a = Signal[1, 2, 3, 4];
a.scale(0.5); a;


offset(offset)

Offset the Signal by a value in place.

a = Signal[1, 2, 3, 4];
a.offset(0.5); a;


peak

Return the peak absolute value of a Signal.

Signal[1, 2, -3, 2.5].peak;


normalize

Normalize the Signal in place such that the maximum absolute peak value is 1.

Signal[1, 2, -4, 2.5].normalize;
Signal[1, 2, -4, 2.5].normalize(0, 1);	// normalize only a range


normalizeTransfer

Normalizes a transfer function so that the center value of the table is offset to zero
and the absolute peak value is 1. Transfer functions are meant to be used in the 
Shaper ugen.

Signal[1, 2, 3, 2.5, 1].normalizeTransfer;

invert

Invert the Signal in place.

a = Signal[1, 2, 3, 4];
a.invert(0.5); a;


reverse(beginSamp, endSamp)

Reverse a subrange of the Signal in place.

a = Signal[1, 2, 3, 4];
a.reverse(1, 2); a;


fade(beginSamp, endSamp, beginLevel, endLevel)

Fade a subrange of the Signal in place.

a = Signal.fill(10, 1);
a.fade(0, 3);		// fade in
a.fade(6, 9, 1, 0);	// fade out


integral

Return the integral of a signal.

Signal[1, 2, 3, 4].integral;


overDub(aSignal, index)

Add a signal to myself starting at the index.
If the other signal is too long only the first part is overdubbed.

a = Signal.fill(10, 100);
a.overDub(Signal[1, 2, 3, 4], 3);
	
		// run out of range
a = Signal.fill(10, 100);
a.overDub(Signal[1, 2, 3, 4], 8);	

a = Signal.fill(10, 100);
a.overDub(Signal[1, 2, 3, 4], -4);	

a = Signal.fill(10, 100);
a.overDub(Signal[1, 2, 3, 4], -1);	

a = Signal.fill(10, 100);
a.overDub(Signal[1, 2, 3, 4], -2);	

a = Signal.fill(4, 100);
a.overDub(Signal[1, 2, 3, 4, 5, 6, 7, 8], -2);	


overWrite(aSignal, index)

Write a signal to myself starting at the index.
If the other signal is too long only the first part is overdubbed.

a = Signal.fill(10, 100);
a.overWrite(Signal[1, 2, 3, 4], 3);
	
		// run out of range
a = Signal.fill(10, 100);
a.overWrite(Signal[1, 2, 3, 4], 8);	

a = Signal.fill(10, 100);
a.overWrite(Signal[1, 2, 3, 4], -4);	

a = Signal.fill(10, 100);
a.overWrite(Signal[1, 2, 3, 4], -1);	

a = Signal.fill(10, 100);
a.overWrite(Signal[1, 2, 3, 4], -2);	

a = Signal.fill(4, 100);
a.overWrite(Signal[1, 2, 3, 4, 5, 6, 7, 8], -2);	


blend(aSignal, blend)

Blend two signals by some proportion.

Signal[1, 2, 3, 4].blend(Signal[5, 5, 5, 0], 0);
Signal[1, 2, 3, 4].blend(Signal[5, 5, 5, 0], 0.2);
Signal[1, 2, 3, 4].blend(Signal[5, 5, 5, 0], 0.4);
Signal[1, 2, 3, 4].blend(Signal[5, 5, 5, 0], 1);
Signal[1, 2, 3, 4].blend(Signal[5, 5, 5, 0], 2);




Fourier Transform:


*fftCosTable(size)

Fill a Signal with the cosine table needed by the FFT methods.

Signal.fftCosTable(512).plot;


fft(imag, cosTable)

Perform an FFT on a real and imaginary signal in place.

(
var size = 512, real, imag, cosTable, complex; 

real = Signal.newClear(size); 
		// some harmonics
real.sineFill2([[8], [13, 0.5], [21, 0.25], [55, 0.125, 0.5pi]]);
		// add a little noise
real.overDub(Signal.fill(size, { 0.2.bilinrand }));

imag = Signal.newClear(size);
cosTable = Signal.fftCosTable(size);

complex = fft(real, imag, cosTable); 
[real, imag, (complex.magnitude) / 100 ].flop.flat
	.plot("fft", Rect(0, 0, 512 + 8, 500), numChannels: 3);
)


ifft(imag, cosTable)

Perform an inverse FFT on a real and imaginary signal in place.

(
var size = 512, real, imag, cosTable, complex, ifft; 

real = Signal.newClear(size); 
		// some harmonics
real.sineFill2([[8], [13, 0.5], [21, 0.25], [55, 0.125, 0.5pi]]);
		// add a little noise
real.overDub(Signal.fill(size, { 0.2.bilinrand }));

imag = Signal.newClear(size);
cosTable = Signal.fftCosTable(size);

complex = fft(real, imag, cosTable).postln;
ifft = complex.real.ifft(complex.imag, cosTable);

[real, ifft.real].flop.flat.plot("fft and back", Rect(0, 0, 512 + 8, 500), numChannels: 2);
)




Unary Messages:

Signal will respond to unary operators by returning a new Signal.

neg, abs, sign, squared, cubed, sqrt
exp, log, log2, log10, sin, cos, tan, asin, acos, atan, sinh, cosh, tanh, 
distort, softclip, nyqring, isPositive, isNegative, 
isStrictlyPositive

x = Signal.sineFill(512, [0, 0, 0, 1]);
[x, x.neg, x.abs, x.sign, x.squared, x.cubed, 
x.asin.normalize, x.exp.normalize, x.distort].flop.flat.plot(numChannels: 9);




Binary Messages:

Signal will respond to binary operators by returning a new Signal.

+, -, *, /, div, %, **, min, max, ring1, ring2, ring3, ring4, 
difsqr, sumsqr, sqrdif, absdif, amclip, 
scaleneg, clip2, excess, <!

(
x = Signal.fill(512, { rrand(0.0, 1.0) });
y = Signal.fill(512, { |i| (i * pi / 64).sin });
[x, y, (x + y) * 0.5, x * y, min(x, y), max(x, y) ].flop.flat.plot(numChannels: 6);
) 


