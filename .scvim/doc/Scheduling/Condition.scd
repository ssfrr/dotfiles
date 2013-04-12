Condition			block execution of a thread


superclass: Object


	*new(test)	create a new instance, set the test variable.
	
	test			return the test variable (boolean)
	
	wait			wait until the condition is true and signalled
	
	hang(val)		wait for val time, regardless of test
	
	signal		if test is true, reschedule blocked threads
	
	unhang		resume threads




// example


(
c = Condition.new(false);

Routine {
	1.wait;
	"waited for 1 second".postln;
	1.wait;
	"waited for another second, now waiting for you ... ".postln;
	c.wait;
	"the condition has stopped waiting.".postln;
	1.wait;
	"waited for another second".postln;
	"waiting for you ... ".postln;
		c.test = false;
		c.wait;
	"the condition has stopped waiting.".postln;
	1.wait;
	"the end".postln;
}.play; 
)

// continue
(
c.test = true;
c.signal;
)

// a typical use is a routine that can pause under certin conditions:
(
c = Condition.new;
fork { loop { 1.wait; "going".postln; c.wait } };
)
c.test = true; c.signal;
c.test = false;



// the same, using hang

(
c = Condition.new;

Routine {
	1.wait;
	"waited for 1 second".postln;
	1.wait;
	"waited for another second, now waiting for you ... ".postln;
	c.hang;
	"the condition has stopped waiting.".postln;
	1.wait;
	"waited for another second".postln;
	"waiting for you ... ".postln;
	c.hang;
	"the condition has stopped waiting.".postln;
}.play; 
)

// continue
c.unhang;




