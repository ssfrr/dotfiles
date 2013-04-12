/				division

BinaryOperator

a / b

Division can be tricky with signals because of division by zero.

{ PinkNoise.ar(0.1) / FSinOsc.kr(10, 0, 0.5, 0.75) }.play;

{ PinkNoise.ar(0.1) / FSinOsc.kr(10, 0, 0.5) }.play;	//note: div by zero


