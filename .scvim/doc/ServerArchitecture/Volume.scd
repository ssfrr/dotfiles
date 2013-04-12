Volume			model for the global volume of the synthesis server

superclass: Object


Internally used by Server.




	*new(server, startBus, numChans, min, max, persist)
	
		Create and return a new instance of Volume for a given server, 
		ranging from startBus over numChans (usually the server's number of output bus channels).
		min: minimum volume in decibel (default: -90)
		max: minimum volume in decibel (default: -90)
		persist: whether to persist a reset (default: false)
		
	
	play(mute)
		
		run the synth that controls the volume. If mute is true, mute the output. (default: false)
		
	free
		free the synth that controls the volume.
		
	mute 
		mute output
		
	unmute 
		unmute output
		
	volume_(aVolume)
		set the volume (in db)
		
	lag_ (aLagTime)
		set the lag time that dampens volume changes
		
	setVolumeRange(argMin, argMax)
		set the volume range
	
	gui(window, bounds)
		create a volume gui.


	// examples

	v = s.volume;
	
	v.min;
	v.max;
	v.volume = rrand(-50, 5);
	v.setVolumeRange(-90, 8);
	v.mute;
	v.unmute;
	
	// separate window
	v.gui;
		


