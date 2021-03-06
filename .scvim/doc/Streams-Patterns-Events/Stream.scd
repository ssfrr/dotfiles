Stream

Inherits from: Object : AbstractFunction

Stream is an abstract class that is not used directly.  The following attempts to document some
aspects of the use of Streams for music generation.

Overview

A Stream represents a sequence of values that are obtained incrementally by repeated
next messages.  A Stream can be restarted with a reset message. (Not all streams 
actually implement reset semantics.)

The class Object defines next to return the object itself.  Thus every object can be viewed
as a stream and most simply stream themselves.  

Stream is the base class for classes that define streams.

In SuperCollider, Streams are primarily used for handling text and for generating music.


Two Stream classes: FuncStream and Routine



FuncStream(nextFunction, resetFunction)

A Function defines a stream consisting of the Function itself, a FuncStream defines a stream
that consists of evaluations of its nextFunction.

	// Example 1: a Function vs. a FuncStream
	(	
		f = { 33.rand };
		x = FuncStream(f);
		10.do({ [f.next, x.next].postln });
	)
	
	// Example 2: the reset function
	(	
	
		f = { 33.rand };
		x = FuncStream(f, {thisThread.randSeed_(345)});
		x.reset;
		10.do({ [f.next, x.next].postln });
		x.reset;
		10.do({ [f.next, x.next].postln });
	)

Routine(nextFunction, stacksize)

In a FuncStream, the nextFunction runs through to completion for each element of the stream.
In a Routine, the nextFunction returns values with yield and resumes execution (when it receives
a next  message) at the expression folowing the yield.  This allows a sequence of expressions in
the function definition to represent a sequence of distinct events, like a musical score.


	// example
	(
		x = Routine({ 
					1.yield;
					2.yield;
					3.yield; 
			});
			4.do({ x.next.postln });
	)

Once the nextFunction completes execution, the Routine simply yields nil repeatedly.
Control structures (such as do or while) can be used within the nextFunction in a manner analogous
to repeat marks in a score

	// example
	(
			x = Routine({ 
				4.do({
					[1,2,3,4].do({ arg i; i.yield; });
				})
			});
			17.do({ x.next.postln });
	)



Playing streams

Because streams respond like functions to the value message, 
they can be used as a scheduling task. 

	// compare:
	// a function, returning 0.5
	(
	SystemClock.sched(0.0, 
		{ "***".postln; 0.5 }
	);
	)
	
	// a stream, returning 0.5 and 0.1
	(
	SystemClock.sched(0.0, 
		Routine({ loop { 
			"***".postln; 0.5.yield; 
			"_*_".postln; 0.1.yield; 
		} })
	);
	)
	
	// this is the reason why 'wait' works the same (for numbers) like 'yield' 
	(
	SystemClock.sched(0.0, 
		Routine({ loop { 
			"***".postln; 0.5.wait; 
			"_*_".postln; 0.1.wait; 
		} })
	);
	)


Streams that return numbers can be played directly with the play message:

	
	play(clock, quant)
		clock:		a Clock, TempoClock by default
		quant:		either a number n (quantize to n beats)
					or an array [n, m] (quantize to n beats, with offset m)


	// play at the next beat, with offset 0.4
	(
	Routine({ loop { 
			"***".postln; 0.5.wait; 
			"_*_".postln; 0.1.wait; 
	} }).play(quant:[1, 0.4]);
	)


Streams that return Events need to be wrapped in an EventStreamPlayer. 
The Event's delta (can also be set by dur) is used as a scheduling beats value:

	// play at the next beat, with offset 0.4
	(
	Routine({ loop { 
			"///".postln; (delta:0.5).yield; 
			"_/_".postln; (delta: 0.1).wait; 
	} }).asEventStreamPlayer.play;
	)



Iteration

	
	do (function)
		iterate until a nil is encountered
		beware: applying do to an endless stream will lock up the interpreter!

	Where do effectively 'plays' a stream by iterating all of its contects,  the 
	following messages create a stream by filtering another stream in some way.

	collect (function)
		iterate indefinitely

	reject (function)
		return only those elements for which function.value(element) is false

	select (function)
		return only those elements for which function.value(element) is true

	dot(function, stream)
		return function.value(this.next, stream.next) for each element

	interlace(function, stream)
		iterate all of stream for each element of this.  Combine the values using function.
	
	appendStream(stream)
		append stream after this returns nil. The same like ++
	
	embedInStream(inval)
		iterate all of this from within whatever Stream definition it is called.
	
	trace(key, printStream, prefix)
		print out the results of a stream while returning the original values
		
		key: 			when streaming events, post only this key.
		printStream: 	printOn this stream (default: Post)
		prefix:		string added to the printout to separate different streams





Composite Streams


Routines can be embedded in each other, using embedInStream:

	// example
	(
	x = Routine({ 
				2.do({
					[1,2,3,4].do({ arg i; i.yield; });
				})
			});
	y = Routine({
			100.yield;
			30.yield;
			x.embedInStream;
			440.yield;
			1910.yield
	});
	17.do({ y.next.postln });
	)


Routines can be concatenated just like Streams:

	(
	x = Routine({ 
				2.do({
					[1,2,3,4].do({ arg i; i.yield; });
				})
			});
	y = Routine({
			100.yield;
			30.yield;
	});
	z = x ++ y;
	17.do({ z.next.postln });
	)

Routines can be combined with the composition operator <>

	(
	x = Routine({ arg inval;
				2.do({
					
					[1,2,3,4].do({ arg i; 
						if(inval.isNil) { nil.alwaysYield };
						inval = (i * inval).yield; 
					});
				})
			});
			
	y = Routine({
			100.yield;
			30.yield;
			4.do { 1.0.rand.yield };
	});
	
	z = x <> y;
	17.do({ z.value.postln }); // call .value here, as this is a function.
	)


Composite Streams can be defined as combinations of Streams using the unary and binary 
messages.


Unary messages


Streams support most of the unary messages  defined in AbstractFunction:

(
	a = Routine({ 20.do({ 33.rand.yield }) });
	b = Routine({ [-100,00,300,400].do({ arg v; v.yield}) });

	c = b.neg; // define a composite stream		
	
	// enumerate and perform all of the unary messages	:	
	[ 
		\neg, \reciprocal, \bitNot, \abs, \asFloat, \asInteger, \ceil, 
		\floor, \frac, \sign, \squared, \cubed, \sqrt, \exp, \midicps, 
		\cpsmidi, \midiratio, \ratiomidi, \ampdb, \dbamp, \octcps, 
		\cpsoct, \log, \log2, \log10, \sin, \cos, \tan, \asin, \acos, \atan, 
		\sinh, \cosh, \tanh, \rand, \rand2, \linrand, \bilinrand, \sum3rand, 
		\distort, \softclip, \coin, \even, \odd, \isPositive, \isNegative,
		\isStrictlyPositive
	]
	.do({ arg msg;
			postf("\n msg: % \n", msg);
			b.reset.perform(msg).do({arg v; v.post; " ".post;}) 
	}); 
	nil;
	
)



Binary messages

Streams support the following binary messages  defined in AbstractFunction:


(
	a = Routine({ 20.do({ 33.rand.yield }) });
	b = Routine({ [-100,00,300,400].do({ arg v; v.yield}) });
	[
	'+' , '-' , '*', '/', \div, '%', '**', \min, \max, '<', '<=', '>', '>=', '&', '|', 
	\bitXor, \lcm, \gcd, \round, \trunc, \atan2, 
	\hypot, '>>', '+>>', \ring1, \ring2, \ring3, \ring4, 
	\difsqr, \sumsqr, \sqrdif, \absdif, \amclip,
	\scaleneg, \clip2, \excess, '<!', \rrand, \exprand
	]
		.do({ arg msg;
			postf("\n msg: % \n", msg);
			b.reset.perform(msg).do({ arg v; v.post; " ".post; }) 
		}); 
		nil;
)
 

	


