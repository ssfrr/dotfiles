PriorityQueue

superclass: Object

PriorityQueue implements a priority queue data structure, which is
used to build schedulers.
It allows you to put in items at some arbitrary time and pop them in 
time order.

Instance Methods:

put(time, item)

Puts the item in the queue at the given time.

topPriority

Returns the time of the earliest item in the queue.

pop

Returns the earliest item in the queue.

clear

Empty the queue.

isEmpty

Return a Boolean whether the queue is empty.

notEmpty

Return a Boolean whether the queue is not empty.


Example:

(
var p;
p = PriorityQueue.new;

p.put(0.1, \a);
p.put(2.0, \b);
p.put(0.5, \c);
p.put(0.2, \d);
p.put(1.0, \e);

while ({ p.notEmpty },{
	[p.topPriority, p.pop].postln;
});


p.pop.postln;
p.pop.postln;
p.pop.postln;

)

[ 0.1, a ]
[ 0.2, d ]
[ 0.5, c ]
[ 1, e ]
[ 2, b ]
nil
nil
nil




