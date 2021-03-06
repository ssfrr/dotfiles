MIDIResponder

Register multiple functions to be evaluated when MIDI events occur.

MIDIResponder is an abstract class. Its subclasses allow functions to be registered to respond to midi events.

Read the general help file here and then see the individual help files.

CCResponder			Respond to control messages
NoteOnResponder		Respond to note-on messages
NoteOffResponder		Respond to note-off messages
BendResponder		Respond to pitch bend messages
TouchResponder		Respond to aftertouch messages


Creation and initialization:

CCResponder(function, src, chan, num, value, install = true,swallowEvent = false)
NoteOnResponder(function, src, chan, num, veloc, install = true,swallowEvent = false)
NoteOffResponder(function, src, chan, num, veloc, install = true,swallowEvent = false)
BendResponder(function, src, chan, value, install = true,swallowEvent = false)
TouchResponder(function, src, chan, value, install = true,swallowEvent = false)

function: The function to execute when the incoming MIDI event matches the responder. The function takes the arguments src, chan, A, B (or for Bend and Touch, src, chan, value).
src: If a number is given, the responder will fire only for messages coming in from this port. The number may be the system UID (obtained from MIDIClient.sources[index].uid) or the index itself. If nil, the responder will match any port.
chan: The MIDI channel(s) to match.
num: The control or note number(s) to match.
value: The value(s) to match.
veloc: The velocities to match.
install: If true, install the responder automatically so it is active and ready to respond. 
	If false, then it will be inactive.
swallowEvent: if true, then if the midi event is matched, cease testing any further responders.
	eg. if a CCResponder matches port, chan and num, and swallowEvent is set to true,
	then no further CCResponders will be offered the chance to respond to the event.  The event is 
	"swallowed".
	by default this is false.
	
Any of the matching values may be one of the following:

Nil:		Match anything.  eg. If chan is nil, then respond to any midi channel.
Integer:	Match only this specific number.
Array:	Match any item in the array. Any kind of Collection will work here.
Function:	Evaluate the function with the incoming value as the argument. The function should return true or false.

For instance, the following example would respond to note on messages from any port, channels 2 and 7 only, even numbered note numbers only, and only velocity values greater than 50. 

NoteOnResponder({ |src, chan, num, vel| [src, chan, num, vel].postln }, 
	nil, // any port
	[2, 7], // midi channels 2 or 7 only
	(0, 2..126),		// this is an array of even numbers.  could also be specified as { |num| num.even } or _.even
	{ |vel| vel > 50 }); // velocities greater than 50

MIDIResponders automatically initialize the MIDIClient with 1 standard device.  This means the first time you install any MIDIResponder, it will make sure that MIDI has been initialized.  If you have more devices or a specific setup, simply initialize the MIDIClient yourself before using any MIDIResponders.

learn

CCResponder, NoteOnResponder, NoteOffResponder, BendResponder and TouchResponder can be set to learn mode and will wait for the next event.



Removal:

Just call .remove on the responder.

c = CCResponder({ ... }, num: 1);	// respond to any modwheel

c.remove;		// stop this responder

Or remove all of a specific class:

CCResponder.removeAll
NoteOnResponder.removeAll
NoteOffResponder.removeAll
BendResponder.removeAll
TouchResponder.removeAll

or remove all midi responders in all classes:

MIDIResponder.removeAll






