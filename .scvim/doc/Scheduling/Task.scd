Task				a pauseable process

superclass: PauseStream 

Task is a pauseable process. It is implemented by wrapping a PauseStream around a Routine. Most of its methods (start, stop, reset) are inherited from PauseStream.

Tasks are not 100% interchangeable with Routines.

- Condition does not work properly inside of a Task.
- Stopping a task and restarting it quickly may yield surprising results (see example below), but this is necessary to prevent tasks from becoming unstable if they are started and/or stopped in rapid succession.


Task.new(func, clock)
func - A Function to be evaluated. 
clock - A Clock in which to play the Routine. If you do not provide a Clock the default is an instance of TempoClock. Remember that methods which call Cocoa primitives (i.e. GUI functions) must be played in AppClock.

play(argClock, doReset, quant)
argClock - (optional) Override the clock assigned in Task.new
doReset - If true, the task will start over from the beginning. Default is false (task will resume where it was when it was last stopped)
quant - see the Quant helpfile


Other control methods

start(argClock, quant) - Restart the task from the beginning.
resume(argClock, quant) - Resume the task where it left off.
pause - Stop playing now.
stop - Stop playing now. (Pause and stop have the same implementation.)
reset - Set the stream to restart from the beginning the next time it's played.


Notifications

Other objects might need to be aware of changes in the state of a task. The following notifications are broadcast to dependents registered with the Task object.

\userPlayed - Sent at the time the user calls play, start or resume.
\playing - Sent at the time the task begins playing on the clock (corresponding to quant).
\userStopped - Sent at the time the user calls pause or stop.
\stopped - Sent at the time the task is finally removed from the clock (this is the time when the next event would have occurred if the task had not been stopped). If the task function completes on its own, this notification is sent without 'userStopped' being sent previously.


What happens if you stop and start the task too quickly?


t = Task({ 
		50.do({ arg i;
			i.squared.postln; 
			0.5.wait 
		}); 
	});

t.start;
t.pause;
t.resume;
t.reset;
t.stop;


// unexpected behavior here

(
t = Task({
	["go", thisThread.clock.beats].postln;
	inf.do({ arg i;
		2.wait;
		[ "wake up", i ].postln 
	})
});

fork {
	t.start;
	0.1.wait;
	t.stop;
	0.1.wait;
	t.start;
	6.wait;
	t.stop;
};
)

[ go, 1702.114411906 ]
[ go, 1704.114411906 ]

Based on the forked thread, you would expect the second "go" line of output to occur 0.2 seconds after the first, but in fact it happens two seconds later (the same amount of time the task waits between iterations). This is because the task must not schedule itself on the clock more than once. When the task is stopped, it remains scheduled until it wakes up again (based on its wait time). If, during this interval, the task were restarted, there would be two references to the task in the scheduler queue -- a situation that is irrecoverable short of stopping everything with command-period.

As a result, Task should be used for processes that need to start and stop relatively infrequently, but for which maximum stability is required. If you need fine-grained control over when and how the process stops and resumes (as is the case, for instance, with condition), Routine is preferred.


