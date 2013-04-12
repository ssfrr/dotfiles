SequenceableCollection			integer indexable collection

Inherits from: Object : Collection

SequenceableCollection is a subclass of Collection whose elements can be indexed by an Integer. It has many useful subclasses; Array and List are amongst the most commonly used.


Class Methods

	*series(size, start, step)
	Fill a SequenceableCollection with an arithmetic series.

	Array.series(5, 10, 2);

	*geom(size, start, grow)
	Fill a SequenceableCollection with a geometric series.

	Array.geom(5, 1, 3);
	
	*fib(size, a, b)
	Fill a SequenceableCollection with a fibonacci series. 
	b is the starting value (default: 1), a is the starting step value (default: 0)
	
	Array.fib(5);
	Array.fib(5, 2, 32); // start from 32 with step 2.
	
	*rand(size, minVal, maxVal)
	Fill a SequenceableCollection with random values in the range minVal to maxVal.
	
	Array.rand(8, 1, 100);
	
	*rand2(size, val)
	Fill a SequenceableCollection with random values in the range -val to +val.
	
	Array.rand2(8, 100);
	
	*linrand(size, minVal, maxVal)
	Fill a SequenceableCollection with random values in the range minVal to maxVal with a linear distribution.
	
	Array.linrand(8, 1, 100);
	
	*exprand(size, minVal, maxVal)
	Fill a SequenceableCollection with random values in the range minVal to maxVal with exponential
	distribution.
	
	Array.exprand(8, 1, 100);
	
	*interpolation(size, start, end)
	Fill a SequenceableCollection with the interpolated values between the start and end values.
	
	Array.interpolation(5, 3.2, 20.5);
	
	
Instance Methods
	
	first
	Return the first element of the collection.
	
	[3, 4, 5].first;
	
	last
	Return the last element of the collection.
	
	[3, 4, 5].last;
	
	putFirst(item)
	putLast(item)
	Place item at the first / last index in the collection. Note that if the collection is empty (and therefore has no indexed slots) the item will not be added.
	
	[3, 4, 5].putFirst(100);
	[3, 4, 5].putLast(100);
	
	indexOf(item)
		Return the index of an item in the collection, or nil if not found.
		
		[3, 4, 100, 5].indexOf(100);
		[3, 4, \foo, \bar].indexOf(\foo);
		
	indexOfEqual(item)
		Return the index of something in the collection that equals the item, or nil if not found.
		
		[3, 4, "foo", "bar"].indexOfEqual("foo");
	
	indicesOfEqual(item)
		Return an array of indices of things in the collection that equal the item, or nil if not found.
	
		y = [7, 8, 7, 6, 5, 6, 7, 6, 7, 8, 9]
		y.indicesOfEqual(7);
		y.indicesOfEqual(5);
	
	indexOfGreaterThan(item)
		Return the first index containing an item which is greater than item.
	
		y = List[ 10, 5, 77, 55, 12, 123]; 
		y.indexOfGreaterThan(70); 
	
	find(sublist, offset)
		If the sublist exists in the receiver (in the specified order), at an offset greater than or equal to the initial offset, then return the starting index.
	
		y = [7, 8, 7, 6, 5, 6, 7, 6, 7, 8, 9]
		y.find([7, 6, 5]);
	
	findAll(arr, offset)
		Similar to find() but returns an array of all the indices at which the sequence is found.
	
		y = [7, 8, 7, 6, 5, 6, 7, 6, 7, 8, 9]
		y.findAll([7, 6]);
	
	indexIn(val)
		returns the closest index of the value in the collection (collection must be sorted)
		
		[2, 3, 5, 6].indexIn(5.2)
		
	indexInBetween(val)
		returns a linearly interpolated float index for the value (collection must be sorted)
		inverse operation is blendAt
		
		x = [2, 3, 5, 6].indexInBetween(5.2)
		[2, 3, 5, 6].blendAt(x)
	
	
	blendAt(floatIndex)
		returns a linearly interpolated value between the two closest indices
		inverse operation is indexInBetween
		x = [2, 5, 6].blendAt(0.4)
	
	
	copyRange(start, end)
	Return a new SequenceableCollection which is a copy of the indexed slots of the receiver from start to end.
	x.copyRange(a, b) can also be written as x[a..b]
	
	(
	var y, z;
	z = [1, 2, 3, 4, 5];
	y = z.copyRange(1, 3);
	z.postln;
	y.postln;
	)
	
	copyToEnd(start)
	Return a new SequenceableCollection which is a copy of the indexed slots of the receiver from start to the end of the collection. x.copyToEnd(a) can also be written as x[a..]
	
	copyFromStart(end)
	Return a new SequenceableCollection which is a copy of the indexed slots of the receiver from the start of the collection to end. x.copyFromStart(a) can also be written as x[..a]
	
	remove(item)
	Remove item from collection.
	
	take(item)
	Remove and return item from collection. The last item in the collection will move to occupy the vacated slot (and the collection size decreases by one). See also takeAt, defined for ArrayedCollection.
	
	a = [11, 12, 13, 14, 15];
	a.take(12);
	a
	
	keep(n)
	Keep the first n items of the array. If n is negative, keep the last –n items.
	
	a = [1, 2, 3, 4, 5];
	a.keep(3);
	a.keep(-3);
	
	drop(n)
	Drop the first n items of the array. If n is negative, drop the last –n items.
	
	a = [1, 2, 3, 4, 5];
	a.drop(3);
	a.drop(-3);
	
	join(joiner)
	Returns a String formed by connecting all the elements of the receiver, with joiner imbetween.
	
	["m", "ss", "ss", "pp", ""].join("i")
	
	flat
	Returns a collection from which all nesting has been flattened.
	
	[[1, 2, 3], [[4, 5], [[6]]]].flat;
	
	flatten(numLevels)
	Returns a collection from which numLevels of nesting has been flattened.
	
	[[1, 2, 3], [[4, 5], [[6]]]].flatten(1).postcs;
	
	[[1, 2, 3], [[4, 5], [[6]]]].flatten(2).postcs;
	
	flop
	Invert rows and colums in a two dimensional Collection (turn inside out).
	See also: Function.
	
	[[1, 2, 3], [4, 5, 6]].flop;
	[[1, 2, 3], [4, 5, 6], [7, 8]].flop; // shorter array wraps
	[].flop; // result is always 2-d.
	
	flopTogether(...moreArrays)
	Invert rows and colums in a an array of dimensional Collections (turn inside out), so that they 
	all match up in size, but remain separated.
	
	
	(
	a = flopTogether(
		[[1, 2, 3], [4, 5, 6, 7, 8]] * 100,
		[[1, 2, 3], [4, 5, 6], [7, 8]],
		[1000]
	)
	);
	
	a.collect(_.size); // sizes are the same
	a.collect(_.shape) // shapes can be different
	
	
	lace(length)
	Returns a new Collection whose elements are interlaced sequences of the elements of the receiver's subcollections, up to size length. The receiver is unchanged.
	
	(
	x = [ [1, 2, 3], 6, List["foo", 'bar']];
	y = x.lace(12);
	x.postln;
	y.postln;
	)
	
	resamp0(newSize)
	Returns a new Collection of the desired length, with values resampled evenly-spaced from the receiver without interpolation.
	
	[1, 2, 3, 4].resamp0(12);
	[1, 2, 3, 4].resamp0(2);
	
	resamp1(newSize)
	Returns a new Collection of the desired length, with values resampled evenly-spaced from the receiver with linear interpolation.
	
	[1, 2, 3, 4].resamp1(12);
	[1, 2, 3, 4].resamp1(3);
	
	choose
	Choose an element from the collection at random.
	
	[1, 2, 3, 4].choose;
	
	wchoose
	Choose an element from the collection at random using a list of probabilities or weights.
	The weights must sum to 1.0.
	
	[1, 2, 3, 4].wchoose([0.1, 0.2, 0.3, 0.4]);
	
	sort(function)
	Sort the contents of the collection using the comparison function argument.
	The function should take two elements as arguments and return true if the first
	argument should be sorted before the second argument.
	If the function is nil, the following default function is used.
	
	{ arg a, b; a < b }
	
	
	[6, 2, 1, 7, 5].sort;
	
	[6, 2, 1, 7, 5].sort({ arg a, b; a > b }); // reverse sort
	
	
	sortBy(key)
	Sort the contents of the collection using the key key, which is assumed to be found inside each element of the receiver.
	
	(
	a = [
		Dictionary[\a->5, \b->1, \c->62], 
		Dictionary[\a->2, \b->9, \c->65], 
		Dictionary[\a->8, \b->5, \c->68], 
		Dictionary[\a->1, \b->3, \c->61], 
		Dictionary[\a->6, \b->7, \c->63], 
	]
	)
	a.sortBy(\b);
	a.sortBy(\c);
	
	
	order(function)
	Return an array of indices that would sort the collection into order. function is treated the same way as for the sort method.
	
	
	[6, 2, 1, 7, 5].order;
	
	
	swap(i, j)
	Swap two elements in the collection at indices i and j.
	
	pairsDo(function)
	Calls function for each subsequent pair of elements in the SequentialCollection.
	The function is passed the two elements and an index.
	
	[1, 2, 3, 4, 5].pairsDo({ arg a, b; [a, b].postln; });
	
	doAdjacentPairs(function)
	Calls function for every adjacent pair of elements in the SequentialCollection.
	The function is passed the two adjacent elements and an index.
	
	[1, 2, 3, 4, 5].doAdjacentPairs({ arg a, b; [a, b].postln; });
	
	separate(function)
	Separates the collection into sub-collections by calling the function for each adjacent pair of elements.
	If the function returns true, then a separation is made between the elements.
	
	 [1, 2, 3, 5, 6, 8, 10].separate({ arg a, b; (b - a) > 1 }).postcs;
	
	clump(groupSize)
	Separates the collection into sub-collections by separating every groupSize elements.
	
	[1, 2, 3, 4, 5, 6, 7, 8].clump(3).postcs;
	
	clumps(groupSizeList)
	Separates the collection into sub-collections by separating elements into groupings whose size
	is given by integers in the groupSizeList.
	
	[1, 2, 3, 4, 5, 6, 7, 8].clumps([1, 2]).postcs;
	
	curdle(probability)
	Separates the collection into sub-collections by separating elements according to the
	given probability.
	
	[1, 2, 3, 4, 5, 6, 7, 8].curdle(0.3).postcs;
	
	integrate
	Returns a collection with the incremental sums of all elements
	
	[3, 4, 1, 1].integrate;
	
	differentiate
	Returns a collection with the pairwise difference between all elements
	
	[3, 4, 1, 1].differentiate;
	
	reduce(operator)
	Applies the method named by operator to the first and second elements of the collection - then applies the method to the result and to the third element of the collection - then applies the method to the result and to the fourth element of the collection - and so on, until the end of the array. operator may be a Function or a Symbol.
	
	[3, 4, 5, 6].reduce('*'); // this is the same as [3, 4, 5, 6].product
	[3, 4, 5, 6].reduce(\lcm); // Lowest common multiple of the whole set of numbers
	["d", "e", (0..9), "h"].reduce('++'); // concatenation
	[3, 4, 5, 6].reduce({ |a, b| sin(a) * sin(b) }); // product of sines
	
	
	convertDigits(base)
	Returns an integer resulting from interpreting the elements as digits to a given base (default 10).
	See also asDigits in Integer for the complementary method.
	
	[1, 0, 0, 0].convertDigits;
	[1, 0, 0, 0].convertDigits(2);
	[1, 0, 0, 0].convertDigits(3);
	
	hammingDistance(that)
	Returns the count of array elements that are not equal in identical positions. http://en.wikipedia.org/wiki/Hamming_distance
	
	The collections are not wrapped - if one array is shorter than the other, the difference in size should be included in the count.
	
	[0, 0, 0, 1, 1, 1, 0, 1, 0, 0].hammingDistance([0, 0, 1, 1, 0, 0, 0, 0, 1, 1])
	"SuperMan".hammingDistance("SuperCollider");
	


Math Support

Unary Messages:

All of the following messages send the message performUnaryOp to the receiver with the
unary message selector as an argument.

neg, reciprocal, bitNot, abs, asFloat, asInt, ceil, floor, frac, sign, squared, cubed, sqrt
exp, midicps, cpsmidi, midiratio, ratiomidi, ampdb, dbamp, octcps, cpsoct, log, log2, 
log10, sin, cos, tan, asin, acos, atan, sinh, cosh, tanh, rand, rand2, linrand, bilinrand, 
sum3rand, distort, softclip, nyqring, coin, even, odd, isPositive, isNegative, 
isStrictlyPositive, real, imag, magnitude, magnitudeApx, phase, angle, rho, theta, 
asFloat, asInteger

performUnaryOp(aSelector)
	Creates a new collection of the results of applying the selector to all elements in the receiver.

	[1, 2, 3, 4].neg;

	[1, 2, 3, 4].reciprocal;

Binary Messages:

All of the following messages send the message performBinaryOp to the receiver with the
binary message selector and the second operand as arguments.

+, -, *, /, div, %, **, min, max, <, <=, >, >=, &, |, bitXor, lcm, gcd, round, trunc, atan2, 
hypot, >>, +>>, fill, ring1, ring2, ring3, ring4, difsqr, sumsqr, sqrdif, absdif, amclip, 
scaleneg, clip2, excess, <!, rrand, exprand

performBinaryOp(aSelector, theOperand)
	Creates a new collection of the results of applying the selector with the operand to all elements in the receiver. If the operand is a collection then elements of that collection are paired with elements of the receiver.

	([1, 2, 3, 4] * 10);

	([1, 2, 3, 4] * [4, 5, 6, 7]);




