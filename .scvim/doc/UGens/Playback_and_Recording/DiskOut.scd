DiskOut

DiskOut.ar(bufnum, channelsArray)

Record to a soundfile to disk. Uses a Buffer.
bufnum - the number of the buffer to write to (prepared with /b-write or Buffer.write) 
channelsArray - the Array of channels to write to the file.

The output of DiskOut is the number of frames written to disk.

Note that the number of channels in the buffer and the channelsArray must be the same, otherwise DiskOut will fail silently (and not write anything to your file).


s.boot; // start the server
(
// something to record
SynthDef("bubbles", {
	var f, zout;
	f = LFSaw.kr(0.4, 0, 24, LFSaw.kr([8,7.23], 0, 3, 80)).midicps; // glissando function
	zout = CombN.ar(SinOsc.ar(f, 0, 0.04), 0.2, 0.2, 4); // echoing sine wave
	Out.ar(0, zout);
}).send(s);

// this will record to the disk
SynthDef("help-Diskout", {arg bufnum;
	DiskOut.ar(bufnum, In.ar(0,2));
}).send(s);

// this will play it back
SynthDef("help-Diskin-2chan", { arg bufnum = 0;
	Out.ar(0, DiskIn.ar(2, bufnum));
}).send(s);
)

Object Style:

// start something to record
x = Synth.new("bubbles");

// allocate a disk i/o buffer
b= Buffer.alloc(s, 65536, 2);

// create an output file for this buffer, leave it open
b.write("~/diskouttest.aiff".standardizePath, "aiff", "int16", 0, 0, true);
// create the diskout node; making sure it comes after the source
d = Synth.tail(nil, "help-Diskout", ["bufnum", b]);
// stop recording
d.free;
// stop the bubbles
x.free;
// close the buffer and the soundfile
b.close;
// free the buffer
b.free;

// play it back
(
x = Synth.basicNew("help-Diskin-2chan");
m = { arg buf; x.addToHeadMsg(nil, [\bufnum,buf])};

b = Buffer.cueSoundFile(s,"~/diskouttest.aiff".standardizePath, 0, 2, completionMessage: m);
)
x.free; b.close; b.free; // cleanup

Messaging Style:

// The same thing done in Messaging Style (less overhead but without the convienence of objects)
// start something to record
s.sendMsg("/s_new", "bubbles", 2003, 1, 1);

// allocate a disk i/o buffer
s.sendMsg("/b_alloc", 0, 65536, 2); // Buffer number is 0

// create an output file for this buffer, leave it open
s.sendMsg("/b_write", 0, "~/diskouttest.aiff".standardizePath, "aiff", "int16", 0, 0, 1);

// create the diskout node
s.sendMsg("/s_new", "help-Diskout", 2004, 3, 2003, "bufnum", 0);

s.sendMsg("/n_free", 2004); // stop recording
s.sendMsg("/n_free", 2003); // stop the bubbles

s.sendMsg("/b_close", 0); // close the file.
s.sendMsg("/b_free", 0);


See RecordBuf for recording into a buffer in memory.







