Order		an order of elements with a numerical index

Inherits from: Object : Collection : SequenceableCollection


Keeps elements in an order and allows to put them at arbitrary slots 
without having to allocate a large array. 

see also: SparseArray

Note: put and at are slower than in IdentityDictionary / PriorityQueue, do is faster.


*new(size)
		create a new order.		
		
		//  example
		g = Order.new;
		g.put(7, 100); // put a value (100) at index 7
		g.clear; // empty
		
*newFromIndices(array, indices)
		create a new order from given items and indices
		

*doRange(function, from to)
		iterate over a range of the order's items.
		


// example

a = Order.new;

a[0] = \z;
a[0] = \y;
a[5] = \five;
a[4] = \four;

a[0] = \z;
a[5] = \five;
a[4] = \four;

a.indices;

a[9] = 100;
a.indices;




