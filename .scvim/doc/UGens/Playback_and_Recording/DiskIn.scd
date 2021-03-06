DiskIn				stream in audio from a file
add

DiskIn.ar(numChannels, bufnum, loop )

Continuously play a longer soundfile from disk.  This requires a buffer to be preloaded with one buffer size of sound. If loop is set to 1, the soundfile will loop.

See also: PlayBuf, BufRd 

s.boot; // start the server

(
SynthDef("help-Diskin", { arg bufnum = 0;
	Out.ar(0, DiskIn.ar(1, bufnum, 1));
}).add
)

Using Buffer (Object Style)

b = Buffer.cueSoundFile(s, "sounds/a11wlk01-44_1.aiff", 0, 1);

x = { DiskIn.ar(1, b) }.play;

b.close;	

// again
// note the like named instance method, but different arguments
b.cueSoundFile("sounds/a11wlk01-44_1.aiff", 0);	
	
x.free; b.close; b.free;	



// loop it (for better looping use PlayBuf!)
(
p = "sounds/a11wlk01-44_1.aiff";
a = SoundFile.new;
a.openRead(p);
d = a.numFrames/s.sampleRate; // get the duration
a.close; // don't forget
b = Buffer.cueSoundFile(s, p, 0, 1);
f = { DiskIn.ar(1, b) };
x = f.play;
r = Routine({
	loop({ d.wait; x.free; x = f.play; b.close( b.cueSoundFileMsg(p, 0)) });
}).play;
)
r.stop; x.free; b.close; b.free; // you need to do all these to properly cleanup



// cue and play right away
(
SynthDef("help-Diskin", { arg bufnum = 0;
	Out.ar(0, DiskIn.ar(1, bufnum));
}).add;
)
(		
x = Synth.basicNew("help-Diskin");
m = { arg buf; x.addToHeadMsg(nil, [\bufnum, buf])};

b = Buffer.cueSoundFile(s,"sounds/a11wlk01-44_1.aiff",0,1, completionMessage: m);
)		

x.free; b.close; b.free;	//clean up



OSC Messaging Style

// allocate a disk i/o buffer
s.sendMsg("/b_alloc", 0, 65536, 1);

// open an input file for this buffer, leave it open
s.sendMsg("/b_read", 0, "sounds/a11wlk01-44_1.aiff", 0, 65536, 0, 1);

// create a diskin node
s.sendMsg("/s_new", "help-Diskin", x = s.nextNodeID, 1, 1);

s.sendMsg("/b_close", 0); // close the file (very important!)


// again 
// don't need to reallocate and Synth is still reading
s.sendMsg("/b_read", 0, "sounds/a11wlk01-44_1.aiff", 0, 0, 0, 1);

s.sendMsg("/n_free", x); // stop reading

s.sendMsg("/b_close", 0); // close the file.

s.sendMsg("/b_free", 0); // frees the buffer



