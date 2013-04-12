SuperCollider Server Synth Engine Command Reference

The following is a list of all server commands and their arguments. 

Each command has a command number which can be sent to the server as a 32 bit integer instead of an OSC style string. Command numbers are listed at the end of this document.

If a command's description contains the word Asynchronous, then that command will be passed to a background thread to complete so as not to steal CPU time from the audio synthesis thread. All asynchronous commands send a reply to the client when they are completed. Many asynchronous commands can contain an OSC message or bundle to be executed upon completion.

	eg. 
		["/d_load", "synthdefs/void.scsyndef", 
				["/s_new", "void", 1001, 1, 0] // completion message
		]
			


Master Controls

/quit						quit program
	no arguments.

Exits the synthesis server.
Asynchronous. Replies to sender with /done just before completion.

/notify					register to receive notifications from server
	int - one to receive notifications, zero to stop receiving them.
	
If argument is one, server will remember your return address and send you notifications. if argument is zero, server will stop sending you notifications. 
Asynchronous. Replies to sender with /done when complete.

/status					query the status
	no arguments.

Replies to sender with the following message.
/status.reply
	int - 1. unused.
	int - number of unit generators.
	int - number of synths.
	int - number of groups.
	int - number of loaded synth definitions.
	float - average percent CPU usage for signal processing
	float - peak percent CPU usage for signal processing
	double - nominal sample rate
	double - actual sample rate


/cmd					plug-in defined command
	string - command name
	...any arguments
	
Commands are defined by plug-ins.


/dumpOSC				display incoming OSC messages
	int - code

Turns on and off printing of the contents of incoming Open Sound Control messages. This is useful when debugging your command stream.
The values for the code are as follows:
0 - turn dumping OFF.
1 - print the parsed contents of the message.
2 - print the contents in hexadecimal.
3 - print both the parsed and hexadecimal representations of the contents.	

/sync					notify when async commands have completed.
	int - a unique number identifying this command.
	
Replies with a /synced message when all asynchronous commands received before this one have completed. The reply will contain the sent unique ID.
Asynchronous. Replies to sender with /synced, ID when complete.


/clearSched				clear all scheduled bundles.
	
Removes all bundles from the scheduling queue.


/error					enable/disable error message posting
	int - mode

Turn on or off error messages sent to the SuperCollider post window. Useful when sending a message, such as /n_free, whose failure does not necessarily indicate anything wrong.

The values for mode are as follows:
0 = turn off error posting until the next ['/error', 1] message.
1 = turn on error posting.

For convenience of client-side methods, you can also suppress errors temporarily, for the scope of a single bundle.

-1 = turn off locally in the bundle -- error posting reverts to the "permanent" setting for the next message or bundle.
-2 = turn on locally in the bundle.

These "temporary" states accumulate within a single bundle -- so if you have nested calls to methods that use bundle-local error suppression, error posting remains off until all the layers have been unwrapped. If you use ['/error', -1] within a self-bundling method, you should always close it with ['/error', -2] so that subsequent bundled messages will take the correct error posting status. However, even if this is not done, the next bundle or message received will begin with the standard error posting status, as set by modes 0 or 1.

Temporary error suppression may not affect asynchronous commands in every case.


Synth Definition Commands

/d_recv					receive a synth definition file
	bytes - buffer of data. 
	bytes - an OSC message to execute upon completion. (optional)

Loads a file of synth definitions from a buffer in the message. Resident definitions with the same names are overwritten. 
Asynchronous. Replies to sender with /done when complete.


/d_load					load synth definition
	string - pathname of file. Can be a pattern like "synthdefs/perc-*"
	bytes - an OSC message to execute upon completion. (optional)

Loads a file of synth definitions. Resident definitions with the same names are overwritten. 
Asynchronous. Replies to sender with /done when complete.


/d_loadDir					load a directory of synth definitions
	string - pathname of directory.
	bytes - an OSC message to execute upon completion. (optional)
	
Loads a directory of synth definitions files. Resident definitions with the same names are overwritten. 
Asynchronous. Replies to sender with /done when complete.


/d_free					delete synth definition
	[
		string - synth def name
	] * N

Removes a synth definition once all synths using it have ended. 



Node Commands

/n_free					delete a node.
	[
		int - node ID
	] * N
	
Stops a node abruptly, removes it from its group, and frees its memory. A list of node IDs may be specified. Using this method can cause a click if the node is not silent at the time it is freed.

/n_run					turn node on or off
	[
		int - node ID
		int - run flag
	] * N
	
If the run flag set to zero then the node will not be executed.
If the run flag is set back to one, then it will be executed.
Using this method to start and stop nodes can cause a click if the node is not silent at the time run flag is toggled. 

/n_set					set a node's control value(s)
	int - node ID
	[
		int or string - a control index or name
		float or int - a control value
	] * N
	
Takes a list of pairs of control indices and values and sets the controls to those values. If the node is a group, then it sets the controls of every node in the group.

This message now supports array type tags ($[ and $]) in the control/value component of the OSC message.  Arrayed control values are applied in the manner of n_setn (i.e., sequentially starting at the indexed or named control).  

/n_setn					set ranges of a node's control value(s)
	int - node ID
	[
		int or string - a control index or name
		int - number of sequential controls to change (M)
		[
			float or int - a control value
		] * M
	] * N
	
Set contiguous ranges of control indices to sets of values. For each range, the starting control index is given followed by the number of controls to change, followed by the values. If the node is a group, then it sets the controls of every node in the group.

/n_fill					fill ranges of a node's control value(s)
	int - node ID
	[
		int or string - a control index or name
		int - number of values to fill (M)
		float or int - value
	] * N
	
Set contiguous ranges of control indices to single values. For each range, the starting control index is given followed by the number of controls to change, followed by the value to fill. If the node is a group, then it sets the controls of every node in the group.

/n_map					map a node's controls to read from a bus
	int - node ID
	[
		int or string - a control index or name
		int - control bus index
	] * N
	
Takes a list of pairs of control names or indices and bus indices and causes those controls to be read continuously from a global control bus. If the node is a group, then it maps the controls of every node in the group. If the control bus index is -1 then any current mapping is undone. Any n_set, n_setn and n_fill command will also unmap the control.

/n_mapn					map a node's controls to read from buses
	int - node ID
	[
		int or string - a control index or name
		int - control bus index
		int - number of controls to map
	] * N
	
Takes a list of triplets of control names or indices, bus indices, and number of controls to map and causes those controls to be mapped sequentially to buses. If the node is a group, then it maps the controls of every node in the group. If the control bus index is -1 then any current mapping is undone. Any n_set, n_setn and n_fill command will also unmap the control.

/n_mapa					map a node's controls to read from an audio bus
	int - node ID
	[
		int or string - a control index or name
		int - control bus index
	] * N
	
Takes a list of pairs of control names or indices and audio bus indices and causes those controls to be read continuously from a global audio bus. If the node is a group, then it maps the controls of every node in the group. If the audio bus index is -1 then any current mapping is undone. Any n_set, n_setn and n_fill command will also unmap the control. For the full audio rate signal, the argument must have its rate set to \ar.

/n_mapan					map a node's controls to read from audio buses
	int - node ID
	[
		int or string - a control index or name
		int - control bus index
		int - number of controls to map
	] * N
	
Takes a list of triplets of control names or indices, audio bus indices, and number of controls to map and causes those controls to be mapped sequentially to buses. If the node is a group, then it maps the controls of every node in the group. If the audio bus index is -1 then any current mapping is undone. Any n_set, n_setn and n_fill command will also unmap the control. For the full audio rate signal, the argument must have its rate set to \ar.

/n_before					place a node before another
	[
		int - the ID of the node to place (A)
		int - the ID of the node before which the above is placed (B)
	] * N

Places node A in the same group as node B, to execute immediately before node B.

/n_after					place a node after another
	[
		int - the ID of the node to place (A)
		int - the ID of the node after which the above is placed (B)
	] * N

Places node A in the same group as node B, to execute immediately after node B.

/n_query					get info about a node
	[
		int - node ID
	] * N

The server sends an /n_info message for each node to registered clients. 
See Node Notifications below for the format of the /n_info message.

/n_trace					trace a node
	[
		int - node ID
	] * N

Causes a synth to print out the values of the inputs and outputs of its unit generators for one control period. Causes a group to print the node IDs and names of each node in the group for one control period.

/n_order						move and order a list of nodes
	int - add action (0,1,2, 3 or 4 see below)
	int - add target ID
	[
		int - node ID
	] * N
	
Move the listed nodes to the location specified by the target and add action, and place them in the order specified. Nodes which have already been freed will be ignored.
add actions:
	0 - construct the node order at the head of the group specified by the add target ID.
	1 - construct the node order at the tail of the group specified by the add target ID.
	2 - construct the node order just before the node specified by the add target ID.
	3 - construct the node order  just after the node specified by the add target ID.

Synth Commands

/s_new						create a new synth
	string - synth definition name
	int - synth ID
	int - add action (0,1,2, 3 or 4 see below)
	int - add target ID
	[
		int or string - a control index or name
		float or int - a control value
	] * N
	
Create a new synth from a synth definition, give it an ID, and add it to the tree of nodes. There are four ways to add the node to the tree as determined by the add action argument which is defined as follows:
add actions:
	0 - add the new node to the the head of the group specified by the add target ID.
	1 - add the new node to the the tail of the group specified by the add target ID.
	2 - add the new node just before the node specified by the add target ID.
	3 - add the new node just after the node specified by the add target ID.
	4 - the new node replaces the node specified by the add target ID. The target node is freed.
Controls may be set when creating the synth. The control arguments are the same as for the n_set command.

If you send /s_new with a synth ID of -1, then the server will generate an ID for you. The server reserves all negative IDs. Since you don't know what the ID is, you cannot talk to this node directly later. So this is useful for nodes that are of finite duration and that get the control information they need from arguments and buses or messages directed to their group. In addition no notifications are sent when there are changes of state for this node, such as /go, /end, /on, /off.

If you use a node ID of -1 for any other command, such as /n_map, then it refers to the most recently created node by /s_new (auto generated ID or not). This is how you can map  the controls of a node with an auto generated ID. In a multi-client situation, the only way you can be sure what node -1 refers to is to put the messages in a bundle.

This message now supports array type tags ($[ and $]) in the control/value component of the OSC message.  Arrayed control values are applied in the manner of n_setn (i.e., sequentially starting at the indexed or named control). See the NodeMessaging helpfile.



/s_get					get control value(s)
	int - synth ID
	[
		int or string - a control index or name
	] * N
	
Replies to sender with the corresponding /n_set command.

/s_getn					get ranges of control value(s)
	int - synth ID
	[
		int or string - a control index or name
		int - number of sequential controls to get (M)
	] * N
	
Get contiguous ranges of controls. Replies to sender with the corresponding /n_setn command. 

/s_noid					auto-reassign synth's ID to a reserved value
	[
		int - synth ID
	] * N
	
This command is used when the client no longer needs to communicate with the synth and wants to have the freedom to reuse the ID. The server will reassign this synth to a reserved negative number. This command is purely for bookkeeping convenience of the client. No notification is sent when this occurs.


Group Commands

/g_new					create a new group
	[
		int - new group ID
		int - add action (0,1,2, 3 or 4 see below)
		int - add target ID
	] * N
	
Create a new group and add it to the tree of nodes.
There are four ways to add the group to the tree as determined by the add action argument which is defined as follows (the same as for "/s_new"):
add actions:
	0 - add the new group to the the head of the group specified by the add target ID.
	1 - add the new group to the the tail of the group specified by the add target ID.
	2 - add the new group just before the node specified by the add target ID.
	3 - add the new group just after the node specified by the add target ID.
	4 - the new node replaces the node specified by the add target ID. The target node is freed.
Multiple groups may be created in one command by adding arguments.

/p_new					create a new parallel group
	[
		int - new group ID
		int - add action (0,1,2, 3 or 4 see below)
		int - add target ID
	] * N
	
Create a new parallel group and add it to the tree of nodes. Parallel groups are relaxed groups, their child nodes are evaluated in unspecified order.
There are four ways to add the group to the tree as determined by the add action argument which is defined as follows (the same as for "/s_new"):
add actions:
	0 - add the new group to the the head of the group specified by the add target ID.
	1 - add the new group to the the tail of the group specified by the add target ID.
	2 - add the new group just before the node specified by the add target ID.
	3 - add the new group just after the node specified by the add target ID.
	4 - the new node replaces the node specified by the add target ID. The target node is freed.
Multiple groups may be created in one command by adding arguments.

/g_head					add node to head of group
	[
		int - group ID
		int - node ID
	] * N
	
Adds the node to the head (first to be executed) of the group.

/g_tail					add node to tail of group
	[
		int - group ID
		int - node ID
	] * N
	
Adds the node to the tail (last to be executed) of the group.

/g_freeAll					delete all nodes in a group.
	[
		int - group ID
	] * N
	
Frees all nodes in the group. A list of groups may be specified.

/g_deepFree				free all synths in this group and all its sub-groups.
	[
		int - group ID
	] * N
	
Traverses all groups below this group and frees all the synths. Sub-groups are not freed. A list of groups may be specified.

/g_dumpTree				post a representation of this group's node subtree.
	[
		int - group ID
		int - flag; if not 0 the current control (arg) values for synths will be posted
	] * N
	
Posts a representation of this group's node subtree, i.e. all the groups and synths contained within it, optionally including the current control values for synths.

/g_queryTree				get a representation of this group's node subtree.
	[
		int - group ID
		int - flag: if not 0 the current control (arg) values for synths will be included
	] * N
	
Request a representation of this group's node subtree, i.e. all the groups and synths contained within it. Replies to the sender with a /g_queryTree.reply message listing all of the nodes contained within the group in the following format:

	int - flag: if synth control values are included 1, else 0
	int - node ID of the requested group
	int - number of child nodes contained within the requested group
	then for each node in the subtree:
	[
		int - node ID
		int - number of child nodes contained within this node. If -1this is a synth, if >=0 it's a group
		then, if this node is a synth:
		symbol - the SynthDef name for this node.
		then, if flag (see above) is true:
		int - numControls for this synth (M)
		[
			symbol or int: control name or index
			float or symbol: value or control bus mapping symbol (e.g. 'c1')
		] * M
	] * the number of nodes in the subtree
	
N.B. The order of nodes corresponds to their execution order on the server. Thus child nodes (those contained within a group) are listed immediately following their parent. See the method Server:queryAllNodes for an example of how to process this reply.


Unit Generator Commands

/u_cmd					send a command to a unit generator
	int - node ID
	int - unit generator index
	string - command name
	...any arguments
	
Sends all arguments following the command name to the unit generator to be performed. Commands are defined by unit generator plug ins.


Buffer Commands

Buffers are stored in a global array, indexed by integers starting at zero. 

/b_alloc					allocate buffer space.
	int - buffer number
	int - number of frames
	int - number of channels (optional. default = 1 channel)
	bytes - an OSC message to execute upon completion. (optional)
	
Allocates zero filled buffer to number of channels and samples.
Asynchronous. Replies to sender with /done when complete.

/b_allocRead				allocate buffer space and read a sound file.
	int - buffer number
	string - path name of a sound file.
	int - starting frame in file (optional. default = 0)
	int - number of frames to read (optional. default = 0, see below)
	bytes - an OSC message to execute upon completion. (optional)
	
Allocates buffer to number of channels of file and number of samples requested, or fewer if sound file is smaller than requested. Reads sound file data from the given starting frame in the file. If the number of frames argument is less than or equal to zero, the entire file is read. 
Asynchronous. Replies to sender with /done when complete.

/b_allocReadChannel		allocate buffer space and read channels from a sound file.
	int  - buffer number
	string - path name of a sound file
	int - starting frame in file
	int - number of frames to read
	[
	  int  - source file channel index
	] * N    N >= 0
	bytes - an OSC message to execute upon completion. (optional)
	
As b_allocRead, but reads individual channels into the allocated buffer in the order specified.
Asynchronous. Replies to sender with /done when complete.

/b_read					read sound file data into an existing buffer.
	int - buffer number
	string - path name of a sound file.
	int - starting frame in file (optional. default = 0)
	int - number of frames to read (optional. default = -1, see below)
	int - starting frame in buffer (optional. default = 0)
	int - leave file open (optional. default = 0)
	bytes - an OSC message to execute upon completion. (optional)
	
Reads sound file data from the given starting frame in the file and writes it to the given starting frame in the buffer. If number of frames is less than zero, the entire file is read. 
If reading a file to be used by DiskIn ugen then you will want to set "leave file open" to one, otherwise set it to zero.
Asynchronous. Replies to sender with /done when complete.

/b_readChannel			read sound file channel data into an existing buffer
	int - buffer number
	string - path name of a sound file
	int - starting frame in file
	int - number of frames to read
	int - starting frame in buffer
	int - leave file open
	[
	  int  - source file channel index
	] * N    N >= 0
	bytes - completion message
	
As b_read, but reads individual channels in the order specified. The number of channels requested must match the number of channels in the buffer.
Asynchronous. Replies to sender with /done when complete.

/b_write					write sound file data.
	int - buffer number
	string - path name of a sound file.
	string - header format.
	string - sample format.
	int - number of frames to write (optional. default = -1, see below)
	int - starting frame in buffer (optional. default = 0)
	int - leave file open (optional. default = 0)
	bytes - an OSC message to execute upon completion. (optional)

Write a buffer as a sound file.
Header format is one of: 
	"aiff", "next", "wav", "ircam"", "raw"
Sample format is one of:
	"int8", "int16", "int24", "int32", "float", "double", "mulaw", "alaw"
Not all combinations of header format and sample format are possible.
If number of frames is less than zero, all samples from the starting frame to the end of the buffer are written.
If opening a file to be used by DiskOut ugen then you will want to set "leave file open" to one, otherwise set it to zero. If "leave file open" is set to one then the file is created, but no frames are written until the DiskOut ugen does so.
Asynchronous. Replies to sender with /done when complete.

/b_free					free buffer data.
	int - buffer number
	bytes - an OSC message to execute upon completion. (optional)
	
Frees buffer space allocated for this buffer. 
Asynchronous. Replies to sender with /done when complete.

/b_zero					zero sample data
	int - buffer number
	bytes - an OSC message to execute upon completion. (optional)
	
Sets all samples in the buffer to zero. 
Asynchronous. Replies to sender with /done when complete.

/b_set					set sample value(s)
	int - buffer number
	[
		int - a sample index
		float - a sample value
	] * N
	
Takes a list of pairs of sample indices and values and sets the samples to those values. 

/b_setn					set ranges of sample value(s)
	int - buffer number
	[
		int - sample starting index
		int - number of sequential samples to change (M)
		[
			float - a sample value
		] * M
	] * N
	
Set contiguous ranges of sample indices to sets of values. For each range, the starting sample index is given followed by the number of samples to change, followed by the values.

/b_fill					fill ranges of sample value(s)
	int - buffer number
	[
		int - sample starting index
		int - number of samples to fill (M)
		float - value
	] * N
	
Set contiguous ranges of sample indices to single values. For each range, the starting sample index is given followed by the number of samples to change, followed by the value to fill. This is only meant for setting a few samples, not whole buffers or large sections.


/b_gen					call a command to fill a buffer
	int - buffer number
	string - command name
	.. command arguments

Plug-ins can define commands that operate on buffers. The arguments after the command name are defined by the command. The currently defined buffer fill commands are listed below in a separate section.
Asynchronous. Replies to sender with /done when complete.

/b_close
	int - buffer number
	
After using a buffer with DiskOut, close the soundfile and write header information.
Asynchronous. Replies to sender with /done when complete.

/b_query
	[
		int - buffer number
	] * N
	
Responds to the sender with a /b_info message.  The arguments to /b_info are as follows:
	[
		int - buffer number
		int - number of frames
		int - number of channels
		float - sample rate
	] * N

/b_get					get sample value(s)
	int - buffer number
	[
		int - a sample index
	] * N
	
Replies to sender with the corresponding /b_set command.

/b_getn					get ranges of sample value(s)
	int - buffer number
	[
		int - starting sample index
		int - number of sequential samples to get (M)
	] * N
	
Get contiguous ranges of samples. Replies to sender with the corresponding /b_setn command. This is only meant for getting a few samples, not whole buffers or large sections.



Control Bus Commands

/c_set					set bus value(s)
	[
		int - a bus index
		float or int - a control value
	] * N
	
Takes a list of pairs of bus indices and values and sets the buses to those values. 

/c_setn					set ranges of bus value(s)
	[
		int - starting bus index
		int - number of sequential buses to change (M)
		[
			float or int - a control value
		] * M
	] * N
	
Set contiguous ranges of buses to sets of values. For each range, the starting bus index is given followed by the number of channels to change, followed by the values.

/c_fill						fill ranges of bus value(s)
	[
		int - starting bus index
		int - number of buses to fill (M)
		float or int - value
	] * N
	
Set contiguous ranges of buses to single values. For each range, the starting sample index is given followed by the number of buses to change, followed by the value to fill.

/c_get					get bus value(s)
	[
		int - a bus index
	] * N
	
Takes a list of buses and replies to sender with the corresponding /c_set command.

/c_getn					get ranges of bus value(s)
	[
		int - starting bus index
		int - number of sequential buses to get (M)
	] * N
	
Get contiguous ranges of buses. Replies to sender with the corresponding /c_setn command.



Non Real Time Mode Commands

/nrt_end						end real time mode, close file
not yet implemented 
	no arguments.
	
This message should be sent in a bundle in non real time mode. 
The bundle timestamp will establish the ending time of the file. 
This command will end non real time mode and close the sound file.
Replies to sender with /done when complete.



Replies to Commands

These messages are sent by the server in reponse to some commands.

/done					an asynchronous message has completed.
	string - the name of the command

Sent in response to all asynchronous commands. Sent only to the sender of the original message.

/fail						an error occurred.
	string - the name of the command
	string - the error message.

There was a problem. Sent only to the sender of the original message.

/late						a command was received too late.
not yet implemented 
	int - the high 32 bits of the original time stamp.
	int - the low 32 bits of the original time stamp.
	int - the high 32 bits of the time it was executed.
	int - the low 32 bits of the time it was executed.

The command was received too late to be executed on time. Sent only to the sender of the original message.


Notifications from Server

These messages are sent as notification of some event to all clients who have registered via the /notify command .

Node Notifications

All of these have the same arguments:
	int - node ID
	int - the node's parent group ID
	int - previous node ID, -1 if no previous node.
	int - next node ID, -1 if no next node.
	int - 1 if the node is a group, 0 if it is a synth
	The following two arguments are only sent if the node is a group:
	int - the ID of the head node, -1 if there is no head node.
	int - the ID of the tail node, -1 if there is no tail node.

/n_go					a node was started
	
This command is sent to all registered clients when a node is created.

/n_end					a node ended
	
This command is sent to all registered clients when a node ends and is deallocated.

/n_off					a node was turned off
	
This command is sent to all registered clients when a node is turned off.

/n_on					a node was turned on
	
This command is sent to all registered clients when a node is turned on.

/n_move					a node was moved

This command is sent to all registered clients when a node is moved.

/n_info					reply to /n_query

This command is sent to all registered clients in response to an /n_query command.


Trigger Notification
	
This command is sent to all registered clients when a node is moved from one group to another.

/tr						a trigger message
	int - node ID
	int - trigger ID
	float - trigger value

This command is the mechanism that synths can use to trigger events in clients.
The node ID is the node that is sending the trigger. The trigger ID and value are determined by inputs to the SendTrig unit generator which is the originator of this message.

copyright © 2002 James McCartney



Buffer Fill Commands

These are the currently defined fill routines for use with the /b_gen command.

Wave Fill Commands

There are three defined fill routines for sine waves.

	The flags are defined as follows:
		1 - normalize - Normalize peak amplitude of wave to 1.0.
		2 - wavetable - If set, then the buffer is written in wavetable format so that it can be read by interpolating oscillators.
		4 - clear - if set then the buffer is cleared before new partials are written into it. Otherwise the new partials are summed with the existing contents of the buffer.

	sine1
		int - flags, see above
		[
			float - partial amplitude
		] * N

	Fills a buffer with a series of sine wave partials. The first float value specifies the amplitude of the first partial, the second float value specifies the amplitude of the second partial, and so on.

	sine2
		int - flags, see above
		[
			float - partial frequency (in cycles per buffer)
			float - partial amplitude
		] * N

	Similar to sine1 except that each partial frequency is specified explicitly instead of being an integer series of partials. Non-integer partial frequencies are possible.

	sine3
		int - flags, see above
		[
			float - partial frequency (in cycles per buffer)
			float - partial amplitude
			float - partial phase
		] * N

	Similar to sine2 except that each partial may have a nonzero starting phase.

	cheby
		int - flags, see above
		[
			float - amplitude
		] * N

	Fills a buffer with a series of chebyshev polynomials, which can be defined as:
cheby(n) = amplitude  * cos(n * acos(x))
The first float value specifies the amplitude for n = 1, the second float value specifies the amplitude for n = 2, and so on. To eliminate a DC offset when used as a waveshaper, the wavetable is offset so that the center value is zero. 

Other Commands

	copy
		int - sample position in destination
		int - source buffer number
		int - sample position in source
		int - number of samples to copy

	Copy samples from the source buffer to the destination buffer specified in the b_gen command. If the number of samples to copy is negative, the maximum number of samples possible is copied.
Asynchronous. Replies to sender with /done when complete.

copyright © 2002 James McCartney


Command Numbers

These are the currently defined command numbers. More may be added to the end of the list in the future.

enum {
	cmd_none = 0,

	cmd_notify = 1,
	cmd_status = 2,
	cmd_quit = 3,
	cmd_cmd = 4,

	cmd_d_recv = 5,
	cmd_d_load = 6,
	cmd_d_loadDir = 7,
	cmd_d_freeAll = 8,

	cmd_s_new = 9,
	
	cmd_n_trace = 10,
	cmd_n_free = 11,
	cmd_n_run = 12,
	cmd_n_cmd = 13,
	cmd_n_map = 14,
	cmd_n_set = 15,
	cmd_n_setn = 16,
	cmd_n_fill = 17,
	cmd_n_before = 18,
	cmd_n_after = 19,

	cmd_u_cmd = 20,

	cmd_g_new = 21,
	cmd_g_head = 22,
	cmd_g_tail = 23,
	cmd_g_freeAll = 24,
	
	cmd_c_set = 25,
	cmd_c_setn = 26,
	cmd_c_fill = 27,

	cmd_b_alloc = 28,
	cmd_b_allocRead = 29,
	cmd_b_read = 30,
	cmd_b_write = 31,
	cmd_b_free = 32,
	cmd_b_close = 33,
	cmd_b_zero = 34,
	cmd_b_set = 35,
	cmd_b_setn = 36,
	cmd_b_fill = 37,
	cmd_b_gen = 38,
	
	cmd_dumpOSC = 39,

	cmd_c_get = 40,
	cmd_c_getn = 41,
	cmd_b_get = 42,
	cmd_b_getn = 43,
	cmd_s_get = 44,
	cmd_s_getn = 45,
	
	cmd_n_query = 46,
	cmd_b_query = 47,

	cmd_n_mapn = 48,
	cmd_s_noid = 49,

	cmd_g_deepFree = 50,
	cmd_clearSched = 51,

	cmd_sync = 52,
	
	cmd_d_free = 53,

	cmd_b_allocReadChannel = 54,
	cmd_b_readChannel = 55,
	
	cmd_g_dumpTree = 56,
	cmd_g_queryTree = 57,

	
     cmd_error = 58,

     cmd_s_newargs = 59,

	cmd_n_mapa = 60,
	cmd_n_mapan = 61,
	cmd_n_order = 62,
	
	NUMBER_OF_COMMANDS = 63
};
copyright © 2002 James McCartney


