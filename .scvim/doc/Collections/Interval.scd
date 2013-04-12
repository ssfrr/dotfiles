Interval				range of integers 

superclass: Collection

An Interval is a range of integers from a starting value to an ending value by some step value.

Creation

*new(start, end, step)

Create a new Interval.

Interval(10, 30, 4);
10 to: 30; // the message to creates an interval with step 1

Instance Variables

<>start 

The starting value of the interval.

<>end 

The ending value of the interval.

<>step 

The step value of the interval.


Instance Methods

size

Return the number of items in the interval.

Interval(10, 30, 4).size.postln;


at(index)

Return the indexed item in the interval.

Interval(10, 30, 4).at(3).postln;


do(function)

Evaluates function for each item in the interval.
The function is passed two arguments, the item and an integer index.

Interval(10, 30, 4).do({ arg item, i; item.postln });




