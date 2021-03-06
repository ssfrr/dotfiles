softVol_ 		set a nodeproxy's vol conditionally


	softVol_(param, val, within = 0.025, pause = true, lastVal, spec)
		val - 		the volume value to set to 
		within  	the normalized range within which the set is accepted - default is 0.025
		pause	a flag whether to pause the nodeproxy when volume is 0. 
				waits for 0.2 seconds for volume to go down first.
		lastVal	the previous value that the controller has set - can be 
		spec	a ControlSpec can be passed in. if nil, \amp.asSpec is used.
		

See also softSet, softPut.


Ndef(\test, { |freq=200| Splay.ar(SinOsc.ar(freq * Array.rand(12, 0.95, 1.05))) });
Ndef(\test).play(vol: 0.1);

	// example of softSet, softSet which knows lastVal,
	// softVol_ and softVol_ which knows lastVol:
(
w = Window("softVol", Rect(500, 200, 400, 240)).front;
w.view.addFlowLayout;
NdefGui(Ndef(\test), 2, w);

	// same for volume - not too safe
EZSlider(w, 340@30, \softVol, \amp, { |sl| 
	Ndef(\test).softVol_(sl.value, 0.05)
});
	// safer
EZSlider(w, 340@30, \knowLastV, \amp, Routine { |sl| 
	var newVal, lastVal; 
	loop { 
		newVal = sl.value;
		Ndef(\test).softVol_(sl.value, 0.05, lastVal: lastVal);
		lastVal = newVal;
		\dummy.yield;
	}
});
)



