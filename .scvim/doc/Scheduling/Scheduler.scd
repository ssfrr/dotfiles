Scheduler			schedules functions to be evaluated in the future


superclass: Object

A Scheduler can be used to schedule and reschedule functions to be evaluated at a specific time-point. The Scheduler's time needs to be advanced manually. In most cases you will probably want to use a Clock (e.g. TempoClock, SystemClock, AppClock) instead, in which the march of time is handled for you.


*new(clock, drift)
			clock: 	a clock, like SystemClock.
			drift: 	if true, it will schedule the events relative to Main.elapsedTime,
					otherwise to the current seconds of the scheduler.
	
play(aTask)
			schedules the task to play, with the delta time returned from it.

sched(delta, aTask)
			schedule the task 

advance(bySeconds)
			advance time by n seconds. Any task that is scheduled within the new time,
			is evaluated, and, if it returns a new time, rescheduled.

seconds_(newSeconds)
			set new time. Any task that is scheduled within the new time,
			is evaluated, and, if it returns a new time, rescheduled.
			
isEmpty
			returns whether the scheduling queue is empty.
			
clear
			clear the scheduling queue



// example:

a = Scheduler(SystemClock);

a.sched(3, { "now it is 3 seconds.".postln; nil });
a.sched(5, { "now it is 5 seconds.".postln; nil });
a.sched(1, { "now it is 1 second.".postln; nil });

a.advance(0.5);
a.advance(0.5);
a.advance(2);
a.advance(2);

// the beats, seconds and clock are passed into the task function:
a.sched(1, { arg beats, secs, clock; [beats, secs, clock].postln });
a.advance(1);

// the scheduling is relative to "now":
a.sched(3, { "now it was 3 seconds.".postln });
a.sched(5, { "now it was 5 seconds.".postln });
a.sched(1, { "now it was 1 second.".postln });

a.advance(0.5);
a.advance(0.5);
a.advance(2);
a.advance(2);

// play a Routine or a task:
a.play(Routine { 5.do { arg i; i.postln; 1.yield } });
a.advance(0.9);



// scheduling tasks


(
x = Scheduler(TempoClock.default);

Task { 
	inf.do { |i|
		("next " ++ i ++  " in task." + Main.elapsedTime).postln;
		0.5.wait;
	}
}.play(x)
)

x.advance(0.1);
x.seconds;
x.advance(5);
x.seconds;

(
Routine {
	loop { x.advance(0.1); 0.1.wait }
}.play;
)

(
Task { 5.do {
	x.advance(1);
	2.0.rand.wait;
	}
}.play;
)

x.advance(8.1);

Pbind(\degree, Pseries(0, 2, 8), \dur, 0.25).play(x);

(
Task { 5.do {
	x.advance(0.20);
	1.0.wait;
	}
}.play;
)



