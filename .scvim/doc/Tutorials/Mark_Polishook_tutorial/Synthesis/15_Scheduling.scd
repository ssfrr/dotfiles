Routines and clocks

Use clocks to create automated, algorithmic scheduling. Among the things that clocks "play" are routines, tasks, and patterns. 

To see how a clock "plays" a routine, first examine how a function works in a routine.

The first argument (and usually the only argument) to a routine is a function.

// template for a routine
Routine({ ".... code within curly braces is a function .... "});

A .yield message to an expression in a function (in a routine) returns a value.

r = Routine({ "hello, world".yield.postln });

// to evaluate a routine, send a .next message
// it will "hand over" the value of the expression to which the .yield message is attached
r.next;

Evaluate (again)

r.next;

The routine above returns nil when its evaluated a second time. This is because once a routine "yields" and if there's no additional code after the .yield message, the routine is finished, over, and done - unless it receives a reset message. Then it can start over again.

r.next;		// returns nil
r.reset;		// reset the routine
r.next;		// it works!

////////////////////////////////////////////////////////////////////////////////////////////////////

(
r = Routine({ 
	"hello, world".yield;
	"what a world".yield;
	"i am a world".yield;
});
)

The first three .next messages return a string. The fourth .next message returns nil.

r.next;	// returns a string
r.next;	// returns a string
r.next;	// returns a string
r.next;	// returns nil

Reset the routine.

r.reset;

r.next;
r.next;
r.next;
r.next;

////////////////////////////////////////////////////////////////////////////////////////////////////

Use a .do message in a routine to make a loop.

(
r = Routine({ 

	// setup code
	var array;
	array = [ "hello, world", "what a world", "i am a world" ];

	// the loop
	3.do({ array.choose.yield })
	
});
)

Evaluate the routine one more time than the loop in the routine allows. 

4.do({ r.next.postln });

The routine returned three strings followed by nil.

////////////////////////////////////////////////////////////////////////////////////////////////////

Scheduling routines

Rewrite the routine so that it includes a .wait message.

(
r = Routine({ 

	var array;
	array = [ "hello, world", "what a world", "i am a world" ];

	3.do({ 
		1.wait; 				// pause for 1 second
		array.choose.postln; 
	})
	
});
)

Then "play" the routine, eg, send it a .play message.

r.play

Append a .reset message to the routine so that it can start over. 

r.reset.play;

////////////////////////////////////////////////////////////////////////////////////////////////////

Clocks and the convenience of .play

When a routine receives a .play message, control (of the routine) is redirected to a clock. The clock uses the receiver of the .wait message as a unit of time to schedule ("play") the routine.

SuperCollider has three clocks, each of which has a help file.

SystemClock					// the most accurate
AppClock						// for use with GUIs
TempoClock					// to schedule in beats

The .play message is a convenience that allows one to write

r.reset.play;				// reset the routine before playing it

instead of 

SystemClock.play(r)	

////////////////////////////////////////////////////////////////////////////////////////////////////

Scheduling synths with routines

Enclose synths within routines. It's often the case that the synthdef used by the synth in routines should have an envelope with a doneAction parameter set to 2 (to deallocate the memory needed for the synth after its envelope has finished playing).

(
// DEFINE A SYNTHDEF
SynthDef("fm2", { 
	arg bus = 0, freq = 440, carPartial = 1, modPartial = 1, index = 3, mul = 0.2, ts = 1;

	// index values usually are between 0 and 24
	// carPartial :: modPartial => car/mod ratio
	
	var mod;
	var car;
	
	mod = SinOsc.ar(
		freq * modPartial, 
		0, 
		freq * index * LFNoise1.kr(5.reciprocal).abs
	);
		
	car = SinOsc.ar(
		(freq * carPartial) + mod, 
		0, 
		mul
	);
	
	Out.ar(
		bus,
		car * EnvGen.kr(Env.sine(1), doneAction: 2, timeScale: ts)
	)
}).load(s);
)

(
// DEFINE A ROUTINE
r = Routine({

	12.do({
		Synth(
			"fm2", 
			[
				\bus, 2.rand, \freq, 400.0.rrand(1200), 
				\carPartial, 0.5.rrand(2), \ts, 0.5.rrand(11)
			]
		);
		s.queryAllNodes;
		"".postln.postln.postln.postln.postln;
		2.wait;
	})
});
)

// PLAY THE ROUTINE
r.reset.play;

////////////////////////////////////////////////////////////////////////////////////////////////////

Process synths spawned in a routine through effects that run outside of the routine. 

(
// DEFINE A SYNTHDEF
SynthDef("echoplex", {
	ReplaceOut.ar(
		0,
		CombN.ar(
			In.ar(0, 1),
			0.35,
			[Rand(0.05, 0.3), Rand(0.05, 0.3)], 
			// generate random values every time a synth is created
			7,
			0.5
		)
	)
}).load(s);

// DEFINE GROUPS TO CONTROL ORDER-OF-EXECUTION
// attach a ~source group to the head of the rootnode and 
// an ~effects group to the tail of the rootenode
~source = Group.head(s);
~effect = Group.tail(s);

// DEFINE A ROUTINE
r = Routine({

	// loop is the same as inf.do, eg, create an infinite loop that runs forever
	loop({
		Synth.head(	// attach the synth to the head of the ~source group
			~source,
			"fm2", 
			[
				\outbus, 0, \freq, 400.0.rrand(1200), \modPartial, 0.3.rrand(2.0),
				\carPartial, 0.5.rrand(11), \ts, 0.1.rrand(0.2)]
		);
		s.queryAllNodes;
		2.wait;
	})
});

// TURN ON EFFECTS
Synth.head(~effect, "echoplex");
Synth.tail(~effect, "echoplex");
)
// PLAY THE ROUTINE
r.reset.play;

////////////////////////////////////////////////////////////////////////////////////////////////////


