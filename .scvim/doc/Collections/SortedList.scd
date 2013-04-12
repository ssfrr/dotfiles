SortedList

Superclass: List

SortedList is a Collection whose items are kept in a sorted order.

Creation

*new(size, function)

Creates a SortedList with the initial capacity given by size and a comparison function.

Instance Methods

add(item)

Adds an item in the SortedList at the correct position.

SortedList[1, 2, 5, 6].add(4).postln;


addAll(aCollection)

Adds all the items in the collection into the SortedList.

SortedList[1, 2, 5, 6].addAll([0, 3, 4, 7]).postln;



