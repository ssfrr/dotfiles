// The J programming language is a successor of APL. <http://www.jsoftware.com>
// These languages are made for processing arrays of data and are able to express
// complex notions of iteration implicitly.
// The following are some concepts borrowed from or inspired by J.
// Thinking about multidimensional arrays can be both mind bending and mind expanding.
// It may take some effort to grasp what is happening in these examples.

// iota fills an array with a counter
z = Array.iota(2, 3, 3);
z.rank; // 3 dimensions
z.shape; // gives the sizes of the dimensions
z = z.reshape(3, 2, 3); // reshape changes the dimensions of an array
z.rank; // 3 dimensions
z.shape;

// fill a 2D array
Array.fill2D(3,3,{1.0.rand.round(0.01)});

Array.fill2D(2,3,{|i,j| i@j});

// fill a 3D array
Array.fill3D(2,2,2,{1.0.rand.round(0.01)});

Array.fill3D(2,2,2,{|i,j,k| `[i,j,k]});


// using dup to create arrays
(1..4) dup: 3;
100.rand dup: 10;
{100.rand} dup: 10;
{100.rand} dup: 3 dup: 4;
{{100.rand} dup: 3} dup: 4;
{|i| i.squared} dup: 10;
{|i| i.nthPrime} dup: 10;

// ! is an abbreviation of dup
(1..4) ! 3;
100.rand ! 10;
{100.rand} ! 10;
{100.rand} ! 3 ! 4;
{{100.rand} ! 3} ! 4;
{|i| i.squared} ! 10;
{|i| i.nthPrime} ! 10;

// other ways to do the same thing:
	// partial application
_.squared ! 10;
_.nthPrime ! 10;

	// operating on a list
(0..9).squared;
(0..9).nthPrime;

// operator adverbs
// Adverbs are a third argument passed to binary operators that modifies how they iterate over
// SequenceableCollections or Streams.
// see the Adverbs help file
[10, 20, 30, 40, 50] + [1, 2, 3]; // normal
[10, 20, 30, 40, 50] +.f [1, 2, 3]; // folded
[10, 20, 30, 40, 50] +.s [1, 2, 3]; // shorter
[10, 20, 30, 40, 50] +.x [1, 2, 3]; // cross
[10, 20, 30, 40, 50] +.t [1, 2, 3]; // table

// operator depth.
// J has a concept called verb rank, which is probably too complex to understand and implement 
// in SC, but operator depth is similar and simpler.
// A binary operator can be given a depth at which to operate
// negative depths iterate the opposite operand.
// These are better understood by example.
// It is not currently possible to combine adverb and depth.
z = Array.iota(3,3);
y = [100, 200, 300];
z + y;
z +.0 y; // same as the above. y added to each row of z
z +.1 y; // y added to each column of z
z +.2 y; // y added to each element of z
z +.-1 y; // z added to each element of y

// deepCollect operates a function at different dimensions or depths in an array.
z = Array.iota(3, 2, 3);
f = {|item| item.reverse };
z.deepCollect(0, f);
z.deepCollect(1, f);
z.deepCollect(2, f);

f = {|item| item.stutter };
z.deepCollect(0, f);
z.deepCollect(1, f);
z.deepCollect(2, f);

// slice can get sections of multidimensional arrays.
// nil gets all the indices of a dimension
z = Array.iota(4,5);
z.slice(nil, (1..3));
z.slice(2, (1..3));
z.slice((2..3), (0..2));
z.slice((1..3), 3);
z.slice(2, 3);

z = Array.iota(3,3,3);
z.slice([0,1],[1,2],[0,2]);
z.slice(nil,nil,[0,2]);
z.slice(1);
z.slice(nil,1);
z.slice(nil,nil,1);
z.slice(nil,2,1);
z.slice(nil,1,(1..2));
z.slice(1,[0,1]);
z.flop;

// sorting order

z = {100.rand}.dup(10); // generate a random array;
// order returns an array of indices representing what would be the sorted order of the array.
o = z.order; 
y = z[o]; // using the order as an index returns the sorted array

// calling order on the order returns an array of indices that returns the sorted array to the 
// original scrambled order
p = o.order; 
x = y[p];

// bubbling wraps an item in an array of one element. it takes the depth and levels as arguments.
z = Array.iota(4,4);
z.bubble;
z.bubble(1);
z.bubble(2);
z.bubble(0,2);
z.bubble(1,2);
z.bubble(2,2);
// similarly, unbubble unwraps an Array if it contains a single element.
5.unbubble;
[5].unbubble;
[[5]].unbubble;
[[5]].unbubble(0,2);
[4,5].unbubble;
[[4],[5]].unbubble;
[[4],[5]].unbubble(1);
z.bubble.unbubble;
z.bubble(1).unbubble(1);
z.bubble(2).unbubble(2);

// laminating with the +++ operator
// the +++ operator takes each item from the second list and appends it to the corresponding item
// in the first list. If the second list is shorter, it wraps.
z = Array.iota(5,2);
z +++ [77,88,99];
z +++ [[77,88,99]];
z +++ [[[77,88,99]]];
z +++ [ [[77]],[[88]],[[99]] ];
// same as:
z +++ [77,88,99].bubble;
z +++ [77,88,99].bubble(0,2);
z +++ [77,88,99].bubble(1,2);

z +++ [11,22,33].pyramidg;
z +++ [11,22,33].pyramidg.bubble;
z +++ [[11,22,33].pyramidg];
z +++ [[[11,22,33].pyramidg]];


(
z = (1..4);
10.do {|i| 
			z.pyramid(i+1).postln;
			z.pyramidg(i+1).postln;
			"".postln;
};
)

// reshapeLike allows you to make one nested array be restructured in the same manner as another.

a = [[10,20],[30, 40, 50], 60, 70, [80, 90]];
b = [[1, 2, [3, 4], [[5], 6], 7], 8, [[9]]];
a.reshapeLike(b);
b.reshapeLike(a);

// If the lengths are different, the default behaviour is to wrap:

a = [[10,20],[30, 40, 50]];
b = [[1, 2, [3, 4], [[5], 6], 7], 8, [[9]]];
a.reshapeLike(b);

// but you can specify other index operators:

a.reshapeLike(b, \foldAt);

a.reshapeLike(b, \clipAt);

a.reshapeLike(b, \at);

// allTuples will generate all combinations of the sub arrays
[[1, 2, 3], [4, 5], 6].allTuples;
[[1, 2, 3], [4, 5, 6, 7], [8, 9]].allTuples;





