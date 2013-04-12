AppClock

superclass: Clock

SystemClock is more accurate, but cannot call Cocoa primitives.
AppClock is less accurate (uses NSTimers) but can call Cocoa primitives.

You will need to use the SystemClock to get accurate/musical scheduling.



*sched(delta,task)
	the float you return specifies the delta to resched the function for

		AppClock.sched(0.0,{ arg time; 
				["AppClock has been playing for ",time].postln; 
				rrand(0.1,0.9) 
		});

	returning nil will stop the task from being rescheduled

		AppClock.sched(2.0,{ 
			"2.0 seconds later".postln; 
			nil 
		});

*clear
	clear the AppClock's scheduler to stop it

		AppClock.clear

*play(task)
	The task/Routine yields a float value indicating the delta (secs) for the AppClock to wait
	until resuming the Routine.

		(
		var w, r;
		w = Window.new("trem", Rect(512, 256, 360, 130));
		w.front;
		r = Routine({ arg appClockTime;
				["AppClock has been playing for secs:",appClockTime].postln;
				60.do({ arg i;
					0.05.yield;
					w.bounds = w.bounds.moveBy(10.rand2, 10.rand2);
					w.alpha = cos(i*0.1pi)*0.5+0.5;
				});
				1.yield;
				w.close;
		});
		AppClock.play(r);
		)
	
*tick
	AppClock.tick is called periodically by the SuperCollider application itself.
	This updates the Scheduler and causes any scheduled tasks to be executed.  You
	should never call this method yourself.




