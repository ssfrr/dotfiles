Float				floating point number

superclass: SimpleNumber

A 64 bit double precision floating point number. Float inherits most of its behaviour from its superclass.


*from32Bits(word)

Answer a new Float from a 32 bit word.

*from64Bits(word)

Answer a new Float from a 64 bit word.



Instance Methods

do(function)
iterates function from 0 to this-1. See also: Function, Integer, Collection

reverseDo(function)
iterates function from this-1 to 0

coin

Answers a Boolean which is the result of a random test whose probability of success in a range from 
zero to one is this. See also: Randomness

0.2.coin; // 20 % chance for true.

isFloat

Answer true since this is a Float.

asFloat

Answer this since this is a Float.

as32Bits

Answer an Integer which is the bit pattern of this as a 32bit single precision float

high32Bits

Answer an Integer which is the bit pattern of high 32 bits of the 64 bit double precision floating point value

low32Bits

Answer an Integer which is the bit pattern of high 32 bits of the 64 bit double precision floating point value

asStringPrec(precision)

Returns a string representation of the number, with the desired precision (i.e. number of significant figures).

// example:
pi
pi.asStringPrec(3)
pi.asStringPrec(6)
(pi * 0.0001).asStringPrec(3)
7.4.asStringPrec(5)
7.4.asStringPrec(50)


