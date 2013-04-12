Mix			sum an array of channels

Mix.new(array)

Mix will mix an array of channels down to a single channel or an array of arrays of channels down to a single array of channels. More information can be found under MultiChannel.

s.boot;
{ Mix.new([ PinkNoise.ar(0.1), FSinOsc.ar(801, 0.1), LFSaw.ar(40, 0.1)]) }.play

*fill(n, function)

A common idiom using Mix is to fill an Array and then mix the results:

(
play({ 
	Mix.new( Array.fill(8, { SinOsc.ar(500 + 500.0.rand, 0, 0.05) }) ); 
}))

The *fill methods allow this idiom to be written more concisely:

(
play({ 
	Mix.fill(8, { SinOsc.ar(500 + 500.0.rand, 0, 0.05) }); 
}))

Note that Mix-ar and Mix-kr in SC2 are equivalent to Mix-new in SC3, and that Mix-arFill and Mix-krFill are equivalent to Mix-fill.


