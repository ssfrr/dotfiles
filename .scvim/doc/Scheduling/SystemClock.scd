SystemClock

superclass: Clock

SystemClock is more accurate, but cannot call Cocoa primitives.
AppClock is less accurate (uses NSTimers) but can call Cocoa primitives.

*sched(delta,task)
	the float you return specifies the delta to resched the function for

		SystemClock.sched(0.0,{ arg time;  
			time.postln; 
			rrand(0.1,0.9) 
		});

	returning nil will stop the task from being rescheduled

		SystemClock.sched(2.0,{ 
			"2.0 seconds later".postln; 
			nil 
		});

*clear
	clear the SystemClock's scheduler to stop it

		SystemClock.clear

*schedAbs(time,task)
	
		SystemClock.schedAbs( (thisThread.seconds + 4.0).round(1.0),{ arg time;
			("the time is exactly " ++ time.asString 
				++ " seconds since starting SuperCollider").postln;
		});
				
	
*play(task)
	Calls to the cocoa framework (including all GUI) may not be made directly 
	from actions triggered by SystemClock or incoming socket messages 
	(OSCresponder). 

	To get around this, use { }.defer
	This will execute the function using the AppClock and is equivalent to
		AppClock.sched(0, function):


		(
		var w, r;
		w = Window.new("trem", Rect(512, 256, 360, 130));
		w.front;
		r = Routine({ arg time;
				60.do({ arg i;
					0.05.yield;
					{
						w.bounds = w.bounds.moveBy(10.rand2, 10.rand2);
						w.alpha = cos(i*0.1pi)*0.5+0.5;
					}.defer;
				});
				1.yield;
				w.close;
		});
		SystemClock.play(r);
		)

	This example is only to show how to make calls to Cocoa/GUI when 
	scheduling with the SystemClock.
	If you only wish to control the GUI, use AppClock.
		



