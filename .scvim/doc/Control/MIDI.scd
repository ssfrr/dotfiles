MIDI

MIDIClient
MIDIEndpoint
MIDIIn
MIDIOut
superclass: Object

See the [UsingMIDI] helpfile for practical considerations and techniques for using MIDI in SC.

MIDIClient is a static class that starts up the MIDI service:
It initializes with a number of virtual inports and outports.
The default is 1. and usually not more a needed.
The information about the hardware is stored in MIDIClient.sources and MIDIClient.destinations as MIDIEndpoints.

MIDIIn represents a connection between a inport and a source of the MIDIClient.
There are three possibilities to connect them:
To do something with the incoming MIDI data set the actions.

example:
(
MIDIClient.init;
//There are three possibilities to connect for example to the first device:
//MIDIIn.connect(0, MIDIClient.sources.at(0));
//MIDIIn.connect(0, MIDIClient.sources.at(0).uid);
MIDIIn.connect(0, 0);
//set the action:
MIDIIn.control = {arg src, chan, num, val;
			val.postln;
			};
)

MIDIOut

example:
(
MIDIClient.init;
m = MIDIOut(0, MIDIClient.destinations.at(0).uid);
m.noteOn(0, 60, 60);
) 


)


