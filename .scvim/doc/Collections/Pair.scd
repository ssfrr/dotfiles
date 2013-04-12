Pair				LISP-like two element cells

Inherits from: Object : Collection

(implementation incomplete. See J Concepts In SC for similar functionality)

Class Methods


*new(linkDown, linkAcross) 		return new instance

*newFrom(collection)			convert collection (e.g. arrays of arrays) to pairs.



Instance Methods

Most methods are inherited from the superclasses.

size

return the size when linking across

depth

return the size when linking down

do(function)

iterate over the two elements

traverse(function)

same like: depthFirstPreOrderTraversal

depthFirstPreOrderTraversal(function)

traverse the data structure first link down, then across (see example).

depthFirstPostOrderTraversal(function)

traverse the data structure from bottom up (see example)


// example

a = Pair(Pair(Pair(1, 2), 4), Pair(5, 6));


a.size;
a.depth;
a.do { |x| x.postln };
a.traverse { |x| x.postln };
a.depthFirstPreOrderTraversal { |x| x.postln };
a.depthFirstPostOrderTraversal { |x| x.postln };


// alternative instantiations:

Pair.newFrom([1, [2, [[4, 5], 6]]]);

[1, [2, [[4, 5], 6]]].as(Pair); // equivalent.






