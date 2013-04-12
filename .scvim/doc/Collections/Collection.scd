Collection			group of objects

Inherits from: Object

Collections are groups of objects. See the Collections overview for a complete listing of all subclasses.

Collection is an abstract class. You do not create direct instances of Collection. 
There are many types of Collections including List, Array, Dictionary, Bag, Set, SortedList, etc. 

Class Methods:

*newFrom(collection)
Creates a new Collection from another collection. This supports the interface for the mathod "as"

Array.newFrom(Set[4, 2, 1]);
Set.newFrom(Array[4, 2, 1]);
[1, 2, 3, 4, 3, 2].as(Set); // as(someClass) calls someClass.newFrom(this)


*with(collection)
Creates a new Collection from the args.

Array.with(4, 2, 1);

*fill(size, function)
Creates a Collection of the given size, the elements of which are determined by evaluation the given function. The function is passed the index as an argument.

Array.fill(4, { arg i; i * 2 });


Accessing:

size
Answers the number of objects contained in the Collection.

List[1, 2, 3, 4].size;

isEmpty
Answer whether the receiver contains no objects.

List[].isEmpty;


Adding and Removing:

add(anObject)
Add anObject to the receiver.

List[1, 2].add(3);

addAll(aCollection)
Add all items in aCollection to the receiver.

List[1, 2].addAll(List[3, 4]);

remove(anObject)
Remove anObject from the receiver. Answers the removed object.

(
var a;
a = List[1, 2, 3, 4];
a.remove(3);
a;
)

removeAll(aCollection)
Remove all items in aCollection from the receiver.

List[1, 2, 3, 4].removeAll(List[2, 3]);

Note that multiple items in the receiver will not necessarily be removed:

~closet = [\hat, \hat, \hat, \coat, \coat, \shoe, \shoe];
~closet.removeAll([\hat, \coat, \shoe, \shoe]); // Doesn't empty the closet, just removes what we wanted to

See removeEvery (below) for a related method that removes all occurrences.

removeEvery(aCollection)
Remove all occurrences of the items in aCollection from the receiver.

List[1, 2, 3, 2, 3, 2, 3, 4].removeEvery(List[2, 3]);

removeAllSuchThat(function)
Remove all items in the receiver for which function answers true. The function is passed two arguments, the item and an integer index. Answers the objects which have been removed.

(
var a;
a = List[1, 2, 3, 4];
a.removeAllSuchThat({ arg item, i; item < 3 });
a;
)
putEach(keys, values)
Put the values in the corresponding indices given by keys. If one of the two argument arrays is longer then it will wrap.

y = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
y.putEach([4, 7], [\smelly, \head])
y.putEach([2, 3, 5, 6], \wotsits);

atAll(keys)
return a collection of all the items for the keys.

y = [\a, \b, \c];
y.atAll([0, 2])


Testing:

includes(anObject)
Answer whether anObject is contained in the receiver.

List[1, 2, 3, 4].includes(3);

includesAny(aCollection)
Answer whether any item in aCollection is contained in the receiver.

List[1, 2, 3, 4].includesAny(List[4, 5]);

includesAll(aCollection)
Answer whether all items in aCollection are contained in the receiver.

List[1, 2, 3, 4].includesAll(List[4, 5]);

matchItem(item) 
		returns true if this inclueds the item.
		See also: matchItem


Iteration:

do(function)
Evaluates function for each item in the collection. The function is passed two arguments, the item and an integer index.

List[1, 2, 3, 4].do({ arg item, i; item.postln });

collect(function)
Answer a new collection which consists of the results of function evaluated for each item in the collection. The function is passed two arguments, the item and an integer index.

List[1, 2, 3, 4].collect({ arg item, i; item + 10 });

If you want to control what type of collection is returned, use collectAs(function, class).

select(function)
Answer a new collection which consists of all items in the receiver for which function answers true. The function is passed two arguments, the item and an integer index.

List[1, 2, 3, 4].select({ arg item, i; item.even });

If you want to control what type of collection is returned, use selectAs(function, class).

reject(function)
Answer a new collection which consists of all items in the receiver for which function answers false. The function is passed two arguments, the item and an integer index.

List[1, 2, 3, 4].reject({ arg item, i; item.even });

If you want to control what type of collection is returned, use rejectAs(function, class).

detect(function)
Answer the first item in the receiver for which function answers true.
The function is passed two arguments, the item and an integer index.

List[1, 2, 3, 4].detect({ arg item, i; item.even });

detectIndex(function)
Similar to detect but returns the index instead of the item itself.

List[1, 2, 3, 4].detectIndex({ arg item, i; item.even });

inject(initialValue, function)
In functional programming, the operation known as a fold.
inject takes an initial value and a function and combines the elements of the collection by applying the function to the accumulated value and an element from the collection. The function takes two arguments and returns the new value. The accumulated value is initialzed to initialValue.

[1,2,3,4,5].inject(0, _+_); // 15

[1,2,3,4,5].inject(1, _*_); // 120

// same as .collect(_.squared)
[1,2,3,4,5].inject([], {|a,b| a ++ b.squared }); // [ 1, 4, 9, 16, 25 ]
[1,2,3,4,5].inject([], {|a,b| [b] ++ a ++ [b]}); // [ 5, 4, 3, 2, 1, 1, 2, 3, 4, 5 ]
[1,2,3,4,5].inject([], {|a,b| a ++ b ++ a});
[1,2,3,4,5].inject([], {|a,b| a ++ a ++ b});


any(function)
Answer whether function answers true for any item in the receiver.
The function is passed two arguments, the item and an integer index.

List[1, 2, 3, 4].any({ arg item, i; item.even });

every(function)
Answer whether function answers true for every item in the receiver.
The function is passed two arguments, the item and an integer index.

List[1, 2, 3, 4].every({ arg item, i; item.even });

count(function)
Answer the number of items for which function answers true.
The function is passed two arguments, the item and an integer index.

List[1, 2, 3, 4].count({ arg item, i; item.even });

occurrencesOf(anObject)
Answer the number of items in the receiver which are equal to anObject.

List[1, 2, 3, 3, 4, 3, 4, 3].occurrencesOf(3);

sum(function)
Answer the sum of the results of function evaluated for each item in the receiver.
The function is passed two arguments, the item and an integer index.

List[1, 2, 3, 4].sum;

(0..8).sum { |i| 1 / (2 ** i) };

maxItem(function)
Answer the maximum of the results of function evaluated for each item in the receiver.
The function is passed two arguments, the item and an integer index.
If function is nil, then answer the maximum of all items in the receiver.

List[1, 2, 3, 4].maxItem({ arg item, i; item + 10 });

minItem(function)
Answer the minimum of the results of function evaluated for each item in the receiver.
The function is passed two arguments, the item and an integer index.
If function is nil, then answer the minimum of all items in the receiver.

List[1, 2, 3, 4].minItem({ arg item, i; item + 10 });

maxIndex(function)
Answer the index of the maximum of the results of function evaluated for each item in the receiver.
The function is passed two arguments, the item and an integer index.
If function is nil, then answer the maximum of all items in the receiver.

List[1, 2, 3, 4].maxIndex({ arg item, i; item + 10 });
[3.2, 12.2, 13, 0.4].maxIndex

minIndex(function)
Answer the index of the minimum of the results of function evaluated for each item in the receiver.
The function is passed two arguments, the item and an integer index.
If function is nil, then answer the minimum of all items in the receiver.

List[1, 2, 3, 4].minIndex({ arg item, i; item + 10 });
List[3.2, 12.2, 13, 0.4].minIndex



iter
returns a Routine that returns the elements one by one.

r = Set[10, 2, -3, -4].iter;
r.next;
r.next;
r.next;
r.next; // nil.



Conversion:

asBag
Answer a Bag to which all items in the receiver have been added.

List[1, 2, 3, 4].asBag;

asList
Answer a List to which all items in the receiver have been added.

Set[1, 2, 3, 4].asList;

asSet
Answer a Set to which all items in the receiver have been added.

List[1, 2, 3, 4].asSet;

asSortedList
Answer a SortedList to which all items in the receiver have been added.

List[2, 1, 4, 3].asSortedList;


powerset
Returns all possible combinations of the collection's elements.

Set[1, 2, 3].powerset;

// generate the von neumann ordinals. (warning: only count to four at maximum!)
a = Set[];
a = a.powerset;
a = a.powerset;
a = a.powerset;

u = { |set| set.unify }; // union (count down)
n = { |set| set.powerset }; // powerset (count up)
a = Set[]; // empty set (zero)
n.(n.(a)); // two
u.(n.(n.(a))) == n.(a); // two - one == one
u.(u.(n.(n.(a)))) == u.(n.(a)); // two - two == one - one 

flopDict(unbubble)
Takes a collection of dictionaries and returns a single dictionary with arrays of all dictionaries' elements.
If unbubble is true (default), and if one element is singular, the array is replaced by this element.

[(degree: 7, x: 4), (degree: 8, x: 5), (degree: -2, dur: 2.5)].flopDict;
[(degree: 7, x: 4), (degree: 8, x: 5), (degree: -2, dur: 2.5)].flopDict(false);


histo(steps, min, max)
Returns a histogram of the collection by counting the number of values that fall into each slot of size (default: 100) subdivisions between min and max. If there are any values outside this range, it posts a note. If min or max is not given, the smallest (or largest value respectively) is used.

{ 1.0.linrand }.dup(10000).histo(1000).plot;
{ 8.rand }.dup(10000).histo(8).plot(discrete: true);



printOn(stream)
Print a representation of the collection to a stream.

storeOn(stream)
Write a compileable representation of the collection to a stream.

printItemsOn(stream)
Print a comma separated compileable representation of the items in the collection to a stream.

storeItemsOn(stream)
Write a comma separated compileable representation of the items in the collection to a stream.





Set specific operations:


sect(that)			return the set theoretical intersection of this and that

a = [1, 2, 3]; b = [2, 3, 4, 5];
sect(a, b);

union(that)		return the set theoretical union of this and that

a = [1, 2, 3]; b = [2, 3, 4, 5];
union(a, b);

difference(that)		return the set of all items which are elements of this, but not of that

a = [1, 2, 3]; b = [2, 3, 4, 5];
difference(a, b);

symmetricDifference(that)		return the set of all items which are not elements of both  this and that
this -- that

a = [1, 2, 3]; b = [2, 3, 4, 5];
symmetricDifference(a, b);

isSubsetOf(that)	returns true if all elements of this are also elements of that 

a = Set[1, 2, 3, 4];
Set[1, 2].isSubsetOf(a); // true
Set[1, 5].isSubsetOf(a); // false




