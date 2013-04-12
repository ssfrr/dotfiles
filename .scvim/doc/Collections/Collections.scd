Collections

SuperCollider has a rich hierarchy of Collection subclasses, detailed below. Subclasses of a given class are indented (sub-lists) relative to the class. Most of these subclasses have their own helpfiles. Classes labelled "abstract" are not for direct use, but classes lower down the tree may inherit methods from them. For this reason it is important to consult the helpfiles of classes farther up the tree in order to get a complete list of available methods.


Collection - abstract superclass of all Collection subclasses; many methods are inherited from this class

 SequenceableCollection - abstract superclass of collections whose objects can be indexed by integer

 ArrayedCollection - abstract superclass of Collections of fixed maximum size whose elements are held in a vector of slots

 Array - an ArrayedCollection whose slots may contain any object; more efficient than List
 RawArray - abstract superclass of array classes that hold raw data values

 FloatArray - a RawArray of floats

 Wavetable - a special format FloatArray
 Signal - a FloatArray that represents a sampled function of time buffer
 DoubleArray - a RawArray of double precision floats
 String - an array of characters
 SymbolArray - a RawArray of symbols
 Int32Array - a RawArray of 32 bit Integers
 Int16Array - a RawArray of 16 bit Integers
 Int8Array - a RawArray of 8 bit Integers





 Order - order of elements with a numerical index
 SparseArray - array of elements optimized for huge gaps between them
 LinkedList - a doubly linked list
 List - an expandable SequenceableCollection (compare to ArrayedCollection and Array)

 SortedList - a List whose items are kept in a sorted order


 Set - an unordered collection of unequal objects

 Dictionary - an unordered associative collection mapping keys to values

 IdentityDictionary - a Dictionary wherein keys match only if identical (rather than if simply equal)

 Environment - an IdentityDictionary, one of which is always current; useful for creating sets of persistent variables

 Event - a Dictionary mapping names of musical parameters to their values



 IdentitySet - an unordered collection of unidentical objects (compare to Set)

 Array2D - a two dimensional array
 Range - ranges of values
 Interval - ranges of Integers with a fixed Interval between them
 MultiLevelIdentityDictionary - a tree of IdentityDictionaries

 Library - a unique global MultiLevelIdentityDictionary

 Bag - an unordered collection of objects
 Pair - Lisp-like two element cells
 TwoWayIdentityDictionary - an IdentityDictionary which allows easy searching by both key and value; faster than IdentityDictionary on reverse lookup, but with more memory overhead

 ObjectTable - associates Integer ids with objects




