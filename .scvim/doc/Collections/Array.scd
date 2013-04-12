Array

Inherits from: Object : Collection : SequenceableCollection : ArrayedCollection

Arrays are ArrayedCollections whose slots may contain any object. Arrays have a fixed maximum size beyond which they cannot grow. For expandable arrays, use the List class.

An array can be created with a fixed maximum capacity:
	
	z = Array.new(size);

Which will return an array of size 0, but the capability to add up to 32
objects. 

	z = z.add(obj);

z now has a size of 1.

For Arrays, the 'add' method may or may not return the same Array object. It will add the argument to the receiver if there is space, otherwise it returns a new Array object with the argument added. Thus the proper usage of 'add' with an Array is to always assign the result as follows:

	z = z.add(obj);

This allows an efficient use of resources, only growing the array when it needs to.  The List class manages the Array for you, and in many cases in more suitable.

An array can be created with all slots filled with nils:

	z = Array.newClear(size);

Elements can be put into an existing slot:

	a.put(2,obj);

And accessed :

	a.at(2); // these are equivalent
	a[2];

See ArrayedCollection for the principal methods:
	at
	put
	clipAt, wrapAt etc.

Literal Arrays can be created at compile time, and are very efficient. See Literals for information.

Class Methods

*with(... args)
Create a new Array whose slots are filled with the given arguments. 
This is the same as the method in ArrayedCollection, but is reimplemented here to be more efficient.

Array.with(7, 'eight',  9).postln;

Instance Methods

reverse
Returns a new Array whose elements are reversed. The receiver is unchanged.

[1, 2, 3].reverse.postln;

(
x = [1, 2, 3];
z = x.reverse;
x.postln;
z.postln;
)

scramble
Returns a new Array whose elements have been scrambled. The receiver is unchanged.

[1, 2, 3, 4, 5, 6].scramble.postln;

mirror
Return a new Array which is the receiver made into a palindrome. 
The receiver is unchanged.

[1, 2, 3, 4].mirror.postln;

mirror1
Return a new Array which is the receiver made into a palindrome with the last element removed. 
This is useful if the list will be repeated cyclically, the first element will not get played twice.
The receiver is unchanged.

[1, 2, 3, 4].mirror1.postln;

mirror2
Return a new Array which is the receiver concatenated with a reversal of itself. 
The center element is duplicated. The receiver is unchanged.

[1, 2, 3, 4].mirror2.postln;

stutter(n)
Return a new Array whose elements are repeated n times. The receiver is unchanged.

[1, 2, 3].stutter(2).postln;

rotate(n)
Return a new Array whose elements are in rotated order. Negative n values rotate left, postive n values
rotate right. The receiver is unchanged.

[1, 2, 3, 4, 5].rotate(1).postln;

[1, 2, 3, 4, 5].rotate(-1).postln;

[1, 2, 3, 4, 5].rotate(3).postln;

pyramid
Return a new Array whose elements have been reordered via one of 10 "counting" algorithms.
The algorithms are numbered 1 through 10. Run the examples to see the algorithms.

[1, 2, 3, 4].pyramid(1).postln;

(
10.do({ arg i;
	[1, 2, 3, 4].pyramid(i + 1).postcs;
});
)

pyramidg
Like pyramid, but keep the resulting values grouped in subarrays.

// compare:
[1, 2, 3, 4].pyramid(1).postln;
[1, 2, 3, 4].pyramidg(1).postln;

(
10.do({ arg i;
	[1, 2, 3, 4].pyramid(i + 1).postcs;
	[1, 2, 3, 4].pyramidg(i + 1).postcs;
});
)

sputter(probability, maxlen)
Return a new Array of length maxlen with the items partly repeated (random choice of given probability).

// compare:
[1, 2, 3, 4, 5, 6, 7, 8, 9, 10].sputter(0.5, 16).postln;
[1, 2, 3, 4, 5, 6, 7, 8, 9, 10].sputter(0.8, 8).postln;


lace(length)
Returns a new Array whose elements are interlaced sequences of the elements of the receiver's subcollections, up to size length. The receiver is unchanged.

(
x = [ [1, 2, 3], 6, List["foo", 'bar']];
y = x.lace(12);
x.postln;
y.postln;
)

permute(nthPermutation)
Returns a new Array whose elements are the nthPermutation of the elements of the receiver. The receiver is unchanged.

(
x = [ 1, 2, 3];
6.do({|i| x.permute(i).postln;});
)

allTuples(maxTuples)
Returns a new Array whose elements contain all possible combinations of the receiver's subcollections.

[[1, 2, 3, 4, 5], [10, 20, 30]].allTuples;
[[1, 2, 3, 4, 5], [10, 20, 30], [5, 6]].allTuples;


wrapExtend(length)
Returns a new Array whose elements are repeated sequences of the receiver, up to size length. The receiver is unchanged.

(
x = [ 1, 2, 3, "foo", 'bar' ];
y = x.wrapExtend(9);
x.postln;
y.postln;
)

foldExtend(length)
Same as wrapExtend but the sequences fold back on the list elements.

(
x = [ 1, 2, "foo"];
y = x.foldExtend(9);
x.postln;
y.postln;
)

clipExtend(length)
Same as wrapExtend but the sequences "clip" (return their last element) rather than wrapping.

(
x = [ 1, 2, "foo"];
y = x.clipExtend(9);
x.postln;
y.postln;
)

slide(windowLength, stepSize)
Return a new Array whose elements are repeated subsequences from the receiver. 
Easier to demonstrate than explain.

[1, 2, 3, 4, 5, 6].slide(3, 1).postcs;
[1, 2, 3, 4, 5, 6].slide(3, 2).postcs;
[1, 2, 3, 4, 5, 6].slide(4, 1).postcs;

shift(n)
Shift the values of the array n steps to the right (n positive) or to the left(n negative), 
dropping the excess and filling empty space with zero.

[1, 2, 3, 4, 5, 6].shift(3).postln;
[1, 2, 3, 4, 5, 6].shift(-3).postln;


containsSeqColl
Returns true if the receiver Array contains any instance of SequenceableCollection

[1, 2, 3, 4].containsSeqColl.postln
[1, 2, [3], 4].containsSeqColl.postln

powerset
Returns all possible combinations of the array's elements.

[1, 2, 3].powerset.postln
[1, 2, 3].powerset.sort({ |a, b| a.size > b.size }); // sort by size, big first
[1, 2, 3].powerset.sort({ |a, b| a.size > b.size }).reverse; // by size, small first

powerset is also supported in Collection:

Set[1, 2, 3].powerset;
List[1, 2, 3].powerset
(a: 1, b: 2, c: 3).powerset;

envirPairs
Given an array of symbols, this returns an array of pairs of (symbol, value) from the current environment.
This can then be used as arguments for a Synth, or in an OSC message.

(
e = (freq: 340, amp: 0.001, strangeness: 0.85);
e.use {
	[\amp, \taste, \strangeness].envirPairs;
}
);

flop
Invert rows and colums in a two dimensional Array (turn inside out).
See also: Function, SequenceableCollection.

[[1, 2, 3], [4, 5, 6]].flop;
[[1, 2, 3], [4, 5, 6], [7, 8]].flop; // shorter array wraps
[].flop; // result is always 2-d.

multiChannelExpand
Used by UGens to perform multi channel expansion. Same as flop.

source
Some UGens return Arrays of OutputProxy when instantiated. This method allows you to
get at the source UGen.

(
z = Pan2.ar;
z.postln;
z.source.postln;
)

fork(join, clock, quant, stackSize)
Used within Routines and assumes an array of functions, from which subroutines are created. The subroutines are played while the outer Routine carries on. The join parameter expresses after how many subroutines complete the outer Routine is allowed to go on. By default this happens after all subroutines have completed.


// an array of routine functions:
(
a = [
	{ 1.wait; \done_one.postln },
	{ 0.5.wait; \done_two.postln },
	{ 0.2.wait; \done_three.postln }
];
)

// join after 0
(
Routine { 
	"join = 0.".postcln;
	a.fork(0); \doneAll.postln;
}.play;
)
// join after 1
(
Routine { 
	"join = 1.".postcln;
	a.fork(1); \doneAll.postln;
}.play;
)
// join after all
(
Routine { 
	"join = a.size (default).".postcln;
	a.fork; \doneAll.postln;
}.play;
)

poll(trig, label, trigid)
apply an array of Poll units to an array of UGens (see those helpfiles for more details).

s.boot;
(
x = {
	SinOsc.ar([0.1, 0.2], 0).poll * 0.1
}.play;
)
x.trace; // By tracing the Synth you can see the two Poll units we created
x.free

dpoll(trig, label, trigid)
apply an array of Dpoll units to an array of UGens (see those helpfiles for more details).

atIdentityHash(argKey)
This method is used by IdentitySet to search for a key among its members.

atIdentityHashInPairs(argKey)
This method is used by IdentityDictionary to search for a key among its members.

asShortString
Returns a short string representing the Array that only shows how many elements it contains

asString
Returns a string representing the Array. May not be compileable due to ellision (...) of excessive arguments. 

asCompileString
Returns a string that will compile to return an Array equal to the receiver.

isValidUGenInput
Returns true. Arrays are valid UGen inputs.


asRawOSC
Returns the OSC measse as an Int8Array. Receiver must be a bundle.

[0.1, [\s_new, \default, -1, 1, 1, \freq, 1961]].asRawOSC;



