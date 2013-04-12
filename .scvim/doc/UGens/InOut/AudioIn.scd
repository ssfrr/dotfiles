AudioIn			read audio input

superclass: SoundIn

AudioIn.ar(channel, mul, add)

Reads audio from the sound input hardware. This is provided for backwards compatibility with SC2 code. For normal use SoundIn, which has bus numbers beginning at 0, as AudioIn may be deprecated and removed at some point in the future.

channel - input channel number to read. 
	Channel numbers begin at 1.

See also: In, ServerOptions, SoundIn

// beware of the feedback - wear headphones to prevent it.

// patching input to output
(
SynthDef("help-AudioIn",{ arg out=0;
	Out.ar(out,
		AudioIn.ar(1)
	)
}).play;
)

// stereo through patching from input to output
(
SynthDef("help-AudioIn",{ arg out=0;
	Out.ar(out,
		AudioIn.ar([1,2])
	)
}).play;
)

// simpler:
{ AudioIn.ar([1, 2]) }.play;

// scope output (required internal server)
{ AudioIn.ar([1,2]) }.scope;



