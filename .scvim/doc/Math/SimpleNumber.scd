SimpleNumber			one dimensional value

superclass: Number

Represents numbers which can be represented by a single one dimensional value.

Most of the Unary and Binary operations are also implemented by UnaryOpUGen
and BinaryOpUGen, so you can get more examples by looking at the help for those.


Unary Operations

neg

negation

bitNot

ones complement

abs

absolute value.

ceil

next larger integer.

floor

next smaller integer

frac

fractional part.

sign

Answer -1 if negative, +1 if positive or 0 if zero.

squared

The square of the number.

cubed

The cube of the number.

sqrt

The square root of the number.

exp

e to the power of the receiver.

reciprocal

1 / this

midicps

Convert MIDI note to cycles per second

cpsmidi

Convert cycles per second to MIDI note.

midiratio

Convert an interval in semitones to a ratio.

ratiomidi

Convert a ratio to an interval in semitones.

ampdb

Convert a linear amplitude to decibels.

dbamp

Convert a decibels to a linear amplitude.

octcps

Convert decimal octaves to cycles per second.

cpsoct

Convert cycles per second to decimal octaves.

log

Base e logarithm.

log2

Base 2 logarithm.

log10

Base 10 logarithm.

sin

Sine.

cos

Cosine.

tan

Tangent.

asin

Arcsine.

acos

Arccosine.

atan

Arctangent.

sinh

Hyperbolic sine.

cosh

Hyperbolic cosine.

tanh

Hyperbolic tangent.

rand

Random number from zero up to the receiver, exclusive.

rand2

Random number from -this to +this.

linrand

Linearly distributed random number from zero to this.

bilinrand

Bilateral linearly distributed random number from -this to +this.

sum3rand

A random number  from -this to +this that is the result of summing three uniform random generators
to yield a bell-like distribution. This was suggested by Larry Polansky as a poor man's gaussian.

distort

a nonlinear distortion function.

softclip

Distortion with a perfectly linear region from -0.5 to +0.5

scurve

Map receiver in the onto an S-curve.

((0..100) / 100 ).collect(_.scurve).plot

ramp

Map receiver onto a ramp starting at 0.

((-100..100) / 100 ).collect(_.ramp).plot

coin

Answers a Boolean which is the result of a random test whose probability of success in a range from 
zero to one is this.

even

Answer if the number is even.

odd

Answer if the number is odd.

isPositive

Answer if the number is >= 0.

isNegative

Answer if the number is < 0.

isStrictlyPositive

Answer if the number is > 0.

booleanValue

return true, if strictly positive ( > 0), otherwise false (see Boolean)

isValidUGenInput

return false if receiver cannot be used in UGen.

magnitude

returns abolute value (see Polar, Complex)

angle

returns angle of receiver conceived as Polar or Complex number.

wait
	within a routine, yield the number so that the clock can wait for this many beats.
	(see Routine)
	
	// create a routine by a function fork
	(
	fork {
		1.wait;
		"I did wait".postln;
		1.0.rand.wait;
		"No you didn't".postln;
		2.wait;
		(1..).do { |i| 
			"yes I did".postln; 
			i.asFloat.rand.wait; 
			"no you didn't".postln; 
			i.wait 
		}
	}
	)

waitUntil
	like wait, only specify a time (measured in beats of the current thread's clock)
	(see Routine)

sleep
	make the current thread sleep, until woken up by re-scheduling. (see Routine)
		

Binary Operations

+ aNumber

Addition

- aNumber

Subtraction

* aNumber

Multiplication

/ aNumber

Division

% aNumber

Modulo

div(aNumber)

Integer Division

** aNumber

Exponentiation

min(aNumber)

Minimum

max(aNumber)

Maximum

& aNumber

Bitwise And

| aNumber

Bitwise Or

bitXor(aNumber)

Bitwise Exclusive Or

bitHammingDistance(aNumber)

Binary Hamming distance, or the count of bits that are not the same in the two numbers

bitTest(aNumber)

Returns true if bit at index aNumber is set.

lcm(aNumber)

Least common multiple

gcd(aNumber)

Greatest common divisor

round(aNumber)

Round to multiple of aNumber

trunc(aNumber)

Truncate to multiple of aNumber

atan2(aNumber)

Arctangent of (this/aNumber)

hypot(aNumber)

Square root of the sum of the squares.

<< aNumber

Binary shift left.

>> aNumber

Binary shift right.

+>> aNumber

Unsigned binary shift right.

fill(aNumber)

ring1(aNumber)

(a * b) + a

ring2(aNumber)

((a*b) + a + b)

ring3(aNumber)

(a*a *b)

ring4(aNumber)

((a*a *b) - (a*b*b))

difsqr(aNumber)

(a*a) - (b*b)

sumsqr(aNumber)

(a*a) + (b*b)

sqrdif(aNumber)

(a - b)**2

sqrsum(aNumber)

(a + b)**2

absdif(aNumber)

(a - b).abs

amclip(aNumber)

0  when  b <= 0,  a*b  when  b > 0

scaleneg(aNumber)

a*b when a < 0, otherwise a.

clip2(aNumber)

clips receiver to +/- aNumber

excess(aNumber)

Returns the difference of the receiver and its clipped form: (a - clip2(a,b)).

<! aNumber

Return the receiver. aNumber is ignored.

asFraction(denominator, fasterBetter)

Return an array of denominator and divisor of the nearest and smallest fraction

rrand(aNumber)

Returns a random number in the interval ]a, b[. If both a and b are Integer then the result will be an Integer.

exprand(aNumber)

Returns an exponentially distributed random number in the interval ]a, b[. Always returns a Float.

gauss(standardDeviation)

Returns a gaussian distributed random number. Always returns a Float.
	
(0..1000).collect { |num| gauss(0.0, num) }.plot;


nextTimeOnGrid(clock)

Return the next possible multiple of the clock's beats.



N-ary Operations


degreeToKey(scale, stepsPerOctave)

	the value is truncated to an integer and used as an index into an octave repeating table of note values.
	Indices wrap around the table and shift octaves as they do
	stepsPerOctave is 12 by default
	
	(
		l = [0, 1, 5, 9, 11]; // pentatonic scale
		(1, 2..15).collect { |i| i.degreeToKey(l, 12) }
	)


keyToDegree(scale, stepsPerOctave)

	inverse of degreeToKey.
	stepsPerOctave is 12 by default
	
	(
		l = [0, 1, 5, 9, 11]; // pentatonic scale
		(60, 61..75).collect { |i| i.keyToDegree(l, 12) }
	)
	(
		l = [0, 1, 5, 9, 11]; // pentatonic scale
		(60, 61..75).postln.collect { |i| i.keyToDegree(l, 12).degreeToKey(l) }
	)
	
nearestInList(list)

	returns the value in the collection closest to this
	
	(
		l = [0, 0.5, 0.9, 1];
		(0, 0.05..1).collect { |i| i.nearestInList(l) }
	)


nearestInScale(scale, stepsPerOctave)

	returns the value in the collection closest to this, assuming an octave repeating table of note values.
	stepsPerOctave is 12 by default
	
	(
		l = [0, 1, 5, 9, 11]; // pentatonic scale
		(60, 61..76).collect { |i| i.nearestInScale(l, 12) }
	)
	
partition(parts, min)

	randomly partition a number into parts of at least min size.

	75.partition(8, 3);
	75.partition(75, 1);


asTimeString(precision, maxDays = 365, dropDaysIfPossible = true)

	returns a string corresponding to the days:hours:minutes:seconds 
	based on the receiver as number of seconds.
	precision is 0.001 (ms) by default
	this format is inspired by ISO 8601 time interval display (truncated representation)
	returns string "ddd:hh:mm:ss:ttt" where t is milliseconds
	see String:asSecs for complement
	
	(
		var start = Main.elapsedTime;
		fork { loop { (Main.elapsedTime - start).asTimeString.postln; 0.05.wait } };
	)

equalWithPrecision(that, precision)

	return true if receiver is closer to that than precision. (default for precision: 0.0001)
	
	3.1.equalWithPrecision(3.0, 0.05); // false
	3.1.equalWithPrecision(3.0, 0.1); // false
	3.1.equalWithPrecision(3.0, 0.11); // true

	
quantize(quantum, tolerance, strength)
	
	round the receiver to the quantum (default: 1.0) allowing for a tolerance (default: 0.05).
	How much the value is allowed to differ in the tolerance range is determined by strength (default: 1.0).

	((0..10) / 10).collect { |num| num.quantize(1, 0.3, 0.5) }.postcs.plot;
	((0..10) / 10).collect { |num| num.quantize(1, 0.6, 0.5) }.postcs.plot;
	((0..10) / 10).collect { |num| num.quantize(1, 1.0, 0.5) }.postcs.plot;


linlin(inMin, inMax, outMin, outMax, clip)

	map the receiver from an assumed linear input range (inMin..inMax)
	to a linear output range (outMin..outMax). If the input exceeds the assumed input range. 
	If the input exceeds the input range, the following behaviours are specified by the clip argument: 
		nil (don't clip), \max (clip ceiling), \min, (clip floor), \minmax (clip both - this is default).
		
	(0..10).collect { |num| num.linlin(0, 10, -4.3, 100) }; 
	(0..10).linlin(0, 10, -4.3, 100); // equivalent.


linexp(inMin, inMax, outMin, outMax, clip)

	map the receiver from an assumed linear input range (inMin..inMax)
	to an exponential output range (outMin..outMax).
	The output range must not include zero. 
	If the input exceeds the input range, the following behaviours are specified by the clip argument: 
		nil (don't clip), \max (clip ceiling), \min, (clip floor), \minmax (clip both - this is default).
		
	(0..10).collect { |num| num.linexp(0, 10, 4.3, 100) }; 
	(0..10).linexp(0, 10, 4.3, 100); // equivalent.
	
explin(inMin, inMax, outMin, outMax, clip)

	map the receiver from an assumed exponential input range (inMin..inMax)
	to a linear output range (outMin..outMax). If the input exceeds the assumed input range.
	The input range must not include zero. 
	If the input exceeds the input range, the following behaviours are specified by the clip argument: 
		nil (don't clip), \max (clip ceiling), \min, (clip floor), \minmax (clip both - this is default).	

	(1..10).collect { |num| num.explin(0.1, 10, -4.3, 100) }; 
	(1..10).explin(0.1, 10, -4.3, 100); // equivalent.
	

expexp(inMin, inMax, outMin, outMax, clip)

	map the receiver from an assumed exponential input range (inMin..inMax)
	to an exponential output range (outMin..outMax). If the input exceeds the assumed input range.
	Both input range and output range must not include zero. 
	If the input exceeds the input range, the following behaviours are specified by the clip argument: 
		nil (don't clip), \max (clip ceiling), \min, (clip floor), \minmax (clip both - this is default).

	(1..10).collect { |num| num.expexp(0.1, 10, 4.3, 100) }; 
	(1..10).expexp(0.1, 10, 4.3, 100); // equivalent.
	
lincurve(inMin, inMax, outMin, outMax, curve, clip)

	map the receiver from an assumed linear input range (inMin..inMax)
	to an exponential curve output range (outMin..outMax). A curve is like the curve parameter in Env
	Unlike with linexp, the output range may include zero. 
	If the input exceeds the input range, the following behaviours are specified by the clip argument: 
		nil (don't clip), \max (clip ceiling), \min, (clip floor), \minmax (clip both - this is default).
		
	(0..10).collect { |num| num.lincurve(0, 10, -4.3, 100, -3) }; 
	(0..10).lincurve(0, 10, -4.3, 100, -3); // equivalent.
	// different curves:
	(
	(-4..4).do { |val|
		(0..100).collect(_.lincurve(0, 100, 0, 1, val)).plot
	}
	)
	
	
curvelin(inMin, inMax, outMin, outMax, curve, clip)

	map the receiver from an assumed curve-exponential input range (inMin..inMax)
	to a linear output range (outMin..outMax). If the input exceeds the assumed input range.
	A curve is  like the curve parameter in Env.
	Unlike with explin, the input range may include zero. 
	If the input exceeds the input range, the following behaviours are specified by the clip argument: 
		nil (don't clip), \max (clip ceiling), \min, (clip floor), \minmax (clip both - this is default).	

	(1..10).collect { |num| num.curvelin(0, 10, -4.3, 100, -3) }; 
	(1..10).curvelin(0, 10, -4.3, 100, -3); // equivalent.
	// different curves:
	(
	(-4..4).do { |val|
		(0..100).collect(_.curvelin(0, 100, 0, 1, val)).plot
	}
	)

	
bilin(inCenter, inMin, inMax, outCenter, outMin, outMax, clip)

	map the receiver from two assumed linear input ranges (inMin..inCenter) and (inCenter..inMax)
	to two linear output ranges (outMin..outCenter) and (outCenter..outMax).
	If the input exceeds the input range, the following behaviours are specified by the clip argument: 
		nil (don't clip), \max (clip ceiling), \min, (clip floor), \minmax (clip both - this is default).


	(
		var center = 0.5, ctlCenter;
		w = Window("bilin", Rect(100, 100, 200, 100)).front;
		a = Slider(w, Rect(20, 20, 150, 20)).value_(0.5);
		b = Slider(w, Rect(20, 45, 150, 20)).value_(0.5);
		b.action = { center = b.value };
		a.mouseDownAction = { ctlCenter = a.value };
		a.action = { 
			b.value = a.value.bilin(ctlCenter, 0, 1, center, 0, 1);
		};
	)

biexp(inCenter, inMin, inMax, outCenter, outMin, outMax, clip)

	map the receiver from two assumed exponential input ranges (inMin..inCenter) and (inCenter..inMax)
	to two linear output ranges (outMin..outCenter) and (outCenter..outMax).
	The input range must not include zero. 
	If the input exceeds the input range, the following behaviours are specified by the clip argument: 
		nil (don't clip), \max (clip ceiling), \min, (clip floor), \minmax (clip both - this is default).	
		
	// doesn't properly work yet.
	(
		var center = 0.5, ctlCenter;
		w = Window("biexp", Rect(100, 100, 200, 100)).front;
		a = Slider(w, Rect(20, 20, 150, 20)).value_(0.5);
		b = Slider(w, Rect(20, 45, 150, 20)).value_(0.5);
		b.action = { center = b.value };
		a.mouseDownAction = { ctlCenter = a.value + 0.05 };
		a.action = {
			b.value = (a.value + 0.1).biexp(ctlCenter, 0.1, 1.1, center, 0, 1);
		};
	)
	
lcurve(a, m, n, tau)

	map the receiver onto an L-curve, using the formula: a * (m * exp(x) * rTau + 1) / (n * exp(x) * rTau + 1).
	This is used for smoothing values and limiting them to a range. Defalt values: a = 1; m = 0; tau = 1.
	
	(0..1000).normalize(-10, 10).collect { |num| num.lcurve }.plot;	
	

gaussCurve(a, b, c)

	map the receiver onto a gauss function, using the formula: a * (exp(squared(this - b) / (-2.0 * squared(c))))	Defalt values: a = 1; b = 0; c = 1
	
	(0..1000).normalize(-10, 10).collect { |num| num.gaussCurve }.plot;
	
	
series(second, last)

	return an artithmetic series from this over second to last. This is used in the shortcuts:
	(0..100) or (1, 3 .. 17). if second is nil, it is one magnitude step towards last (1 or -1).
	
	series(5, 7, 10);
	series(5, nil, 10);
	(5, 7 .. 10)	
	
	
seriesIter(second, last)

	return a Routine that iterates over the numbers from this to last. 
	Since this is a lazy operation, last may be inf, generating an endless series 
	(see also: ListComprehensions)
	
	r = seriesIter(0, 5);
	r.nextN(8);	
	r.nextN(8);	



