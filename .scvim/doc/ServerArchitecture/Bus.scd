Bus				representation of a bus on the server

The clientside representation of an audio or control bus on a server.  Encapsulates all the OSC messages a Bus can receive.  Manages allocation and deallocation of bus indices so that you don't need to worry about conflicts. The number of control busses, audio busses, and input and output busses is fixed and cannot be changed after the server has been booted. For more information see ClientVsServer and Server-Architecture.

Note that using the Bus class to allocate a multichannel bus does not 'create' a multichannel bus, but rather simply reserves a series of adjacent bus indices with the bus' Server object's bus allocators. abus.index simply returns the first of those indices. When using a Bus with an In or Out ugen there is nothing to stop you from reading to or writing from a larger range, or from hardcoding to a bus that has been allocated. You are responsible for making sure that the number of channels match and that there are no conflicts.

Bus objects should not be created or modified within a SynthDef.

Note: The lowest n bus indices are reserved for hardware output and input, where n = server.options.numOutputBusChannels + server.options.numInputBusChannels.

Hardware output buses: 0 .. (numOutputBusChannels - 1)
Hardware input buses: numOutputBusChannels .. (numOutputBusChannels + numInputBusChannels - 1)
First private bus index: numOutputBusChannels + numInputBusChannels

Do not try to use hardware I/O buses as private buses.


Class Methods

Bus.control(server, numChannels);
	Allocate a control bus on the server.  
	Defaults: default server, 1 channel.
	
Bus.audio(server, numChannels);
	Allocate an audio bus on the server. 
	Defaults: default server, 1 channel.
	
Bus.alloc(rate, server, numChannels);
	Allocate a bus of either rate as specified by the symbols: 
		\control or \audio
		
Bus.new(rate, index, numChannels);
	This method does not allocate a bus index, but assumes that you
	already have allocated the appropriate bus index and can supply it
	yourself.
		
Bus.newFrom(bus, offset, numChannels=1);
	This method creates a new Bus that is a subset of the bus. The bus will be at the same rate as the input bus.
	offset is the index into the given bus. numChannels is the desired number of channels.
	If the combination of offset and numChannels is outside the input bus' range, an error will be thrown.
	

Instance Methods

index - Get the Bus' index. Normally you should not need to do this since instances of Bus can be passed directly as UGen inputs or Synth args.
	
free - Return the bus' indices to the server's bus allocator so they can be reallocated.
	
rate - Get the Bus' rate. This is a symbol, either \control or \audio.
	
numChannels - Get the Bus' number of channels.

server - Get the Bus' server object.

asMap - Returns a symbol consisting of the letter 'c' or 'a' (for control or audio) followed by the bus's index. This may be used when setting a synth node's control inputs to map the input to the control bus. See the Node help file for more information on mapping controls to buses. 

	
(
a = Bus.control(s, 1).set(440);
b = Bus.control(s, 1).set(0.01);
)
(
SynthDef(\rlpf, { |ffreq, rq|
	Out.ar(0, RLPF.ar(WhiteNoise.ar(0.2), ffreq, rq))
}).play(s, [\ffreq, a.asMap, \rq, b.asMap]);
)

subBus(offset,numChannels) - Get a new Bus that is a subset of this bus (see *newFrom).

Asynchronous Control Bus Methods

The following commands apply only to control buses and are asynchronous. For synchronous access to control buses one should use the internal server's shared control buses and SharedIn / SharedOut.

value_(aFloat) - Set all channels to this float value. This command is asynchronous.
	
set(...values) - A list of values for each channel of the control bus.  The list of values supplied should not be greater than the number of channels. This command is asynchronous.

setn(values) - As set but takes an array as an argument.
	
get(action) - Get the current value of this control bus. This command is asynchronous. action is a function that will be evaluated when the server responds, with the current value of the bus passed as an argument. This will be a float for a single channel bus, or an array of floats for a multichannel bus. The default action posts the bus values.

getn(count, action) - Get the current values of this control bus. This command is asynchronous. count is the number of channels to read, starting from this bus' first channel. action is a function that will be evaluated when the server responds, with the current values of the bus in an array passed as an argument.

	conveniences for multichannel buses: 
setAt(offset, value1, value2, ... valueN) - set the bus value(s) beginning at offset. asynchronous.

setnAt(pos, values) - set the bus to the list of values supplied. asynchronous.

setPairs(index1, value1, index2, value2 ... indexN, valueN) - set the bus values by pairs of index, value, index value. asynchronous

Using Buses like UGens

kr(numChannels, offset),
ar(numChannels, offset) - use a bus like a UGen. The numChannels and offset arguments can be used to get a subset of the bus.
	By default, all the bus channels are used. E.g. in an 8 channel bus, 
		b.kr will return an In ugen reading from all the 8 channels of the bus; 
		b.kr(4) will return the first four channels, and 
		b.kr(2, 5) will return two channels, starting from the bus's channels at index 5 and 6. 


OSC Bundle Methods

getMsg - Returns a msg of the type /c_get for use in osc bundles.

getnMsg(count) - Returns a msg of the type /c_getn for use in osc bundles. count is the number of channels to read, starting from this bus' first channel. The default is this bus' numChannels.

setMsg(... values) - Returns a msg of the type /c_set for use in osc bundles.

setnMsg(values) - Returns a msg of the type /c_setn for use in osc bundles. values is a an array of values to which adjacent channels should be set, starting at this bus' first channel. 

fillMsg(value) - Returns a msg of the type /c_fill for use in osc bundles. value is the value to which this bus' channels will be set.


Examples

s = Server.local;
s.boot;
	
(
// something to play with
SynthDef(\help_Bus, { arg out=0,ffreq=100;
	var x;
	x = RLPF.ar(LFPulse.ar(SinOsc.kr(0.2, 0, 10, 21), [0,0.1], 0.1),
			ffreq, 0.1)
			.clip2(0.4);
	Out.ar(out, x);
}).add;

)

x = Synth(\help_Bus);

// get a bus
b = Bus.control(s);

// map the synth's second input (ffreq) to read
// from the bus' output index
x.map(1, b);

// By setting the bus' value you send a /c_fill message
// to each channel of the bus setting it to supplied float value
b.value = 100;
b.value = 1000;
b.value = 30;

// Since this is a single channel bus this has the same effect
b.set(300);
b.numChannels.postln;

// multi-channel:  b.set(300,350);
// Get the current value. This is asynchronous so you can't rely on it happening immediately.
(
a = "waiting";
b.get({arg value; a = value; ("after the server responds a is set to:" + a).postln;});
("a is now:" + a).postln;
)

x.free;
	
	// buses can also be used with kr or ar like UGens: 
(

SynthDef(\help_Bus, {
	var ffreq = b.kr; 
	Out.ar(0, 
		RLPF.ar(
			LFPulse.ar(SinOsc.kr(0.2, 0, 10, 21), [0,0.1], 0.1), 
			ffreq, 0.1
		).clip2(0.4)
	);
}).play;
)

b.free; // release it so it may be reallocated!


// using and setting multichannel buses: 

(
b = Bus.control(s, 4);

x = SynthDef(\helpBusMulti, { 
	var freqs = b.kr;
	Out.ar(0, Splay.ar(SinOsc.ar(freqs) * Decay2.ar(Dust.ar(10 ! 4), 0.001, 0.1)) * 0.5);
}).play;
)

	// set bus beginning at index 0: 
	// none of these methods checks whether the indexes remain 
	// within the bus's range. 
	
b.set(234, 345, 456, 567);
b.getn;
b.setn([100, 200, 300, 400]);
b.getn;

	// get to individual channels
b.setAt(3, 500);
b.getn;
b.setAt(1, 300, 400);
b.getn;
b.setnAt(1, [250, 350]);
b.getn;
	// set by pairs of index, value ...
b.setPairs(3, 600, 0, 200);
b.getn;

b.set(300, 500, 700, 900);

(	// just get the first 2 channels
x = SynthDef(\helpBusMulti, { 
	Out.ar(0, SinOsc.ar(b.kr(2)) * 0.2);
}).play;
)
b.set(300, 303);
x.free;

(	// just channels[[2, 3]];
y = SynthDef(\helpBusMulti, { 
	Out.ar(0, LFNoise2.ar(b.kr(2, 2)) * 0.2);
}).play;
)
b.setAt(2, 1200);
b.setAt(3, 2400);

y.free;
b.free;



