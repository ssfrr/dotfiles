MIDIIn

This document explains technical details of the MIDI hardware interface class, MIDIIn.

MIDIIn is a simple and direct interface.  When MIDI events come into Super Collider, MIDIIn evaluates simple handler functions.

For general programming, users should not use the MIDIIn class directly.  See the MIDIResponder classes for higher level event matching and more flexible handling of event handlers.

Certain MIDI messages are supported only through MIDIIn. These are: polytouch, program, sysex, sysrt, smpte.

See the UsingMIDI helpfile for practical considerations and techniques for using MIDI in SC.

The MIDIIn class

MIDIIn links MIDI input received from the operating system to a set of user defined functions.
Only one set of MIDI input handling functions can be active at a time, they are stored in the
following class variables:

	noteOff, noteOn, polytouch, control, program, touch, bend, sysex, sysrt, smpte

The first argument these functions receive is an unique identifier that specifies the source of the data.

Quick start for 1 port:

(
	MIDIIn.connect; 	// init for one port midi interface
// register functions:	
	MIDIIn.noteOff = { arg src, chan, num, vel; 	[chan,num,vel / 127].postln; };
	MIDIIn.noteOn = { arg src, chan, num, vel; 	[chan,num,vel / 127].postln; };
	MIDIIn.polytouch = { arg src, chan, num, vel; 	[chan,num,vel / 127].postln; };
	MIDIIn.control = { arg src, chan, num, val; 	[chan,num,val].postln; };
	MIDIIn.program = { arg src, chan, prog; 		[chan,prog].postln; };
	MIDIIn.touch = { arg src, chan, pressure; 	[chan,pressure].postln; };
	MIDIIn.bend = { arg src, chan, bend; 			[chan,bend - 8192].postln; };
	MIDIIn.sysex = { arg src, sysex; 			sysex.postln; };
	MIDIIn.sysrt = { arg src, chan, val; 			[chan,val].postln; };
	MIDIIn.smpte = { arg src, chan, val; 			[chan,val].postln; };
)

Quick start for 2 or more ports:

(
	var inPorts = 2;
	var outPorts = 2;
	MIDIClient.init(inPorts,outPorts);			// explicitly intialize the client
	inPorts.do({ arg i; 
		MIDIIn.connect(i, MIDIClient.sources.at(i));
	});
)


class methods:
	 
 *findPort(deviceName,portName)
 	searches for a connected MIDIEndPoint by name
 	list connected ins:
	 	MIDIClient.sources

*noteOn_(function)
	function is evaluated whenever a MIDI noteOn message is received, it is passed the following arguments:
	uid						unique identifier of the MIDI port
	MIDIchannel				ranges from 0 to 15		
	keyNumber				0 - 127
	velocity					0 - 127	
*noteOff_(function)
	uid						unique identifier of the MIDI port
	MIDIchannel				ranges from 0 to 15		
	keyNumber				0 - 127
	velocity					0 - 127,	typically 64 unless noteOff velocity is supported
		
*polytouch_(function)
	uid						unique identifier of the MIDI port
	MIDIchannel				ranges from 0 to 15		
	keyNumber				0 - 127
	pressure					0 - 127
*control_(function)
	uid						unique identifier of the MIDI port
	MIDIchannel				ranges from 0 to 15		
	controllerNumber			0 - 127
	value					0 - 127
*program_(function)
	uid						unique identifier of the MIDI port
	MIDIchannel				ranges from 0 to 15		
	programNumber			0 - 127
*touch_(function)
	uid						unique identifier of the MIDI port
	MIDIchannel				ranges from 0 to 15		
	pressure					0 - 127
*bend_(function)
	uid						unique identifier of the MIDI port
	MIDIchannel				ranges from 0 to 15		
	bend					0..16384,   the  midpoint is 8192
*sysex_(function)
	uid						unique identifier of the MIDI port
	system exclusive data		an Int8Array (includes f0 and f7) 
							see manufacturer references for details
	note: The current implementation  assembles a complete system exclusive packet
 before evaluating the function.
*sysrt_(function)
	uid						unique identifier of the MIDI port
	index					ranges from 0 to 15		
	data						0 - 127
	
	index		data			message
	2			14bits		song pointer	
	3 			7bits			song select
	8						midiclock
	10						start
	11						continue
	12						stop

*smpte
	uid						unique identifier of the MIDI port
	index					ranges from 0 to 7	
	data						4 bits
	
	Over MIDI, SMPTE is transmitted at 1/4 frame intervals four times faster than the frame rate.
		index				data
		0					frames low nibble
		1					frames hi nibble
		2					seconds low nibble
		3					seconds hi nibble
		4					minutes low nibble
		5					minutes hi nibble
		6					hours low nibble
		7					hours hi bit OR'ed with frameRate
							0 -> 24fps
							2 -> 25 fps
							4 -> 30 fps drop frame
							6 -> 30 fps
		Nibbles are sent in ascending order, 
	

(
MIDIIn.connect;
s = Server.local;
s.boot;
s.latency = 0;

SynthDef("sik-goo", { arg freq=440,formfreq=100,gate=0.0,bwfreq=800;
	var x;
	x = Formant.ar(
			SinOsc.kr(0.02, 0, 10, freq), 
			formfreq,
			bwfreq
			);
	x = EnvGen.kr(Env.adsr, gate,Latch.kr(gate,gate)) * x;
	Out.ar(0, x);
}).send(s);

x = Synth("sik-goo");

//set the action:
MIDIIn.noteOn = {arg src, chan, num, vel;
				x.set(\freq, num.midicps / 4.0);
				x.set(\gate, vel / 200 );
				x.set(\formfreq, vel / 127 * 1000);
			};
MIDIIn.noteOff = { arg src,chan,num,vel;
				x.set(\gate, 0.0);
			};
MIDIIn.bend = { arg src,chan,val;
				//(val * 0.048828125).postln;
				x.set(\bwfreq, val * 0.048828125 );
			};
)





//i used this and got acceptable latency for triggering synths live.
//The latency might actually be less than sc2, but i haven't used it enough
//to tell for sure yet.
//Powerbook G4, 512mb ram.
- matrix6k@somahq.com


writing to the bus rather than directly to the synth

s = Server.local;
s.boot;

(
s.latency = 0;
SynthDef("moto-rev", { arg ffreq=100;
	var x;
	x = RLPF.ar(LFPulse.ar(SinOsc.kr(0.2, 0, 10, 21), [0,0.1], 0.1),
			 ffreq, 0.1)
			 .clip2(0.4);
	Out.ar(0, x);
}).send(s);

b = Bus.control(s);

x = Synth("moto-rev");

// map the synth's first input (ffreq) to read
// from the bus' output index
x.map(0, b);


MIDIIn.connect;
//set the action:
MIDIIn.noteOn = {arg src, chan, num, vel;
				b.value = num.midicps.postln;
			};

MIDIIn.control = {arg src, chan, num, val;
				[chan,num,val].postln;
			};
MIDIIn.bend = {arg src, chan, val;
				val.postln;
			};
)

// cleanup
x.free;
b.free;



Keyboard Split for two voices
pbend to cutoff, mod to rez, 7 to amp
// - matrix6k@somahq.com
prepare

s.boot;
(
SynthDef("funk",{ arg freq = 700, amp = 0.2, gate = 1, cutoff = 20000, rez = 1, lfospeed=0;
     var e,x,env,range,filterfreq;
	e = Env.new([0, 0.1, 0.1, 0], [0, 0.1, 0.1], 'linear', 2);
	env=Env.adsr(0.3,1,1,1);
	range = cutoff -1;
	filterfreq = SinOsc.kr(lfospeed,0, range, cutoff).abs;
	x = RLPF.ar(Mix.ar([
			Mix.arFill(2, {Saw.ar(freq *2 + 0.2.rand2, amp)}),
			Mix.arFill(2, {Saw.ar(freq *4+ 0.2.rand2, amp)})
			]),
			EnvGen.kr(env,gate)*filterfreq,
			rez);
     Out.ar([0,1],x * EnvGen.kr(e, gate, doneAction: 2))

}).send(s);

SynthDef("strings",{ arg freq = 700, amp = 0.2, gate = 1;
     var x,enve;
	enve = Env.new([0, 0.1, 0.1, 0], [2, 0.1, 1], 'linear', 2);
	x = RLPF.ar(Mix.ar([
					Mix.arFill(2, {Saw.ar(freq +2.rand2,0.6)}),
					Mix.arFill(2, {Saw.ar(freq *0.5 + 2.rand2,0.6)})
			]),
			6000,1);
     Out.ar([0,1],x * EnvGen.kr(enve, gate, doneAction: 2))

}).send(s);

)
then...
(
var keys, cutspec, cutbus, rezspec, rezbus, lfospec, lfobus;
keys = Array.newClear(128);

MIDIClient.init;
MIDIIn.connect(0, MIDIClient.sources.at(0));

g = Group.new;

cutspec = ControlSpec(100,10000,\linear,0.001);
cutbus = Bus.new(\control,1,1,s);
cutbus.value = 10000;

rezspec = ControlSpec(1,0,\linear,0.001);
rezbus = Bus.new(\control,2,1,s);
rezbus.value = 1.0;

lfospec = ControlSpec(0,50,\linear,0.001);
lfobus = Bus.new(\control,3,1,s);

MIDIIn.control = {arg src, chan, num, val;
			if(num == 1,{
				rezbus.value = rezspec.map(val/127.0);
			});
			if(num == 7,{
				lfobus.value = lfospec.map(val/127.0).postln;
			});
			};
MIDIIn.bend = {arg src, chan, val;
			cutbus.value = cutspec.map(val/16383.0);
			};

MIDIIn.noteOn = {arg src, chan, num, vel;
	var node;
	if(num < 60, {
		node = Synth.tail(g, "funk", [\freq, num.midicps, \amp, vel/255]);
		node.map("cutoff",1,"rez",2,"lfospeed",3);
//		node = Synth.basicNew("funk",s);
//		s.sendBundle(nil,
//			node.addToTailMsg(g,[\freq, num.midicps, \amp, vel/255]),
//			node.mapMsg("cutoff",1,"rez",2,"lfospeed",3)
//		);
		keys.put(num, node)
	},{ 
		node = Synth.tail(g, "strings", [\freq, num.midicps, \amp, vel/255]);
		keys.put(num, node)
	});
};

MIDIIn.noteOff = {arg src, chan, num, vel;
    var node;
    node = keys.at(num);
    if (node.notNil, {
        keys.put(num, nil);
        s.sendMsg("/n_set", node.nodeID, "gate", 0);
        // or node.release
        // then free it ... or get the NodeWatcher to do it
    });
};

)












