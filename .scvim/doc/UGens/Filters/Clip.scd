Clip			clip a signal outside given thresholds

Clip.ar(in, lo, hi)
Clip.kr(in, lo, hi)

This differs from the BinaryOpUGen clip2 in that it allows one to set both low and high thresholds.
in - signal to be clipped
lo - low threshold of clipping. Must be less then hi.
hi - high threshold of clipping. Must be greater then lo.


Server.internal.boot;

{ Clip.ar(SinOsc.ar(440, 0, 0.2), -0.07, 0.07) }.scope;


