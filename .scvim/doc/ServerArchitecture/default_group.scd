The default Group			id:1


root node (id:0) [
		default group (id:1)
]

When a Server is booted there is a top level group with an ID of 0 that defines the root of the node tree. (This is represented by a subclass of Group: RootNode.) If the Server was booted from within SCLang (as opposed to from the command line) a default group with an ID of 1 will be automatically created. This is the default target for all Nodes when using object style and is what you will get if you supply a Server as a target. If you don't specify a target or pass in nil, you will get the default group of the default Server.  

Server.default.boot;
a = Synth.new(\default); // creates a synth in the default group of the default Server
a.group; // note the Group ID

The default group serves an important purpose: It provides a predictable basic Node tree so that methods such as Server-scope, Server-record, etc. can function without running into order of execution problems. In the example below the scoping node will come after the default group.

Server.internal.boot;

{ SinOsc.ar(mul: 0.2) }.scope(1);

// watch the post window;
Server.internal.queryAllNodes; 

// our SinOsc synth is within the default group (ID 1)
// the scope node comes after the default group, so no problems

Server.internal.quit;

Note that the default group is persistent: It is created in Server's initTree method (executed along with any code stored in its tree instance variable; see Server for more detail) and is recreated upon reboot, after pressing Cmd-., and after all nodes are freed. When using osc messages this means that a target node of id 1 can always be used:

s.sendMsg("/s_new", "snd", 1832,0,1); // add to head of group 1

The default group can be specifically freed, but there is generally no reason that one would want to do so.

In general one should add nodes to the default group rather than the RootNode unless one has a specific reason to do so (i.e. adding some new functionality such as recording and scoping which is dependent upon a predictable basic node order). When using object style the default group is the default target for all new nodes, so nodes will normally not be added to the RootNode unless that is explicitly specified. It is of course possible to do so, but it should only be done with a proper understanding of the issues involved. 

For instance, if one were to place an 'effects' synth after the default group and call Server-record or Server-scope, the resulting recording or scope synths may not be correctly ordered:

default group [
	source synth1
	source synth2
]
recording synth
effects synth

In the above example the recording synth might not capture the output of the effects synth since it comes later in the node order.

A better method in this case is to create a group within the default group and place the effects synth after that.

default group [
	source group [
		source synth1
		source synth2
	]
	effects synth
]
recording synth

See also: RootNode, NodeMessaging and Order-of-execution


