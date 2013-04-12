CCResponder

see also MIDIResponder

CCResponder(function, src, chan, num, value, install = true,swallowEvent = false)

src
	The src number may be the system UID (obtained from MIDIClient.sources[index].uid) 
	or the index of the source in the MIDIClient.sources array.
	nil matches all
chan
	0 .. 15
	nil matches all
num
	0 .. 127
	nil matches all
value
	0 .. 127
	nil matches all

any of these may also be a function which will be evaluated to determine the match:
	eg: { |val| val < 50 }
	
(
	c = CCResponder({ |src,chan,num,value|
		[src,chan,num,value].postln;
		},
		nil, // any source
		nil, // any channel
		nil, // any CC number
		nil // any value
	)
)

c.remove


(
	c = CCResponder({ |src,chan,num,value|
		[src,chan,num,value].postln;
		},
		nil, // any source
		nil, // any channel
		80, // CC number 80
		{ |val| val < 50 } // any value less than 50
	)
)

c.remove


learn

wait for the next CC message, reset to match src,chan, cc num
(

	c = CCResponder({ |src,chan,num,value|
		[src,chan,num,value].postln;
		});
	c.learn; // wait for the first controller
)
CCResponder.removeAll




