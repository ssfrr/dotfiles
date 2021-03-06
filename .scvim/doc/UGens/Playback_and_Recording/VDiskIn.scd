VDiskIn				stream in audio from a file (with variable rate)


VDiskIn.ar(numChannels, bufnum, rate, loop, sendID )

Continuously play a longer soundfile from disk.  This requires a buffer to be preloaded with one buffer size of sound. If loop is set to 1, the soundfile will loop. If a sendID is given, the UGen sends an osc message with this id and the file position each time it reloads the buffer: ['/diskin', nodeID, sendID, frame] 

rate controls the rate of playback. Values below 4 are probably fine, but the higher the value, the more disk activity there is, and the more likelihood there will be a problem.

WARNING: the rate does have a practical limit. The following must be true: 
	rate  < Buffer's size / ( 2 * s.options.blockSize)
	e.g with typical default values, this wil be 32768 / (2 * 64) = 256.
	
If the rate is too high, the UGen will not execute, posting a warning.


See also: PlayBuf, BufRd 





b = Buffer.cueSoundFile(s, "sounds/a11wlk01-44_1.aiff", 0, 1);

x = { VDiskIn.ar(1, b, LFNoise2.kr(0.2).range(0.5, 2), 1, loop:1) }.play;

b.close;	

// again
// note the like named instance method, but different arguments
b.cueSoundFile("sounds/a11wlk01-44_1.aiff", 0);	
	
x.free; b.close; b.free;	


// cue and play right away
(
SynthDef("help-VDiskin", { arg bufnum = 0;
	Out.ar(0, VDiskIn.ar(1, bufnum, MouseX.kr(0.5, 2.0)));
}).send(s);
)
(
x = Synth.basicNew("help-VDiskin");
m = { arg buf; x.addToHeadMsg(nil, [\bufnum, buf])};

b = Buffer.cueSoundFile(s,"sounds/a11wlk01-44_1.aiff",0,1, completionMessage: m);
)		

x.free; b.close; b.free;	// clean up




// sending back the file position.
// note:
// the ugen knows nothing of the loop (apply a modulo).
// if you load another file, you need to free the buffer and re-allocate it (see below)

b = Buffer.cueSoundFile(s, "sounds/a11wlk01-44_1.aiff", 0, 1, bufferSize: 4096);
c = SoundFile("sounds/a11wlk01-44_1.aiff").info;
x = { VDiskIn.ar(1, b, LFNoise2.kr(0.2).range(0.2, 0.9), 1, sendID: 14) }.play;

// register to receive this message

(
o = OSCresponder(s.addr,'/diskin',{ arg time,responder,msg;
	var sendID = msg[2];
	var index = msg[3];
	msg.postln;
	"id: % pos: % frames (% sec)\n"
		.postf(sendID, index % c.numFrames, (index % c.numFrames / c.sampleRate));
}).add
);

b.close; b.free;

b.alloc; b.cueSoundFile("sounds/a11wlk01-44_1.aiff", 0); c = SoundFile("sounds/a11wlk01-44_1.aiff").info;

x.free; b.close; b.free; o.remove; // clean up eventually






// the same example in OSC Messaging style, see [Node Messaging]

// allocate a disk i/o buffer
s.sendMsg("/b_alloc", 0, 65536, 1);

// open an input file for this buffer, leave it open
s.sendMsg("/b_read", 0, "sounds/a11wlk01-44_1.aiff", 0, 65536, 0, 1);

// create a diskin node
s.sendMsg("/s_new", "help-VDiskin", x = s.nextNodeID, 1, 1);

s.sendMsg("/b_close", 0); // close the file (very important!)


// again 
// don't need to reallocate and Synth is still reading
s.sendMsg("/b_read", 0, "sounds/a11wlk01-44_1.aiff", 0, 0, 0, 1);

s.sendMsg("/n_free", x); // stop reading

s.sendMsg("/b_close", 0); // close the file.

s.sendMsg("/b_free", 0); // frees the buffer



