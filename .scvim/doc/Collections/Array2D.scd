Array2D			two-dimensional array

Inherits from: Collection

Represents a two-dimensional array of data. The number of rows and columns is fixed.

See also: Array

Note: It is possible to implement a similar behaviour using an "array-of-arrays" - see the examples towards the bottom of this page for comparison.


Creation / Class Methods
	
	*new(rows, cols)
		
		Create an array of the specified size.
		
		a = Array2D.new(3,4);
		a[2,2] = 1;
		a.postln
		
	*fromArray(rows, cols, array)
		
		Build an Array2D from the supplied array.
		
		a = Array2D.fromArray(3,4, [9,8,7,6,5,4,3,2,1,2,3,4]);
		a[2,2] = 1;
		a.postln
	
	
Instance Methods
	
	at(row, col)
	
		Get a value from the array.
		
		a.at(2,3);
		a[2,3];

	put(row, col, val)
	
		Put a value into the array.
		
		a.put(2,3, 72);
		a[2,3];

	colsDo(function)
	rowsDo(function)
	
		Iterate over the columns, or the rows. Each row or column will be passed to function in turn.
		
		a.colsDo(_.postln);
		a.rowsDo(_.postln);
		
	
	colAt(index)
	rowAt(index)
		
		Retrieve a single row, or column.
		
		a.colAt(2)
		a.rowAt(2)
	
	asArray
	
		Return a flat array containing the elements.
		
		a.postln
		a.asArray.postln;
	
Examples

// "a" is an array-of-arrays
a = { { 100.0.rand }.dup(100) }.dup(100);
// "b" is an equivalent Array2D, made using the "fromArray" class method
b = Array2D.fromArray(100,100, a.flat);

// Accessing
a[15][22]
b[15, 22]

// Speed comparison 1: random access
bench { 100.do(a[100.rand][100.rand]) }
bench { 100.do(b[100.rand, 100.rand]) }

// Speed comparison 2: iteration
bench { 100.do(a.do { |row| row.do { |item| item * 2 } }) }
bench { 100.do(b.do { |item| item * 2 }) }



