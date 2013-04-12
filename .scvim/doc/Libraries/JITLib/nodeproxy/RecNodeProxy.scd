RecNodeProxy

superclass: NodeProxy

a NodeProxy that can record

this is also created from a NodeProxy, or an Ndef with the message record.


instance creation:

	*new(server) / *audio(server, numChannels)
		see superclass
	
	*newFrom(inproxy, numChannels)
		instantiate a new proxy that listens to the in proxy.


access:

	open(path, headerformat, sampleformat)
		open new file and initialize buffer on server
	
	record(paused)
		start the recording synth, if paused is false start recording immediately
		default: true
	
	close
		stop recording, close file 

	pause/unpause
		pause recording / unpause recording 
	
	isRecording
		see if recording right now
	
	wakeUp 
			until the proxy is not used by any output ( either .play or .ar/.kr )
			it is not running on the server. you can wake it up to force it playing.



examples


s.boot;

a = RecNodeProxy.audio(s, 2);
a.source = { SinOsc.ar([400,500], 0, 0.1) };
a.play; //monitor;
a.open("xproxySpace.aif");
a.record(false);

a.source = { SinOsc.ar([400,700], 0, 0.1) };
a.source = { SinOsc.ar([410,510], 0, 0.1) };
a.source = { SinOsc.ar([LFNoise1.kr(80, 100, 300),500], 0, 0.1) };

//stop recording and close file
a.close;

//monitor off
a.stop; 

recording from some bus

a = Bus.audio(s, 2); 

SynthDef("test", { arg out; Out.ar(out, { WhiteNoise.ar(0.1) }.dup(2)) }).send(s);
x = Synth("test", [\out, a]);


n = RecNodeProxy.audio(s, 2);
n.source = { InFeedback.ar(a, 2) };

n.play;//monitor
n.stop;//turn off monitor

n.open("noise.aif");
n.record;
n.unpause;

n.close;


instance creation from an existent node proxy



b = NodeProxy.audio(s, 2);
b.play; //listen to b
b.source = { SinOsc.ar([400,500], 0, 0.1) }; //play something

r = RecNodeProxy.newFrom(b);
r.open("recproxy514.aif"); //open file
r.record; //start recorder (paused)

r.unpause; //start recording

b.source = { SinOsc.ar([430,500], 0, 0.1) };
b.source = { SinOsc.ar([410,510], 0, 0.1) };
b.source = { SinOsc.ar([LFNoise1.kr(80, 100, 300), 500], 0, 0.1) };
r.pause;
b.source = { WhiteNoise.ar(0.01) };
r.unpause;
r.pause;


//stop recording and close file
r.close;
b.stop; //stop listen to b


instance creation from an existent node proxy again



b = NodeProxy.audio(s, 2);
b.play; //listen to b
b.source = { SinOsc.ar([400,500], 0, 0.1) }; //play something

r = b.record("recproxy101.aiff"); //start recorder (paused)
r.unpause; //start recording
r.close;  //end recording, close file
b.stop;	//stop listen




recording from other sources




s.boot;

a = RecNodeProxy.audio(s, 2);
b = a.index; //get the bus index;
a.play; 		//monitor;
a.open("xproxySpace.aif");
a.record;
a.unpause;

(
Routine({
	var id;
	loop({
		id = s.nextNodeID;
		s.sendMsg("/s_new", "default", id,0,0, \out, b, \freq, rrand(400, 800));
		0.2.wait;
		s.sendMsg("/n_set", id, \gate, 0);
		0.2.wait;
	})
}).play;
)


//stop recording and close file
a.close;

//monitor off
a.stop; 



