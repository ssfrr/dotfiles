Monitor		link between busses

superclass: Object

For playing contiguous channels to other contiguous busses, one uses play;
 for more complex routings, such as splitting, spreading etc to multiple channels, playN.
	
	play(fromIndex, fromNumChannels, toIndex, toNumChannels, target, multi, volume, fadeTime)
				plays from a bus index with a number of channels to another index with a number
				of channels, within a target group, or a server.
				multi: keep old links and add new one
				volume: volume at which to monitor
				fadeTime: fade in fade out time
	
	playN(outs, amps, ins, vol, fadeTime, target, addAction)
				outs			array of destination channels
				amps		array of  amplitudes for each channel
				ins			array of source channels
		
			outs, amps and ins can be nested arrays.
		
				vol		global scaling for amplitudes
				fadeTime		fade in and out
				target, addAction		where to play (default: server default group)
				
		see also playN		
	
				
	isPlaying		returns true if the group is still playing
	
	
	stop(fadeTime)
				stops within the fadeTime
	
	vol_			set the volume
	out_			set the output index. doesn't work right now.
	
	playToBundle(bundle, ... (same as .play))
				adds all playing osc messages to the bundle. the bundle should support the message .add
	
	
	
	//example
	
	Server.default = s = Server.internal;
	s.boot;
	s.scope(16);

	{ Out.ar(87, SinOsc.ar(MouseX.kr(40, 10000, 1) * [1, 2, 3], 0, 0.2)) }.play;
	x = Monitor.new;
	x.play(87, 3, 1, 2);
	x.out = 0;
	x.stop(3.0);
	x.play(87, 1, 0, 1); // in > out : now mixes down (wrapping)
	x.play(89, 1, 0, 2); // in < out : now distributes to 2 channels
	x.stop;
	
	// multiple play
	x.play(87, 1, 0, 2, multi:true);	
	x.play(88, 1, 0, 2, multi:true);	
	x.play(89, 1, 0, 2, multi:true);	
	x.stop;



multichannel playing



// examples: args are // outs, amps, ins, vol, fadeTime


(	x.playN(
		[0, 1, 4], 		// to these outs
		[0.1, 0.4, 0.3], 	// with these volumes
		[87, 88, 89]		// from these ins
	); 
)
(
	x.playN(
		[0, [1, 3, 2], 4], 		// outs can be nested: 87 -> 0,  88 -> [1, 3, 2],  89 -> 4
		[0.1, [0.4, 0.2, 0.1], 0.3], // with nested volumes 0.1, [0.4, 0.2, 0.1], and 0.3
		[87, 88, 89]); 			// reading from these ins
)	
		// can also set global volume and fadetime
	x.playN(vol: 0.0, fadeTime:4);	
	
	


