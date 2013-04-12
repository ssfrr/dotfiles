TempoClock			tempo based scheduler

Inherits from the abstract class Clock.


TempoClock is a scheduler like SystemClock, but it schedules relative to a tempo in beats per second.



*new(tempo, beats, seconds, queueSize)
	creates a new TempoClock scheduler with the given tempo and starting times. If not supplied, tempo defaults to one, beats defaults to zero and seconds defaults to the current elapsed time since SuperCollider startup. The default queueSize is 256, see queue.
	t = TempoClock.new(1, 0, Main.elapsedTime.ceil);

stop
	destroys the scheduler and releases the OS thread running the scheduler.

clear
	removes all tasks from the scheduling queue.
	
tempo
	returns the current tempo in beats per second.
	
tempo_(newTempo)
	sets the current tempo in beats per second.
	t.tempo_(2.0); // equivalent to t.tempo = 2.0;
	t.tempo_(72/60) // 72 beats per minute

permanent
	returns a Boolean value indicating whether the clock will survive cmd-period. false by default.

permanent_(bool)
	sets whether the clock will survive cmd-period. bool is false by default. If false the clock is stopped (and thus removed) on cmd-period. If true the clock survives cmd-period.

default
	returns the permanent default TempoClock instantiated at startup.
	TempoClock.default.beats // beats since default TempoClock was started
	
default_(aTempoClock)
	sets the default TempoClock.
	
beats
	returns the appropriate beat time of the clock from any thread. If the receiver is the clock of the current thread, this returns the current logical time: thisThread.beats. If the receiver is not the current thread's clock then this translates the current thread's logical time in seconds to this clock's logical time in beats.
	
schedAbs(beat, function)
	schedules a function to be evaluated at a particular beat. If the function returns an Integer or a Float, it will be re-evaluated at the logical time plus the returned value. The function receives a number of default arguments, see play example below. 

sched(delta, function)
	schedules a function to be evaluated delta beats from the current logical time in this clock. If the receiver is the clock of the current thread, the delta is applied to the current logical time. If the receiver is not the current thread's clock then the delta is applied to the clock's elapsed time.

play(task, quant)
	plays task (a function) at the next beat, where quant is 1 by default. Shortcut for schedAbs; see seconds and nextTimeOnGrid for further details on time and quant.
	t.play({arg beats, time, clock; [beats, time, clock].postln})

playNextBar(task)
	plays task (a function) at the next bar using schedAbs.

queue
	returns the scheduling queue Array in the form [beat, function]. The maximum number of items is determined by the clock's queueSize argument upon instantiation. The default queueSize of 256 allows 128 functions to be in the queue at any time.
		
beatDur
	returns the duration in seconds of a current whole beat.

beatsPerBar
	returns the number of beats per bar. The default is 4.
	
beatsPerBar_(newBeatsPerBar)
	sets the number of beats per bar. This must be done from within the scheduling thread, e.g.
	t.schedAbs(t.nextBar, {t.beatsPerBar_(3)});
	
bar
	returns the current bar. See bars2beats for returning beat of current bar.
	
nextBar(beat)
	returns the number of beats at the next bar line relative to the beat argument. If beat is not supplied, returns the beat at which the next bar begins.
	
beatInBar
	returns the current bar beat (as a Float) in relation to beatsPerBar. Values range from 0 to < beatsPerBar.

baseBar
	returns bar at which beatsPerBar was last changed. If beatsPerBar has not been changed since the clock was created, returns 0.

baseBarBeat
	returns beat at which the beatsPerBar was last changed. If beatsPerBar has not been changed since the clock was created, returns 0.

beats2bars(beats)
	returns a bar as a float relative to baseBarBeat.

bars2beats(bar)
	 returns a beat relative to baseBar.
	 t.bars2beats(t.bar) // downbeat of the current bar

timeToNextBeat(quant)
	 returns the logical time to next beat. quant is 1 by default, relative to baseBarBeat, see nextTimeOnGrid.

nextTimeOnGrid(quant, phase)
	with default values, returns the next whole beat. quant is 1 by default, phase is 0. quant is relative to baseBarBeat, such that
	t.nextTimeOnGrid(t.beatsPerBar) == t.nextBar // => true
	Together quant and phase are useful for finding the next n beat in a bar, e.g. nextTimeOnGrid(4, 2) will return the next 3rd beat of a bar (of 4 beats), whereas nextBar-2 may return an elapsed beat. 

elapsedBeats
	returns the current elapsed time in beats. This is equivalent to tempoClock.secs2beats(Main.elapsedTime). It is often preferable to use beats instead of elapsedBeats because beats uses a thread's logical time.

seconds
	returns the current elapsed time. (This method is inherited from Clock.)

beats2secs(beats)
	converts absolute beats to absolute seconds, returning the elapsed time of the clock at the given beats. Only works for times in the current tempo. If the tempo changes any computed time in future will be wrong.
	t.beats2secs(t.beats) // equivalent to t.seconds
	t.beats2secs(0) // how many seconds after startup did beat 0 occur?
	
secs2beats(seconds)
	converts absolute seconds to absolute beats. Only works for times in the current tempo. If the tempo changes any computed time in future will be wrong.

	 

Examples

////////////////////////

t = TempoClock(1); // create a TempoClock

// schedule an event at next whole beat
t.schedAbs(t.beats.ceil, { arg beat, sec; [beat, sec].postln; 1 });

t.tempo = 2;
t.tempo = 4;
t.tempo = 0.5;
t.tempo = 1;

t.clear;

t.schedAbs(t.beats.ceil, { arg beat, sec; [beat, sec].postln; 1 });

t.stop;

////////////////////////

(
// get elapsed time, round up to next second
v = Main.elapsedTime.ceil;

// create two clocks in a 5:2 relation, starting at time v.
t = TempoClock(1, 0, v);
u = TempoClock(0.4, 0, v);

// start two functions at beat zero in each clock.
t.schedAbs(0, { arg beat, sec; [\t, beat, sec].postln; 1 });
u.schedAbs(0, { arg beat, sec; [\u, beat, sec].postln; 1 });
)


(
u.tempo = u.tempo * 3;
t.tempo = t.tempo * 3;
)

(
u.tempo = u.tempo * 1/4;
t.tempo = t.tempo * 1/4;
)


(
t.stop;
u.stop;
)

////////////////////////

(
// get elapsed time, round up to next second
v = Main.elapsedTime.ceil;

// create two clocks, starting at time v.
t = TempoClock(1, 0, v);
u = TempoClock(1, 0, v);

// start two functions at beat zero in each clock.
// t controls u's tempo. They should stay in sync.
t.schedAbs(0, { arg beat, sec; u.tempo = t.tempo * [1,2,3,4,5].choose; [\t, beat, sec].postln; 1 });
u.schedAbs(0, { arg beat, sec; [\u, beat, sec].postln; 1 });
)


(
u.tempo = u.tempo * 3;
t.tempo = t.tempo * 3;
)

(
u.tempo = u.tempo * 1/4;
t.tempo = t.tempo * 1/4;
)


(
t.stop;
u.stop;
)


