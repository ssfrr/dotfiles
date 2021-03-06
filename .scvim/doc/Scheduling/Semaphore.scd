Semaphore			control parallel execution of threads


superclass: Object


	*new(count)	create a new instance, set the maximum number of running threads (default: 1).
	
	count		determines the number of running threads
	
	clear		remove any reference to threads, but do not rescedule any pending ones.
	
	wait			stop current thread if already too many are running, otherwise continue.
		
	signal		unblock the semaphore, reschedule next pending thread.
	



// example


// allow only one thread
(
c = Semaphore(1);
fork { 
	c.wait; 
	"thread 1> now I am doing something for 10 seconds. Block the semaphore meanwhile.".postln; 
	10.wait;
	c.signal;
	"thread 1> ok, done. Release the semaphore.".postln; 
};
fork {
	3.0.rand.wait;
	"thread 2> I would like to go on, if I may.".postln;
	c.wait; // may I?
	"thread 2> this took until the other thread has released the semaphore. "
		"Blocking for 4 seconds.".postln;
	4.wait;
	"thread 2> ok, done. Releasing the semaphore".postln;
	c.signal;
};
fork {
	4.wait;
	"thread 3> I, too, would like to go on, if I may.".postln;
	c.wait; // may I?
	"thread 3> this took until both other threads had released the semaphore.".postln;
	c.signal;
};
)



// allow two threads at a time.
(
c = Semaphore(2);
fork { 
	c.wait; 
	"thread 1> now I am doing something for 20 seconds. Block the semaphore.".postln; 
	10.wait;
	"thread 1> ok, done. Releasing the semaphore".postln;
	c.signal;
	 
};
fork {
	rrand(3.0, 5.0).wait;
	"thread 2> I would like to go on, if I may.".postln;
	if(c.count <= 0) { "thread 3> ok, then I wait ...".postln };
	c.wait; // may I?
	"thread 1> ok, going ahead.".postln;
	17.wait;
	"thread 2> ok, done. Releasing the semaphore".postln;
	c.signal;
};
fork {
	6.wait;
	"thread 3> I, too, would like to go on, if I may.".postln;
	if(c.count <= 0) { "thread 3> ok, then I wait ...".postln };
	c.wait; // may I?
	"thread 3> ok, this took until the first thread had released the semaphore. "
		"Ok, doing something for 4 seconds. Block the semaphore".postln;
		4.wait;
	"Releasing the semaphore.".postln;
	c.signal;
	
};
fork {
	7.wait;
	"thread 4> Me, the fourth one, would like to go on, if I may.".postln;
	if(c.count <= 0) { "thread 4> ok, then I wait ...".postln };
	c.wait; // may I?
	"thread 4> ok, this took until the third thread had released the semaphore. "
		"Ok, doing something for 3 seconds. Block the semaphore".postln;
		3.wait;
	"Releasing the semaphore.".postln;
	c.signal;
};

)


// grant exclusive access to data to only one thread
// there should never be mixed values in the data array

(
var data, useAndModify;

data = [1, 2, 3];
c = Semaphore(1);
// c = Semaphore(2); use this to test how it would behave without exclusive access.
useAndModify = { |newData, who|
	postln(who + "trying to get blocking access.");
	if(c.count <= 0) { who + "ok, then I wait ...".postln };
	c.wait; // may I access? if not, I wait. if yes, disallow others.
	"\n".post;
	(who + "continuing...").postln;
	data.do({ |x|
			0.1.wait;
			postln(who + x);
			
		});
	"\n".post;
	newData.do { |x, i| data[i] = x };
	postln(who + "rewriting data to:" + newData);
	postln(who + "releasing");
	c.signal; // allow others access again
};

// e.g. set the values to integers
u = Routine {
	inf.do { |i|
		useAndModify.value([100, 200, 300], "thread 1>");
		rrand(1, 3).wait;
	}
};

// e.g. set the values to floats
k =  Routine {
	0.5.wait;
	inf.do { |i|
		useAndModify.value([pi, 0.5pi, 2pi], "thread 2>");
		rrand(1, 5).wait;
	}
};
u.play;
k.play;
);


