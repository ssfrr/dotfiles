ArrayedCollection

Inherits from: Object : Collection : SequenceableCollection

ArrayedCollection is an abstract class, a subclass of SequenceableCollections whose elements are held in a vector of slots. Instances of ArrayedCollection have a fixed maximum size beyond which they may not grow.

Its principal subclasses are Array (for holding objects), and RawArray, from which Int8Array, FloatArray, Signal etc. inherit.


Class Methods

*with(... args)
Create a new ArrayedCollection whose slots are filled with the given arguments.

Array.with(7, 'eight',  9).postln;

*series(size, start, step)
Fill an ArrayedCollection with an arithmetic series.

Array.series(5, 10, 2).postln;

*geom(size, start, grow)
Fill an ArrayedCollection with a geometric series.

Array.geom(5, 1, 3).postln;

*iota(...sizes)
Fills an ArrayedCollection with a counter. See J_concepts_in_SC for more examples.

Array.iota(2, 3);
Array.iota(2, 3, 4);

*fill2D(rows, cols, function)
Creates a 2 dimensional ArrayedCollection of the given sizes. The items are determined by evaluation of the supplied function. The function is passed row and column indexes as arguments. See J_concepts_in_SC

Array.fill2D(2, 4, 0);
Array.fill2D(3, 4, { arg r, c; r*c+c; });

*fill3D(planes, rows, cols, function)
Creates a 3 dimensional ArrayedCollection of the given sizes. The items are determined by evaluation of the supplied function. The function is passed plane, row and column indexes as arguments. See J_concepts_in_SC

Array.fill3D(2, 3, 4, { arg p, r, c; p; });

*fillND(dimensions, function)
Creates a N dimensional ArrayedCollection where N is the size of the array dimensions. The items are determined by evaluation of the supplied function. The function is passed N number of indexes as arguments.

Array.fillND([4, 4], { arg a, b; a+b; });				//2d
Array.fillND([4, 4, 4], { arg a, b, c; a+b*c; });		//3d
Array.fillND([1, 2, 3, 4], { arg a, b, c, d; b+d; });	//4d


Instance Methods

size
Return the number of elements the ArrayedCollection.

maxSize
Return the maximum number of elements the ArrayedCollection can hold. For example, Arrays may initialise themselves with a larger capacity than the number of elements added.

[4, 5, 6].maxSize; // gosh
		
at(index)
Return the item at index.
		
clipAt(index)
Same as at, but values for index greater than the size of the ArrayedCollection will be clipped to the last index.

y = [ 1, 2, 3 ];
y.clipAt(13).postln;
 
wrapAt(index)
Same as at, but values for index greater than the size of the ArrayedCollection will be wrapped around to 0.

y = [ 1, 2, 3 ];
y.wrapAt(3).postln; // this returns the value at index 0
y.wrapAt(4).postln; // this returns the value at index 1

foldAt(index)
Same as at, but values for index greater than the size of the ArrayedCollection will be folded back.

y = [ 1, 2, 3 ];
y.foldAt(3).postln; // this returns the value at index 1
y.foldAt(4).postln; // this returns the value at index 0
y.foldAt(5).postln; // this returns the value at index 1

plot
Plot data in a GUI window. See plot for more details.

swap(i, j)
Swap the values at indices i and j.

[ 1, 2, 3 ].swap(0, 2).postln;

put(index, item)
Put item at index, replacing what is there.

clipPut(index, item)
Same as put, but values for index greater than the size of the ArrayedCollection will be clipped to the last index.
 
wrapPut(index, item)
Same as put, but values for index greater than the size of the ArrayedCollection will be wrapped around to 0.

foldPut(index)
Same as put, but values for index greater than the size of the ArrayedCollection will be folded back.

putEach(keys, values)
Put the values in the corresponding indices given by keys. If one of the two argument arrays is longer then it will wrap.

y = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
y.putEach([4, 7], [\smelly, \head])
y.putEach([2, 3, 5, 6], \wotsits);

indexOf(item)
Return the first index containing an item which matches item.

y = [ \the, \symbol, \collection, \contains, \my, \symbol ]; 
y.indexOf(\symbol); 

includes(item)
Return a boolean indicating whether the collection contains anything matching item.

y = [ \the, \symbol, \collection, \contains, \my, \symbol ]; 
y.includes(\symbol); 
y.includes(\solipsism); 

indexOfGreaterThan(item)
Return the first index containing an item which is greater than item.

y = List[ 10, 5, 77, 55, 12, 123]; 
y.indexOfGreaterThan(70); 

removeAt(index)
Remove and return the element at index, shrinking the size of the ArrayedCollection.

y = [ 1, 2, 3 ]; 
y.removeAt(1); 
y.postln;

takeAt(index)
Similar to removeAt, but does not maintain the order of the items following the one that was removed. Instead, the last item is placed into the position of the removed item and the array's size decreases by one.

y = [ 1, 2, 3, 4, 5 ]; 
y.takeAt(1); 
y.postln;

takeThese(function)
Removes all items in the receiver for which the function answers true. The function is passed two arguments, the item and an integer index. Note that order is not preserved. See takeAt.

y = [ 1, 2, 3, 4 ];
y.takeThese({ arg item, index; item.odd; });	//remove odd items
y.postln;

add(item)
Adds an item to an ArrayedCollection if there is space. If there is not any space left in the object then this method returns a new ArrayedCollection. For this reason, you should always assign the result of add to a variable - never depend on add changing the receiver.

(
// z and y are the same object
var y, z;
z = [1, 2, 3];
y = z.add(4);
z.postln;
y.postln;
)

(
// in this case a new object is returned
var y, z;
z = [1, 2, 3, 4];
y = z.add(5);
z.postln;
y.postln;
)

addAll(aCollection)
Adds all the elements of aCollection to the contents of the receiver, possibly returning a new collection.

(
// in this case a new object is returned
var y, z;
z = [1, 2, 3, 4];
y = z.addAll([7, 8, 9]);
z.postln;
y.postln;
)

extend(size, item)
Extends the receiver to match size by adding a number of items. If size is less than receiver size then truncate.

(
var y, z;
z = [1, 2, 3, 4];
y = z.extend(10, 9);		//fill up with 9 until the size equals 10
z.postln;
y.postln;
)

fill(value)
Inserts the item into the contents of the receiver, possibly returning a new collection. Note the difference between this and Collection's *fill.

(
var z;
z = List[1, 2, 3, 4];
z.fill(4).postln;
z.fill([1,2,3,4]).postln;
)

insert(index, item)
Inserts the item into the contents of the receiver, possibly returning a new collection.

(
// in this case a new object is returned
var y, z;
z = [1, 2, 3, 4];
y = z.insert(1, 999);
z.postln;
y.postln;
)

addFirst(item)
Inserts the item before the contents of the receiver, possibly returning a new collection.

(
// in this case a new object is returned
var y, z;
z = [1, 2, 3, 4];
y = z.addFirst(999);
z.postln;
y.postln;
)

pop
Remove and return the last element of the ArrayedCollection.

(
var z;
z = [1, 2, 3, 4];
z.pop.postln;
z.postln;
)

grow(sizeIncrease)
Increase the size of the ArrayedCollection by sizeIncrease number of slots,  possibly returning a new collection.

growClear(sizeIncrease)
Increase the size of the ArrayedCollection by sizeIncrease number of slots,  returning a new collection with nils in the added slots.

// Compare:
[4,5,6].grow(5)
[4,5,6].growClear(5)

copyRange(start, end)
Return a new ArrayedCollection which is a copy of the indexed slots of the receiver from start to end.
x.copyRange(a, b) can also be written as x[a..b]

(
var y, z;
z = [1, 2, 3, 4, 5];
y = z.copyRange(1,3);
z.postln;
y.postln;
)

copySeries(first, second, last)
Return a new ArrayedCollection consisting of the values starting at first, then every step of the distance between first and second, up until last.
x.copySeries(a, b, c) can also be written as x[a, b..c]

(
var y, z;
z = [1, 2, 3, 4, 5, 6];
y = z.copySeries(0, 2, 5);
y.postln;
)

seriesFill(start, step)
Fill the receiver with an arithmetic progression. The first element will be start, the second start + step, the third start + step + step ...

(
var y;
y = Array.newClear(15);
y.seriesFill(5, 3);
y.postln;
)

putSeries(first, second, last, value)
Put value at every index starting at first, then every step of the distance between first and second, up until last.
x.putSeries(a, b, c, val) can also be written as x[a, b..c] = val

(
var y, z;
z = [1, 2, 3, 4, 5, 6];
y = z.putSeries(0, 2, 5, "foo");
y.postln;
)

++ aCollection
Concatenate the contents of the two collections into a new ArrayedCollection.

(
var y, z;
z = [1, 2, 3, 4];
y = z ++ [7, 8, 9];
z.postln;
y.postln;
)

reverse
Return a new ArrayedCollection whose elements are reversed.

(
var y, z;
z = [1, 2, 3, 4];
y = z.reverse;
z.postln;
y.postln;
)

do(function)
Iterate over the elements in order, calling the function for each element. The function is passed two arguments, the element and an index.

['a', 'b', 'c'].do({ arg item, i; [i, item].postln; });

reverseDo(function)
Iterate over the elements in reverse order, calling the function for each element. The function is passed two arguments, the element and an index.

['a', 'b', 'c'].reverseDo({ arg item, i; [i, item].postln; });

collect(function)
Answer a new collection which consists of the results of function evaluated for each item in the collection. The function is passed two arguments, the item and an integer index. See Collection helpfile for examples.

deepCollect(depth, function)
The same as collect, but can look inside sub-arrays up to the specified depth.

a = [99, [4,6,5], [[32]]];
a.deepCollect(1, {|item| item.isArray}).postln;
a.deepCollect(2, {|item| item.isArray}).postln;
a.deepCollect(3, {|item| item.isArray}).postln;

windex
Interprets the array as a list of probabilities which should sum to 1.0 and returns a random index value based on those probabilities.

(
Array.fill(10, {
	[0.1, 0.6, 0.3].windex;
}).postln;
)

normalizeSum
Returns the Array resulting from : 

(this / this.sum)

so that the array will sum to 1.0.

This is useful for using with windex or wchoose.

[1, 2, 3].normalizeSum.postln;

normalize(min, max)
Returns a new Array with the receiver items normalized between min and max.

[1, 2, 3].normalize;			//default min=0, max= 1
[1, 2, 3].normalize(-20, 10);

perfectShuffle
Returns a copy of the receiver with its items split into two equal halves, then reconstructed by interleaving the two halves. Note: use an even number of item pairs in order to not loose any items in the shuffle.

(
var y, z;
z = [ 1, 2, 3, 4, 5, 6 ];
y = z.perfectShuffle;
z.postln;
y.postln;
)

performInPlace(selector, from, to, argList)
performs a method in place, within a certain region [from..to], returning the same array.

a = (0..10);
a.performInPlace(\normalizeSum, 3, 6); 

rank
Rank is the number of dimensions in a multidimensional array.

a = [4,7,6,8];
a.rank;
a = [[4,7],[6,8]];
a.rank;

shape
For a multidimensional array, returns the number of elements along each dimension.

a = [4,7,6,8];
a.shape;
a = [[4,7],[6,8]];
a.shape;

reshape( ... shape)
For a multidimensional array, rearranges the data using the desired number of elements along each dimension. The data may be extended using wrapExtend if needed.

a = [4,7,6,8];
a.reshape(2,2);
a.reshape(2,3);

find(anotherArray)
finds the starting index of a number of elements contained in the array.

a = (0..10);
a.find([4, 5, 6]); 

replace(anotherArray)
return a new array in which a number of elements have been replaced by another 

a = (0..10) ++ (0..10);
a.replace([4, 5, 6], 100); 
a.replace([4, 5, 6], [1734, 1985, 1860]);

this method is inherited by String:

a = "hello world";
a.replace("world", "word");

asRandomTable
return an integral table that can be used to generate random numbers with a specified distribution.
(see [Randomness] helpfile for a more detailed example)

(
a = (0..100) ++ (100..50) / 100; // distribution
a = a.asRandomTable;
)

tableRand
returns a new random number from a random table.

(
a = (0..100) ++ (100..50) / 100; // distribution
a = a.asRandomTable;
20.do { a.tableRand.postln };
)

msgSize
return the size of an osc message in bytes

a = ["/s_new", "default", -1, "freq", 440];
a.msgSize;

bundleSize
return the size of an osc bundle in bytes

a = [["/s_new", "default", -1, "freq", 440], ["/s_new", "default", -1, "freq", 220]];
a.bundleSize;

asciiPlot
For an ArrayedCollection containing numbers (e.g. audio data) this renders a plot in the post window using asterisks and spaces (works best if you use a monospace font in your post window).

a = (0, pi/10 .. 5pi).collect{|val| val.sin}
a.asciiPlot;



