Integer				integer number

superclass: SimpleNumber

A 32 bit integer. Integer inherits most of its behaviour from its superclass.


Iteration

do(function)

Executes function for all integers from zero to this minus one.
function - a Function which is passed two arguments, both of which are the same
integer from zero to this minus one. The reason two arguments are passed is for
symmetry with the implementations of do in Collection.

reverseDo(function)
Executes function for all integers from  this minus one to zero.

for(endval, function)

Executes function for all integers from this to endval, inclusive.
endval - an Integer.
function - a Function which is passed two arguments, the first which is an integer from this to
endval, and the second which is a number from zero to the number of iterations minus one.

forBy(endval, step, function)

Executes function for all integers from this to endval, inclusive, stepping each time by step.
endval - an Integer.
step - an Integer.
function - a Function which is passed two arguments, the first which is an integer from this to
endval, and the second which is a number from zero to the number of iterations minus one.

collect(function)

Return an Array of this size filled by objects generated from evaluating the function.

collectAs(function, class)

Return a Collection of class of this size filled by objects generated from evaluating the function.

to(hi, step)
return an Interval from this to hi.

geom(start, grow)
return an array with a geometric series of this size from start. 

fib(a, b)
return an array with a fibonacci series of this size beginning with a and b.

factors
return the prime factors as array.

factorial
return the factorial of this.




Random Numbers
see also: Randomness

xrand(exclude)

Answer a random value from zero to this, excluding the value exclude.
exclude - an Integer.

xrand2(exclude)

Answer a random value from this.neg to this, excluding the value exclude.
exclude - an Integer.



Conversion

asAscii

Answer a Char which has the ASCII value of the receiver.

asDigit

Answer a Char which represents the receiver as an ASCII digit. For example 
5.asDigit returns $5.

asBinaryDigits(numDigits)

Answer an array with the binary digits (integer 0 or 1). numDigits defaults to 8.

asDigits(base, numDigits)

Answer an array with the n-ary digits, base defaults to 10.
See also the complementary method SequenceableCollection convertDigits.

2007.asDigits;
2007.asDigits(2);


asBinaryString(numDigits)

Answer a string with the binary digits (0 or 1). numDigits defaults to 8.

asHexString(numDigits)

Answer a string with the hexadecimal digits (integer 0 to F). numDigits defaults to 8.

asIPString

Answer a string in IP format.


degreeToKey(scale, stepsPerOctave)
Interpret this as index into a scale with a given number of steps per ocatve.

2.degreeToKey([0, 2, 5, 7, 11]);

grayCode
Return the gray code for the number.

2.grayCode


Binary Representation

setBit(bitNumber, bool)
set nth bit to zero (bool = false) or one (bool = true)

leadingZeroes { _CLZ }

trailingZeroes { _CTZ }

numBits
return number of required bits



Properties

even
Answers true if dividable by 2 with no rest

odd
Answers true if not dividable by 2 with no rest


Powers Of Two

nextPowerOfTwo

Answer the next power of two greater than or equal to the receiver.

13.nextPowerOfTwo.postln;
64.nextPowerOfTwo.postln;

isPowerOfTwo

Answer the whether the receiver is a power of two.

13.isPowerOfTwo.postln;
64.isPowerOfTwo.postln;

Prime Numbers

nthPrime

Answer the nth prime number. The receiver must be from 0 to 6541.

[0,1,2,3,4,5].collect({ arg i; i.nthPrime; }).postln;

prevPrime

Answer the next prime less than or equal to the receiver up to 65521.

25.prevPrime.postln;

nextPrime

Answer the next prime less than or equal to the receiver up to 65521.

25.nextPrime.postln;

isPrime

Answer whether the receiver is prime.

25.isPrime.postln;
13.isPrime.postln;

indexOfPrime

Answer the index of a prime number less than or equal to the receiver up to 65521.
If the receiver is not a prime, the answer is nil.

23.indexOfPrime;
25.indexOfPrime;


Misc

pidRunning

Returns a Boolean for whether or not the specified pid is running.

p = "cat".unixCmd;
p.pidRunning; // cat will stay alive
("kill" + p).unixCmd
p.pidRunning;

getKeys

Returns the bits from the Macintosh GetKeys() Toolbox call. Receiver should be 0 to 3.

[0.getKeys, 1.getKeys, 2.getKeys, 3.getKeys].postln;


