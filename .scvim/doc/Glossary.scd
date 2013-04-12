Glossary

buffer - A server-side header and array of 32 bit floating point sample data. Buffers are used for sound files, delay lines, arrays of global controls, and arrays of inter-synth patch points. Represented by the client-side class Buffer.

class - A description of the state and behaviour of a set of objects.

client - SC is divided into two separate applications: The client and the server. The client is where the supercollider language is implemented and where one executes code. The server actually synthesizes the audio, contains the node tree of synths and groups and responds to Open Sound Control messages from the client. See ClientVsServer for more information.

group - A linked list of nodes. Groups provide ways to control execution of many nodes at once. A group is a kind of node. Colloquially one can understand a group as an ordered grouping of other nodes, which may include both synths and other groups. Represented by the client-side class Group.

interface - The set of messages to which an object responds.

instance - One of the objects described by a class.

instance variable - A part of an object's internal state

message	- A request for an object to perform an operation.

method - A description of the operations necessary to implement a message for a particular class.

MIDI - A protocol for sending music control data between synthesizers.

node - One point in a tree of nodes executed in a depth first traversal order by the synth engine. There are two types of nodes, synths and groups. These are represented by the client-side classes Synth and Group, and their abstract superclass Node. The node tree defines the order of execution for synths.

object - Something that has data, representing the object's state, and a set of operations that can be performed on the object.

Open Sound Control - a protocol defined by CNMAT at UCBerkeley for controlling synthesizers. See http://opensoundcontrol.org/. SuperCollider communicates between the client and server using OSC messages over UDP or TCP.

OSC - See Open Sound Control.

polymorphism	- The ability for different kinds of objects to respond differently to the same message.

protocol - A set of messages that implement a specific kind of behaviour.

receiver - The object to which a message is sent.

server - SC is divided into two separate applications: The client and the server. The client is where the supercollider language is implemented and where one executes code. The server actually synthesizes the audio, contains the node tree of synths and groups and responds to Open Sound Control messages from the client. See ClientVsServer for more information.

synth - A sound processing module, based upon a particular synth definition. Similar to "voice " in other systems. Synths are referred to by a number. Represented by the client-side class Synth.

synth definition - A definition for creating new synths. Synth definitions are like a pattern or design for synths. Similar to "instrument" in other systems. Represented by the client-side class SynthDef.

TCP - A protocol for streaming data over a network.

UDP - A protocol for sending datagrams over a network.


