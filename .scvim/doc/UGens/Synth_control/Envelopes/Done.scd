Done			monitors another UGen to see when it is finished 

Done.kr(src)

Some UGens, such as PlayBuf, RecordBuf, Line, XLine, EnvGen, Linen, BufRd, BufWr, DbufRd, and the Buffer delay UGens set a 'done' flag when they are finished playing. This UGen echoes that flag when it is set to track a particular UGen. 

src - UGen to monitor

//example

(
SynthDef("Done-help", { arg out, t_trig;
	var line, a, b; 
	
	line= Line.kr(1,0,1);
	
	a= SinOsc.ar(440,0,0.1*line); //sound fading out
	b= WhiteNoise.ar(Done.kr(line)*0.1); //noise starts at end of line
	
	Out.ar(out, Pan2.ar(a+b));
}).send(s);
)

Synth("Done-help"); //note that this synth doesn't have it's own doneAction, so you'll need to manually deallocate it
	


