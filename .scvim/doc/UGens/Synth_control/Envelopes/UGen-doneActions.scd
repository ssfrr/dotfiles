UGen Done Actions				

A number of UGens implement doneActions. These allow one to optionally free or pause the enclosing synth and other related nodes when the UGen is finished. These include EnvGen, Line, XLine, Linen, DetectSilence, PlayBuf, Duty, TDuty and Demand.

For a list, see:  Synth-Controlling-UGens

The available done actions are as follows:

0	do nothing when the UGen is finished
1	pause the enclosing synth, but do not free it
2	free the enclosing synth
3	free both this synth and the preceding node
4	free both this synth and the following node
5	free this synth; if the preceding node is a group then do g_freeAll on it, else free it
6	free this synth; if the following node is a group then do g_freeAll on it, else free it
7	free this synth and all preceding nodes in this group
8	free this synth and all following nodes in this group
9	free this synth and pause the preceding node
10	free this synth and pause the following node
11	free this synth and if the preceding node is a group then do g_deepFree on it, else free it
12	free this synth and if the following node is a group then do g_deepFree on it, else free it
13	free this synth and all other nodes in this group (before and after)
14	free the enclosing group and all nodes within it (including this synth)

For information on freeAll and deepFree, see Group and Server-Command-Reference.



