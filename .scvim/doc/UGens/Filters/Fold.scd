Fold			fold a signal outside given thresholds

Fold.ar(in, lo, hi)
Fold.kr(in, lo, hi)

This differs from the BinaryOpUGen fold2 in that it allows one to set both low and high thresholds.
in - signal to be folded
lo - low threshold of folding. Sample values < lo will be folded. lo must be less then hi.
hi - high threshold of folding. Sample values > hi will be folded. hi must be greater then lo.


Server.internal.boot;

{ Fold.ar(SinOsc.ar(440, 0, 0.2), -0.1, 0.1) }.scope;


