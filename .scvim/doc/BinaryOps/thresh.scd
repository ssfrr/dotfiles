thresh			signal thresholding

BinaryOperator

thresh(a, b)
a thresh: b
a.thresh(b)


0 when a < b, otherwise a.

{ LFNoise0.ar(50, 0.5) thresh: 0.45 }.play // a low-rent gate




