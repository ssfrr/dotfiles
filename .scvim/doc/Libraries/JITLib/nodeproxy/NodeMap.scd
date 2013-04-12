NodeMap

object to store control values and bus mappings independant of of a specific node.

	set(key1, value1, ...) 			set arguments of a node
	map(key1, busindex1, ...) 		set bus mappings of a node
	unset(key1, key2, ...)			remove settings
	unmap(key1, key2, ...)			remove mappings
	setn(key1, valueArray1, ...) 		set ranges of controls
	mapn(key1, busindex1,  numChan...) 		
								map num busses mappings to node

	at(index)						return setting at that key. 
	sendToNode(aTarget, latency)	apply a setting to a node by sending a bundle
	send(server, nodeID, latency)	apply a setting to a node by sending a bundle
	addToBundle(aBundle)			add all my messages to the bundle




s.boot;

(
SynthDef("modsine", 
	{ arg freq=320, amp=0.2;
		Out.ar(0, SinOsc.ar(freq, 0, amp));
	}).send(s);
SynthDef("lfo", 
	{ arg rate=2, busNum=0;
		Out.kr(busNum, LFPulse.kr(rate, 0, 0.1, 0.2)) 
	}).send(s);
)

//start nodes
(
b = Bus.control(s,1);
x = Synth("modsine");
y = Synth.before(x, "lfo", [\busNum, b]);
)

//create some node maps
(
h = NodeMap.new;
h.set(\freq, 800);
h.map(\amp, b);

k = NodeMap.new;
k.set(\freq, 400);
k.unmap(\amp);
)

//apply the maps

h.sendToNode(x); //the first time a new bundle is made
k.sendToNode(x);

h.sendToNode(x); //the second time the cache is used
k.sendToNode(x);

h.set(\freq, 600);

h.sendToNode(x); //when a value was changed, a new bundle is made

//free all
x.free; b.free; y.free;





