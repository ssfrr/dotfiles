fold2			bilateral folding

BinaryOperator

fold2(a, b)
a fold2: b
a.fold2(b)

folds input wave a to +/- b

{ FSinOsc.ar(1000).fold2(Line.kr(0,1,8)) }.scope;



