List					list of items of variable size

Inherits from: Object : Collection : SequenceableCollection

List is a subclass of SequenceableCollection with unlimited growth in size. Although not a subclass of Array or its superclass ArrayedCollection it uses an Array in its implementation and is in many cases interchangeable with one. (List implements many of the same methods as Array.)

Arrays have a fixed maximum size. If you add beyond that size a new Array is created and returned, but you must use an assignment statement or the new array will be lost. (See the Array helpfile.) List has no size limitation and is thus more flexible, but has slightly more overhead.

(
x = Array.new(3); 
y = List.new(3); 
5.do({ arg i; z = x.add(i); y.add(i); }); 
x.postln; z.postln; y.postln;
)

Many of List's methods are inherited from SequenceableCollection or Collection and are documented in those helpfiles.


Class Methods

*new(size)
Creates a List with the initial capacity given by size.

*newClear(size)
Creates a List with the initial capacity given by size and slots filled with nil.

*copyInstance(aList)
Creates a List by copying aList's array variable.

*newUsing(anArray)
Creates a List using anArray.



Instance Methods

asArray
Returns a new Array based upon this List.

array
Returns the List's Array, allowing it to be manipulated directly. This should only be necessary for exotic manipulations not implemented in List or its superclasses.

(
x = List[1, 2, 3];
x.array.add("foo");
x.postln;
)

array_(anArray)
Sets the List's Array.

at(index)
Return the item at index.

List[ 1, 2, 3 ].at(0).postln;
		
clipAt(index)
Same as at, but values for index greater than the size of the List will be clipped to the last index.

y = List[ 1, 2, 3 ];
y.clipAt(13).postln;
 
wrapAt(index)
Same as at, but values for index greater than the size of the List will be wrapped around to 0.

y = List[ 1, 2, 3 ];
y.wrapAt(3).postln; // this returns the value at index 0
y.wrapAt(4).postln; // this returns the value at index 1

foldAt(index)
Same as at, but values for index greater than the size of the List will be folded back.

y = List[ 1, 2, 3 ];
y.foldAt(3).postln; // this returns the value at index 1
y.foldAt(4).postln; // this returns the value at index 0
y.foldAt(5).postln; // this returns the value at index 1

put(index, item)
Put item at index, replacing what is there.

clipPut(index, item)
Same as put, but values for index greater than the size of the List will be clipped to the last index.
 
wrapPut(index, item)
Same as put, but values for index greater than the size of the List will be wrapped around to 0.

foldPut(index)
Same as put, but values for index greater than the size of the List will be folded back.

add(item)
Adds an item to the end of the List.

addFirst(item)
Inserts the item at the beginning of the List.

insert(index, item)
Inserts the item into the contents of the List at the indicated index.

pop
Remove and return the last element of the List.

grow(sizeIncrease)
Increase the size of the List by sizeIncrease number of slots.

removeAt(index)
Remove and return the element at index, shrinking the size of the List.

y = List[ 1, 2, 3 ]; 
y.removeAt(1); 
y.postln;

fill(value)
Inserts the item into the contents of the receiver, possibly returning a new collection. Note the difference between this and Collection's *fill.

(
var z;
z = List[1, 2, 3, 4];
z.fill(4).postln;
z.fill([1,2,3,4]).postln;
)

do(function)
Iterate over the elements in order, calling the function for each element. The function is passed two arguments, the element and an index.

List['a', 'b', 'c'].do({ arg item, i; [i, item].postln; });

reverseDo(function)
Iterate over the elements in reverse order, calling the function for each element. The function is passed two arguments, the element and an index.

List['a', 'b', 'c'].reverseDo({ arg item, i; [i, item].postln; });

pairsDo(function)
Calls function for each subsequent pair of elements in the SequentialCollection.
The function is passed the two elements and an index.

List[1, 2, 3, 4, 5, 6].pairsDo({ arg a, b; [a, b].postln; });

copyRange(start, end)
Return a new List which is a copy of the indexed slots of the receiver from start to end.

(
var y, z;
z = List[1, 2, 3, 4, 5];
y = z.copyRange(1,3);
z.postln;
y.postln;
)

copySeries(first, second, last)
Return a new List consisting of the values starting at first, then every step of the distance between first and second, up until last.

(
var y, z;
z = List[1, 2, 3, 4, 5, 6];
y = z.copySeries(0, 2, 5);
y.postln;
)

putSeries(first, second, last, value)
Put value at every index starting at first, then every step of the distance between first and second, up until last.

(
var y, z;
z = List[1, 2, 3, 4, 5, 6];
y = z.putSeries(0, 2, 5, "foo");
y.postln;
)

reverse
Return a new List whose elements are reversed.

(
var y, z;
z = List[1, 2, 3, 4];
y = z.reverse;
z.postln;
y.postln;
)

scramble
Returns a new List whose elements have been scrambled. The receiver is unchanged.

List[1, 2, 3, 4, 5, 6].scramble.postln;

mirror
Return a new List which is the receiver made into a palindrome. 
The receiver is unchanged.

List[1, 2, 3, 4].mirror.postln;

mirror1
Return a new List which is the receiver made into a palindrome with the last element removed. 
This is useful if the list will be repeated cyclically, the first element will not get played twice.
The receiver is unchanged.

List[1, 2, 3, 4].mirror1.postln;

mirror2
Return a new List which is the receiver concatenated with a reversal of itself. The center element is duplicated. The receiver is unchanged.

List[1, 2, 3, 4].mirror2.postln;

stutter(n)
Return a new List whose elements are repeated n times. The receiver is unchanged.

List[1, 2, 3].stutter(2).postln;

rotate(n)
Return a new List whose elements are in rotated order. Negative n values rotate left, postive n values rotate right. The receiver is unchanged.

List[1, 2, 3, 4, 5].rotate(1).postln;

List[1, 2, 3, 4, 5].rotate(-1).postln;

List[1, 2, 3, 4, 5].rotate(3).postln;

pyramid
Return a new List whose elements have been reordered via one of 10 "counting" algorithms.
The algorithms are numbered 1 through 10. Run the examples to see the algorithms.

List[1, 2, 3, 4].pyramid(1).postln;

(
10.do({ arg i;
	List[1, 2, 3, 4].pyramid(i + 1).postcs;
});
)

lace(length)
Returns a new List whose elements are interlaced sequences of the elements of the receiver's subcollections, up to size length. The receiver is unchanged.

(
x = List[ [1, 2, 3], 6, List["foo", 'bar']];
y = x.lace(12);
x.postln;
y.postln;
)

permute(nthPermutation)
Returns a new List whose elements are the nthPermutation of the elements of the receiver. The receiver is unchanged.

(
x = List[ 1, 2, 3];
6.do({|i| x.permute(i).postln;});
)

wrapExtend(length)
Returns a new List whose elements are repeated sequences of the receiver, up to size length. The receiver is unchanged.

(
x = List[ 1, 2, 3, "foo", 'bar' ];
y = x.wrapExtend(9);
x.postln;
y.postln;
)

foldExtend(length)
Same as lace but the sequences fold back on the list elements.

(
x = List[ 1, 2, "foo"];
y = x.foldExtend(9);
x.postln;
y.postln;
)

slide(windowLength, stepSize)
Return a new List whose elements are repeated subsequences from the receiver. 
Easier to demonstrate than explain.

List[1, 2, 3, 4, 5, 6].slide(3, 1).postcs;

List[1, 2, 3, 4, 5, 6].slide(3, 2).postcs;

List[1, 2, 3, 4, 5, 6].slide(4, 1).postcs;

dump
Dump the List's Array.

clear
Replace the List's Array with a new empty one.


