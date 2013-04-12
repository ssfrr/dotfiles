NoteOnResponder

see also MIDIResponder

NoteOnResponder(function, src, chan, num, value, install = true,swallowEvent = false)

(
	c = NoteOnResponder({ |src,chan,note,vel|
		[src,chan,note,vel].postln;
		},
		nil, // any source
		nil, // any channel
		nil, // any note
		nil // any vel
	)
)

c.remove


(
	c = NoteOnResponder({ |src,chan,num,value|
		[src,chan,num,value].postln;
		},
		nil, // any source
		nil, // any channel
		(50..60), // within this note range
		nil // any vel
	)
)

c.remove

learn

wait for the next midi note.  reset self to match to that src and chan
(
	c = NoteOnResponder({ |src,chan,num,value|
		[src,chan,num,value].postln;
		});
	c.learn; // wait for the first note
)

NoteOnResponder.removeAll



