MIDIOut

send midi messages

a MIDIOut is bound to a specific MIDIEndPoint as defined by the operating system

list out ports: 
 	MIDIClient.destinations

 *new(port, uid)
 	port is the index of the MIDIEndPoint in the MIDIClient.destinations array.
 
 	Mac OSX / Windows: uid is optional; if specified, it should be the uid of that port
	 	ie. MIDIClient.destinations[port].uid
	 	If you don't provide a uid, the correct uid will be filled in for you (easier)

	 Linux: using the uid is optional as described below

	
 *newByName(deviceName,portName)
 	Searches for the device by name. This is safer then depending on the index which will change
 	if your studio setup changes.
	list connected out ports with names: 
	 	MIDIClient.destinations
 		
 *findPort(deviceName,portName)
 	searches for a connected MIDIEndPoint by name
	list connected out ports with names: 
 		MIDIClient.destinations

  *connect(port, uid) (Linux only)
  *disconnect(port, uid) (Linux only)
	OS X does not need to connect. On Linux it is an optional feature (see below).

 latency_( time )
	This sets the latency with which a midi event is sent out. Per default this is set to 0.2, in order to be equal to the Server.latency.
NOTE: on Linux there seems to be an ALSA or kernel bug if the latency is larger than 0, for some Linux kernels. If MIDIOut does not seem to work, set the latency to 0.

 noteOn ( chan, note, veloc )
 noteOff ( chan, note, veloc )
 polyTouch ( chan, note, val )
 control ( chan, ctlNum, val )
 program ( chan, num )
 touch ( chan, val )
 bend ( chan, val )
 allNotesOff ( chan )
 smpte ( frames, seconds, minutes, hours, frameRate )
 songPtr ( songPtr )
 songSelect ( song )
 midiClock (  )
 startClock (  )
 continueClock (  )
 stopClock (  )
 reset (  )
 sysex ( Int8Array )
 connect(uid) (Linux only)
 disconnect(uid) (Linux only)

 private methods:
 send ( outport, uid, len, hiStatus, loStatus, a, b, latency )
 prSysex ( uid, Int8Array )
 *connectByUID(port, uid) (Linux only)
 *disconnectByUID(port, uid) (Linux only)



// examples:

MIDIClient.init;

m = MIDIOut(0);
m.noteOn(16, 60, 60);
m.noteOn(16, 61, 60);
m.noteOff(16, 61, 60);
m.allNotesOff(16);


MIDIIn.connect; // 1 port midi interface
MIDIIn.sysex = { arg uid, packet; [uid,packet].postln };
MIDIIn.sysrt = { arg src, chan, val;  [src, chan, val].postln; };
MIDIIn.smpte = { arg src, chan, val;  [src, chan, val].postln; };

m.sysex(Int8Array[ 16rf0, 0, 0, 27, 11, 0,16rf7])

m.smpte(24,16) 
m.midiClock 
m.start 
m.continue 
m.stop 



Using patterns for sending midi events

MIDIClient.init;
m = MIDIOut(0);

a = Pbind(\degree, Prand([1, 2, 3, [0, 5]], inf), \bend, Pwhite(0, 76, inf));


// chain a midi event into the pattern and play it (see Pchain)

(a <> (type: \midi, midiout: m)).play;


The following keys are supported by midi event:

\noteOn
\noteOff
\polyTouch
\control
\program
\touch
\bend
\allNotesOff
\smpt
\songPtr
\sysex




Linux specific: Connecting and disconnecting ports.

On Linux, a MIDIOut can be created without setting the destination:

m = MIDIOut(0);

in this case each message will be sent to all ports connected to SuperCollider's first MIDI output. 

A connection can be made through:

m.connect( 2 );

Note that by connecting in this way, you can connect more than one destination to the MIDI output.
You can also use other tools to connect to a MIDIOut port of SC, e.g. through aconnect or QJackCtl (on the ALSA tab).

If you set the uid in MIDIOut, a direct connection is established and data will only be sent to that MIDI input port, and not to any other connections made to SC's MIDI output port (through the connect message or external tools).


OS X specific: Sending MIDI to other applications

Open the Audio MIDI Setup application.  Double-click on IAC Driver and check "device is online".  

reinitialize:

MIDIClient.init(numIns,numOuts)

The IAC Bus will now appear in MIDIClient.destinations.  It will appear first, which means that any code that you have written that addresses the first physical bus as 0 will now have to be changed.

For this reason it is always safer to find the port by name :
	MIDIOut.newByName("RemoteSL IN","Port 1")
	
The IAC Bus will now also appear to other applications.


MIDIMonitor (freeware) can be very useful for troubleshooting:

http://www.snoize.com/MIDIMonitor/





