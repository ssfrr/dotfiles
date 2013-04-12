amclip		two quadrant multiply

BinaryOperator

amclip(a, b)
a amclip: b
a.amclip(b)

0  when  b <= 0,  a*b  when  b > 0

{ WhiteNoise.ar.amclip(FSinOsc.kr(1,0.2)) }.play; // makes a sine envelope



