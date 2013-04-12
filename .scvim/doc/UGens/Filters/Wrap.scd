Wrap			wrap a signal outside given thresholds

Wrap.ar(in, lo, hi)
Wrap.kr(in, lo, hi)

This differs from the BinaryOpUGen wrap2 in that it allows one to set both low and high thresholds.
in - signal to be wrapped
lo - low threshold of wrapping. Must be less then hi.
hi - high threshold of wrapping. Must be greater then lo.


Server.internal.boot;

{ Wrap.ar(SinOsc.ar(440, 0, 0.2), -0.15, 0.15) }.scope;


