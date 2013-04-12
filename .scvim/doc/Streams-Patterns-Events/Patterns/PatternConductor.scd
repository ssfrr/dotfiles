PatternConductor

superclass: Object

PatternConductor provides a simple interactive control (supporting play, pause, resume, stop) 
for playing pattern, much like Pattern-play.  However, PatternConductor creates its own clock and
directly controls the release of sounding notes as well as their initiation by the pattern.

Class Methods

	*new(pattern, event, quant)

Instance Methods

	tempo_(tempo)
	Sets the tempo of the PatternConductor
	play 
	Play the pattern.  A TempoClock is created, its tempo is set to the PatternConductor tempo, 
	and the pattern is played using that clock. if quant is non-zero, this is synchronized with 
	TempoClock.default at the specified quantization. 
	pause(pauseTempo = 0.000001) 
	Pause the pattern, sustaining notes indefinitely.  
		a subsequent resume will return to the original tempo (so the notes will  end as scheduled).  
		a subsequent play will cut-off any sounding notes and resume play at the original tempo.
	stop(stopTempo)  can cut-off or shorten sounding notes, depending on the value of tempo.
 		If stopTempo is nil, all notes are cut-off immediately.  Otherwise, notes end at the specified tempo.
	
example:


(
 
 // a pattern with long notes 
  p = Pbind(
  		\freq, Pwhite(0,log(32)).exp.round(1) * 36.midicps, 
  		\detune, Pfunc({ | ev | ev[\freq]  * rand(0.01) }), 
  		\sustain, Pwhite(log(0.1), log(20)).exp,
  		\dur, Prand([0.1,0.1,0.1,0.1,0.2,1,2],inf),
  		\db, Pstep(Pseq([-20,-30,-25,-30], inf),0.2)
	);


// unrelated cluster pattern running on TempoClock.default
Pbind(\dur,2, \midinote, Pseq([(48..60)],20), \db, -30).play;

// make a conductor	
a = PatternConductor(p, quant: 2);
a.play;
)



// now try some interactive control options line by line:
a.quant = 0;
a.pause;
a.resume;
a.stop;
a.play;
a.pause;
a.play;
a.stop(1000);



