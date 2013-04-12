**				exponentiation

BinaryOperator

a ** b

When the signal is negative this function extends the usual definition of
exponentiation and returns neg(neg(a) ** b). This allows exponentiation of
negative signal values by noninteger exponents.

redirects to pow(a, b)

(
{
var a;
a = FSinOsc.ar(100);
[a, a ** 10]
}.play
)


// using exponentiation for compression or expansion
s.sendMsg("/b_allocRead", 0, "sounds/a11wlk01.wav"); // load a soundfile

// compression
(
{
var in = PlayBuf.ar(1, 0, 1, loop: 1);
in ** 0.7 
}.play;
)

// expansion
(
{
var in = PlayBuf.ar(1, 0, 1, loop: 1);
in ** 2
}.play;
)







