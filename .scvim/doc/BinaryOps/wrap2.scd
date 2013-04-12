wrap2			bilateral wrapping

BinaryOperator

wrap2(a, b)
a wrap2: b
a.wrap2(b)

wraps input wave to +/- b

{ FSinOsc.ar(1000).wrap2(Line.kr(0,1.01,8)) }.scope;



