Short Overview of Server Commands
see also [Server-Command-Reference]

Server Commands

/quit
/notify  flag
/status
/cmd_error flag
/cmd name args ...
/dumpOSC [0: off 1: on 2: hex 3: both]

/d_recv bytes [complBytes]
/d_load path [complBytes]
/d_loadDir path [complBytes]
/d_free defName ... 

Node:

/n_free nodeID ...
/n_run | nodeID flag | ... 
/n_set nodeID  | control value | ...
/n_setn nodeID | control numCtl values.. | ...
/n_fill nodeID | control numCtl value | ...
/n_map  nodeID | control busIndex | ...
/n_mapn nodeID | control busIndex numCtl | ...
/n_mapa  nodeID | control busIndex | ...
/n_mapan nodeID | control busIndex numCtl | ...

/n_before | movedNodeID targetNodeID | ...
/n_after | movedNodeID targetNodeID | ...
/n_query nodeID ...
/n_trace nodeID ...

addAction:
0 add to head
1 add to tail
2 add before
3 add after
4 replace


alternative syntax for "nodeID"
positionArg | nodeID
"h" - head of the current group
"t" - tail of the current group
"u" - up. the parent of the current node.
"p" - the previous node.
"n" - the next node.

Synth:

/s_new defName nodeID addAction targetNodeID | control value | ...
/s_newargs // to document.
/s_get nodeID control ...
/s_getn nodeID | control numControls | ...
/s_noid nodeID ...

Group:

/g_new nodeID addAction targetNodeID
/g_head | groupID nodeID | ...
/g_tail | groupID nodeID | ...
/g_freeAll groupID ...
/g_deepFree groupID ...
/g_dumpTree
/g_queryTree

UGen:

/u_cmd nodeID ugenIndex string arg ...

Buffer:

/b_alloc bufnum numFrames numChannels [complBytes]
/b_allocRead bufnum path startFrame numFrames [complBytes]
/b_allocReadChannel  bufnum path startFrame numFrames channels [complBytes]
/b_read bufnum path startFrameFile numFrames startFrameBuf numChannels leaveOpen [complBytes]
/b_write bufnum path headerFormat sampleFormat numFrames startFrameBuf leaveOpen [complBytes] 
/b_readChannel bufnum path fileStartFrame numFrames bufStartFrame leaveOpen [complBytes]
/b_free bufnum  [complBytes]
/b_zero bufnum  [complBytes]
/b_set bufnum | index value | ...
/b_setn bufnum | startIndex numSamples values .. | ...
/b_fill bufnum | startIndex numSamples value | ...
/b_gen  bufnum command args ...
/b_close  bufnum
/b_query  bufnum ...  (returns /b_info message: /b_info bufnum numFrames numChannels sampleRate)
/b_get bufnum sampleIndex ... (returns corresponding b_set message)
/b_getn bufnum startIndex numFrames (returns corresponding b_setn message)

Control Bus:

/c_set | index value | ...
/c_setn | startIndex num values .. | ...
/c_fill | startIndex num value | ... 
/c_get  index ... (returns corresponding c_set message)
/c_getn | startIndex num | ... (returns corresponding c_setn message)


Replies:

/done commandName
/fail commandName errorMsg
/late timeStamp-hiBits timeStamp-loBits execTime-hiBits execTime-loBits

Notifications:

all notifications have the same format:
cmd nodeID parentNodeID prevNodeID nextNodeID synthFlag (-1:group 0 synth) headNodeID tailNodeID
/n_go /n_end /n_on /n_off /n_move /n_info

Trigger Notifications:

/tr nodeID triggerID value

Buffer Fill Commands:

flag: 
	1: normalize
	2: wavetable
	4: clear and then write

sine1 flag partialAmp ...
sine2 flag | partialFreq partialAmp |
sine3 flag | partialFreq partialAmp partialPhase |
cheby flag | amp |

copy posDest bufNumSrc posSrc numFrames


Glossary:

flag: 
	0 (false) 
	1 (true)
complBytes: 
	an osc message to evaluate after completion (array): this also means command is asynchronous
control: 
	index or name

-1 is the equivalent of nil
'nothing' is replaced by 0



CommandNumbers:

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
	
	NUMBER_OF_COMMANDS = 62



