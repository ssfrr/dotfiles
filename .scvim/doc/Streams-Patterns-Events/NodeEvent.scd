NodeEvent			synth- and group- like interface of Event

see also: Event

The methods Event-synth and Event-group set the parent event of the receiver to specialized events that  duplicate the functionality of Synth and Group objects. These objects follow the naming conventions of patterns (i.e., groups and addActions are integer ID's) and have the same stop/play/pause/resume interface as the EventStreamPlayers created by Pattern-play.  So, they can be used interchangeably with patterns in control schemes and GUI's.

The following example creates  a group with nodeID = 2 and plays a synth within it.  

	g = (id: 2).group;
	g.play;
	a = (group: 2).synth
	a.play;
	g.release;
	g.stop;


interface:

play				starts synth or group, returns this.delta
stop				if ev[\hasGate] == true set gate to 0, otherwise frees the node
pause			disables the node
resume			reenables the node
set( key, value)	sets control identified by key to value
split				returns an array of events, one for each synth or group specified by the receiver

map(key, busID)		maps control to control bus
before(nodeID)		moves to immediately before nodeID
after(nodeID)			moves to immediately after nodeID
headOf(nodeID)		moves to immediately to head of nodeID
tailOf(nodeID)		moves to immediately to tail of nodeID


With the exception of ~server, ~latency, and ~instrument any key in the event can have an array as a 
value and the standard rules of multi-channel expansion will be followed.  

// Here is a simple example of its use:

(
	// define a multiple Group event
	g = (id: [2,3,4,5,6], group: 0, addAction: 1).group ;  
	g.play; // play it

	// make a Synth event
	b = ( freq: [500,510], group: [2,3]).synth;           
	b.play;
	
	b.set(\freq,[1000,1006])

	g.release

	b.play;		
	h = g.split;	// split into individual group events
	c = b.split;	// and synth events
	c[0].set(\freq,700);
	c[1].set(\freq,400);
	
	h[0].stop;
	h[1].stop;
	
	g.stop;
)



