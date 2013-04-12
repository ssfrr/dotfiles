Set				a set according to equality

Inherits from: Object : Collection 

A Set is s collection of objects, no two of which are equal.
Most of its methods are inherited from Collection.
The contents of a Set are unordered. You must not depend on the order of items in a set.
For an ordered set, see OrderedIdentitySet.

See also: IdentitySet, List, Dictionary


Adding and Removing:

add(anObject)

Add anObject to the Set. An object which is equal to an object already in the Set will not be added.

Set[1, 2, 3].add(4).postln;

Set[1, 2, 3].add(3).postln;

Set["abc", "def", "ghi"].add("jkl").postln;

Set["abc", "def", "ghi"].add("def").postln;

remove(anObject)

Remove anObject from the Set.

Set[1, 2, 3].remove(3).postln;


Iteration:

do(function)

Evaluates function for each item in the Set.
The function is passed two arguments, the item and an integer index.

Set[1, 2, 3, 300].do({ arg item, i; item.postln });

keyAt(index)

returns the object at the internal index. This index is not deterministic.



Set specific operations:


sect(that)			return the set theoretical intersection of this and that
this & that

a = Set[1, 2, 3]; b = Set[2, 3, 4, 5];
sect(a, b);
a & b // shorter syntax

union(that)		return the set theoretical union of this and that
this | that

a = Set[1, 2, 3]; b = Set[2, 3, 4, 5];
union(a, b);
a | b // shorter syntax

difference(that)		return the set of all items which are elements of this, but not of that
this - that

a = Set[1, 2, 3]; b = Set[2, 3, 4, 5];
difference(a, b);
a - b // shorter syntax

symmetricDifference(that)		return the set of all items which are not elements of both  this and that
this -- that

a = Set[1, 2, 3]; b = Set[2, 3, 4, 5];
symmetricDifference(a, b);
a -- b // shorter syntax

isSubsetOf(that)	returns true if all elements of this are also elements of that 

a = Set[1, 2, 3, 4];
Set[1, 2].isSubsetOf(a); // true
Set[1, 5].isSubsetOf(a); // false



// example:

a = Set[1, 2, 3, 4];
b = a.powerset; // set of all parts
a.isSubsetOf(b); // false: no set is ever part of itself.
b.asArray.reduce(\union) == a; // true parts may not contain other elements that original
b.asArray.reduce(\difference).isEmpty; // true.

// you can use Set to efficiently remove duplicates from an array:

a = [1, 2, 3, 4, 3, 5, 5, 2, 2, 1];
a.as(Set);	// convert to set
a.as(Set).as(Array); // and convert back




