RecordBuf		record or overdub into a Buffer

Records input into a Buffer.

RecordBuf.ar(inputArray, bufnum, offset, recLevel, preLevel, run, loop, trigger, doneAction)
RecordBuf.kr(inputArray, bufnum, offset, recLevel, preLevel, run, loop, trigger, doneAction)

If recLevel is 1.0 and preLevel is 0.0 then the new input overwrites the old data.
If they are both 1.0 then the new data is added to the existing data. (Any other settings
are also valid.)

	inputArray - an Array of input channels
	bufnum - the index of the buffer to use
	offset   - an offset into the buffer in frames, the default is 0.0.
	recLevel - value to multiply by input before mixing with existing data. Default is 1.0.
	preLevel - value to multiply to existing data in buffer before mixing with input. Default is 0.0.
	run - If zero, then recording stops, otherwise recording proceeds. Default is 1.
	loop  - If zero then don't loop, otherwise do.  This is modulate-able. Default is 1.
	trigger - a trigger causes a jump to the offset position in the Buffer. 
		A trigger occurs when a signal changes from <= 0 to > 0.
	doneAction - an integer representing an action to be executed when the buffer is finished playing. This can be used to free the enclosing synth, etc. See UGen-doneActions for more detail.
		doneAction is only evaluated if loop is 0.


Note that the number of channels must be fixed for the SynthDef, it cannot vary depending on which buffer you use.

// Execute the following in order
(
// allocate a Buffer
s = Server.local;
b = Buffer.alloc(s, 44100 * 4.0, 1); // a four second 1 channel Buffer
)

// record for four seconds
(
SynthDef(\help_RecordBuf, { arg out = 0, bufnum = 0;
	var formant;
	formant = Formant.ar(XLine.kr(400,1000, 4), 2000, 800, 0.125);
	RecordBuf.ar(formant, bufnum, doneAction: 2, loop: 0);
}).play(s,[\out, 0, \bufnum, b]);
)

// play it back
(
SynthDef(\help_RecordBuf_overdub, { arg out = 0, bufnum = 0;
	var playbuf;
	playbuf = PlayBuf.ar(1,bufnum);
	FreeSelfWhenDone.kr(playbuf); // frees the synth when the PlayBuf is finished
	Out.ar(out, playbuf);
}).play(s, [\out, 0, \bufnum, b]);
)

// overdub
(
SynthDef(\help_RecordBuf_overdub, { arg out=0, bufnum=0;
	var formant;
	formant = Formant.ar(XLine.kr(200, 1000, 4), 2000, 800, 0.125);
	// mixes equally with existing data
	RecordBuf.ar(formant, bufnum, 0, 0.5, 0.5, doneAction: 2, loop: 0); 
}).play(s, [\out, 0, \bufnum, b]);
)

// play back the overdubbed version
Synth.new(\help_RecordBuf_overdub, [\out, 0, \bufnum, b], s);

// write the contents of the buffer to a file (see Buffer for more options)
(
b.write(sampleFormat: 'int16');
thisProcess.platform.recordingsDir +/+ "SC_" ++ Date.localtime.stamp ++ ".aiff"; // generated path
)


b.close; b.free; // cleanup




