Notes on MIDI support in SuperCollider

Contents

Introduction
Receiving MIDI input: MIDIResponder classes
Receiving MIDI input: MIDIIn
Playing notes on your MIDI keyboard 
Sending MIDI out
MIDI synchronization
Third party libraries

Introduction

SuperCollider's out of the box MIDI support is fairly thorough (although not as complete as you'll find in commercial sequencers). All MIDI devices accessible to your operating system (CoreMIDI on OSX, ALSA on Linux, PortMIDI on Windows) are accessible to SuperCollider. 

Note: This document is written from an OSX perspective. The essential behavior of the MIDI interface classes should be the same on other platforms, despite my continual reference to CoreMIDI here.

SuperCollider does not impose much higher-level structure on MIDI functionality. The core classes are little more than hardware abstractions (see also the MIDI helpfile):

MIDIClient: represents SuperCollider's communications with CoreMIDI
MIDIIn: receives MIDI messages and executes functions in response to those messages
MIDIOut: sends MIDI messages out to a specific port and channel
MIDIEndPoint: a client-side representation of a CoreMIDI device, containing three variables (name, device and uid, which is a unique identifier assigned by the system) 

In most cases, each physical MIDI connection (pair of in/out jacks on the MIDI interface) has one MIDIEndPoint object to represent it in the client. 

Receiving MIDI input: MIDIResponder classes

For most uses, the preferred way to receive MIDI input is using the MIDIResponder classes. The advantage of this approach is that any number of responders can be registered. (By contrast, using MIDIIn responder functions directly means that only one function can exist per incoming message type. That is not an ideal programming practice.)

Six types of MIDI responder exist, corresponding to the most common MIDI messages.They all have similar interfaces, described in the MIDIResponder help file. They can also filter incoming MIDI messages, to respond to a particular device, channel number, or specific parameter values.

NoteOnResponder
NoteOffResponder
CCResponder
BendResponder
TouchResponder
ProgramChangeResponder

See "Playing notes on your MIDI keyboard" below for a simple example using the note-on and note-off responders.

Receiving MIDI input: MIDIIn

MIDIIn has a number of class variables holding functions to be evaluated when a MIDI event comes in. Technical details on each function can be found in the MIDIIn help file.

noteOn
noteOff
control
bend
touch
polyTouch
program
sysex
sysrt
smpte 

To assign a response to a particular kind of MIDI message, assign a function to the class variable: 

MIDIIn.connect;
MIDIIn.noteOn = { |port, chan, note, vel| [port, chan, note, vel].postln }; 
MIDIIn.noteOn = nil;  // stop responding

MIDIIn provides the responding functions with all the information coming in from CoreMIDI:

source (src): corresponds to the uid of the MIDIEndPont from which the message is coming.
channel (chan): integer 0-15 representing the channel bits of the MIDI status byte

... with subsequent arguments representing the data bytes. The MIDIIn help file details all the supported messages along with the arguments of the responding function for the message. 

Because these are class variables, you can have only one function assigned at one time. A common usage is to assign a function that looks up responses in a collection. For example, you could have a separate set of response functions for each channel.

~noteOn = Array.fill(16, IdentityDictionary.new);
MIDIIn.noteOn = { |port, chan, num, vel| ~noteOn[chan].do(_.value(port, chan, num, vel)) };

   // this function will respond only on channel 0
~noteOn[0].put(\postNoteOn, { |port, chan, num, vel| [port, chan, note, vel].postln });
~noteOn[0].removeAt(\postNoteOn);  // stop responding

The advantage of this approach over using "if" or "case" statements in the response function is that you can add and remove responses without having to change the MIDIIn function. The MIDIIn function can serve as a "hook" into another structure that distributes the MIDI events to the real responders.

Playing notes on your MIDI keyboard 

The technical problem is that every note on needs to save its synth object so that the note off message can end the right server-side node. 

s.boot;

(
var notes, on, off;

//MIDIIn.connect;

notes = Array.newClear(128);  // array has one slot per possible MIDI note

on = NoteOnResponder({ |src, chan, num, veloc|
	notes[num] = Synth(\default, [\freq, num.midicps,
		\amp, veloc * 0.00315]);
});

off = NoteOffResponder({ |src, chan, num, veloc|
	notes[num].release;
});

q = { on.remove; off.remove; };
)

// when done:
q.value;

The MIDIIn help file contains a more elaborate example.

SuperCollider does not have a built-in class to handle this automatically. However, dewdrop_lib, a third party libraries mentioned below, includes Voicer (to simplify note on-off bookkeeping) and VoicerMIDISocket (to trigger Voicer notes by MIDI). Users interested in this functionality may wish to examine that library.

Sending MIDI out

See the MIDIOut helpfile. Unlike MIDIIn, with MIDIOut you create an instance of the MIDIOut class with a port and uid. You can have multiple MIDIOut objects to send MIDI to different physical devices.

Many users have reported timing issues with MIDIOut. When the CPU is busy, especially during graphics updates, outgoing MIDI messages may be delayed. Use with caution in a performance situation.

MIDI synchronization

MIDI synchronization may be performed using MIDIIn's sysrt or smpte response functions. It's up to the user to implement the desired kind of synchronization.

For sysrt, external MIDI clocks output 24 pulses per quarter note. The responder should count the incoming pulses and multiply the rhythmic value into 24 to determine how many pulses to wait:

0.25		wait 6 pulses (16th note)
0.5		wait 12 pulses (8th note)
2		wait 48 pulses (half note)

dewdrop_lib (third party library) includes a class, MIDISyncClock, that receives MIDI clock messages and allows events to be scheduled to keep time with an external MIDI device. See the [MIDISyncClock] helpfile for details.

There are significant limitations, discussed in the helpfile. This is not really a fully supported class, but it's there for users who need rudimentary MIDI sync functionality.

Third party libraries

dewdrop_lib is a third party library providing a number of useful performance features, available through the Quarks interface. The library provides a user-extensible framework of MIDI responder classes designed for multiport, multichannel applications. 

Among its features:

- user-extensible: simple functions may be used, and frequently-needed responses can be written into classes that inherit from the framework (see [BasicMIDISocket] and [BasicMIDIControl])

- easy to use classes for playing MIDI notes and assigning MIDI controllers to synthesis parameters

- a user-configurable array of MIDI controller numbers, to simplify assignment of events to hardware controllers


