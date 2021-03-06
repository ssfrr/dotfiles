SkipJack a utility for background tasks that survive cmd-.


*new( updateFunc, dt, stopTest, name, clock, autostart ) 

updateFunc - the function to repeat in the background
dt - the time interval at which to repeat. can also be a stream or a function that returns a number
stopTest - a test whether to stop the task now
name - is only used for posting information
clock - the clock that plays the task.
	default is AppClock, so SkipJack can call GUI primitives. 
	If you need more precise timing, you can supply your own clock, and use defer only where necessary.
autostart - when true (default) SkipJack starts automatically as it is created.
			


w = SkipJack({ "watch...".postln; }, 0.5, name: "test");
SkipJack.verbose = true;	// post stop/wakeup logs

w.stop;
w.start;

// 	now try to stop with cmd-. : SkipJack always restarts itself.
thisProcess.stop;

w.stop;

	// use stopTest: 
a = 5;
w = SkipJack({ "watch...".postln; }, 0.5, { a == 10 }, "test");
a = 10;	// fulfil stopTest


//	Typical use: SkipJack updates a window displaying the state 
//	of some objects every now and then. 
(		// example is mac-only
d = (a: 12, b: 24);
d.win = SCWindow("dict", Rect(0,0,200,60)).front;
d.views = [\a, \b].collect { |name, i| 
	SCStaticText(d.win, Rect(i * 100,0,96,20))
		.background_(Color.yellow).align_(0).string_(name);
};
w = SkipJack({ 
		"...".postln;
		[\a, \b].do { |name, i| 
			d.views[i].string_(name ++ ":" + d[name]) 
		} 
	}, 
	0.5,
	{ d.win.isClosed },
	"showdict"
);
)

d.a = 123;	// updates should be displayed
d.b = \otto;	
d.win.close;	// when window closes, SkipJack stops.

(		// the same example, but written in x´cross-platform gui style:
d = (a: 12, b: 24);
d.win = GUI(\window).new("dict", Rect(0,0,200,60)).front;
d.views = [\a, \b].collect { |name, i| 
	GUI(\staticText).new(d.win, Rect(i * 100,0,96,20))
		.background_(Color.yellow).align_(0).string_(name);
};
w = SkipJack({ 
		"...".postln;
		[\a, \b].do { |name, i| 
			d.views[i].string_(name ++ ":" + d[name]) 
		} 
	}, 
	0.5,
	{ d.win.isClosed },
	"showdict"
);
)


//	I prefer this 'lazy' gui idea to a dependency model: 
//	Even when lots of changes happen fast, you don't choke your 
//	cpu on gui updating, you still see some intermediate states.

	//	if you need to get rid of an unreachable skipjack 
SkipJack({ "unreachable, unkillable...".postln }, name: "jack");

SkipJack.stopAll	// do this to stop all;

SkipJack.stop("jack");	// reach it by name and stop


