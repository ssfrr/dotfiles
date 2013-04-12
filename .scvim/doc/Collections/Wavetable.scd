Wavetable				sampled audio buffer in wavetable format

Inherits from: Object : Collection : SequenceableCollection : ArrayedCollection : RawArray : FloatArray

A Wavetable is a FloatArray in a special format used by SuperCollider's interpolating
oscillators. Wavetables cannot be created by new.

see also: Signal

Creation

*sineFill(size, amplitudes, phases)

Fill a Wavetable of the given size with a sum of sines at the given amplitudes and phases.
The Wavetable will be normalized.
size - must be a power of 2.
amplitudes - an Array of amplitudes for each harmonic beginning with the fundamental.
phases - an Array of phases in radians for each harmonic beginning with the fundamental.

Wavetable.sineFill(512, 1.0/[1, 2, 3, 4, 5, 6]).plot;


*chebyFill(size, amplitudes, phases)

Fill a Wavetable of the given size with a sum of Chebyshev polynomials at the given amplitudes
for use in waveshaping by the Shaper ugen.
The Wavetable will be normalized.
size - must be a power of 2 plus 1, eventual wavetable is next power of two size up.
amplitudes - an Array of amplitudes for each Chebyshev polynomial beginning with order 1.

Wavetable.chebyFill(513, [1]).plot;

Wavetable.chebyFill(513, [0, 1]).plot;

Wavetable.chebyFill(513, [0, 0, 1]).plot;

Wavetable.chebyFill(513, [0.3, -0.8, 1.1]).plot;



Instance Methods

plot(name, bounds, minval, maxval, parent)

Plot the Wavetable in a window. The arguments are not required and if not given defaults will be used.
name - a String, the name of the window.
bounds - a Rect giving the bounds of the window.
minval - the minimum value in the plot. Defaults to the highest value in the data.
maxval - the maximum value in the plot. Defaults to the lowest value in the data.
parent - a window to place the plot in. If nil, one will be created for you

Wavetable.sineFill(512, [0.5]).plot;

Wavetable.sineFill(512, [1]).plot("Table 1", Rect(50, 50, 150, 450));



asSignal

Convert the Wavetable into a Signal.

Wavetable.sineFill(512, [1]).asSignal.plot;



