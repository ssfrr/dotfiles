Pgroup 

superclass: FilterPattern



Pgroup(pattern)

Starts a new Group and plays the pattern in this group. 
The group is released when the stream has ended. The group's release is delayed (default 0.1 beats) until after the last note releases. But, Pgroup does not know how long the synths' envelopes last. You can extend the lag by putting the number of beats into the event prototype's \groupReleaseTime key:

Pgroup(...).play(protoEvent: Event.default.put(\groupReleaseTime, releaseLag));

Example:


(
var p, q, r, o;
p = Pbind(\degree, Prand((0..7),12), \dur, 0.3, \legato, 0.2);

Pgroup(p).play;

// post the node structure:
fork {
	s.queryAllNodes;
	3.wait;
	s.queryAllNodes;
	2.wait;
	s.queryAllNodes;
}
)
	


