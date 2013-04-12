OrderedIdentitySet				a set according to identity

Inherits from: Object : Collection : Set : IdentitySet

An OrderedIdentitySet is a collection of objects, no two of which are the same object (aka. "identical").
Most of its methods are inherited. (see Collection and Set classes).
Unlike IdentitySet, contents of an OrderedIdentitySet are ordered. 

See also: IdentitySet, List, Dictionary


Iteration:

do(function)

	Evaluates function for each item in the OrderedIdentitySet.  You may depend on the order of items.
	The function is passed two arguments, the item and an integer index.

	OrderedIdentitySet[1, 2, 3, 300].do { |item, i| item.postln };


