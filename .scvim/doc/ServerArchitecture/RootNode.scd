RootNode

superclass: Group

A RootNode is the Group with the nodeID of 0 which is always present on each Server and represents the root of that server's node tree.

It is always playing, and always running, cannot be freed, or moved anywhere.

Cacheing is used so that there is always one RootNode per Server.

s = Server.local;

a = RootNode(s);
b = RootNode(s);

a === b; // identical object

sending "/s_new" messages to the server, the target 0 is what is represented by this object.

s.sendMsg("/s_new", "default", -1, 0, 0);//the last argument is the target id

IMPORTANT: In general one should NOT add nodes to the RootNode unless one has a specific reason to do so. Instead one should add nodes to the default_group. This provides a known basic node order and protects functionality like Server.record, Server.scope, etc. The default group is the default target for all new nodes, so when using object style nodes will normally not be added to the RootNode unless that is explicitly specified. See default_group for more information.


