softSet 		set a proxy param value conditionally

See also softVol_, softPut.

NodeProxy.softSet, Ndef.softSet 
	sets a nodeproxy param value only  in two conditions: 
	* if the new value is close enough to the current param value;
	*or  if the setting controller knows the previous value and sends it 
		along. the idea here is that if the controller knows it did the last 
		value change, it has authority to jump now.
	
	softSet(param, val, within = 0.025, mapped=false, lastVal, spec)
		param - 	the name of the parameter to set
		val - 		the value to set the param to (can be mapped or unmapped)
		within  	the normalized range within which the set is accepted - default is 0.025
		lastVal	the previous value that a control has set - see last examples.
		mapped	a flag whether val is mapped (within the range of param.asSpec) or unmapped (0.0-1.0)
		spec	a ControlSpec can be passed in. if nil, param.asSpec is used.
				NOTE: if no spec is given, softSet simply allows setting.

Typical uses would be switching to a preset, then using a faderbox, 
and avoiding sudden controller jumps that could occur (soft takeover).


Ndef(\test, { |freq=200| Splay.ar(SinOsc.ar(freq * Array.rand(12, 0.95, 1.05))) });
Ndef(\test).play(vol: 0.1);

Ndef(\test).gui(4)

Ndef(\test).set(\freq, 300);

		// 3 midi steps == 0.02362;
Ndef(\test).softSet(\freq, 320, 0.03); // ok
Ndef(\test).softSet(\freq, 280, 0.03); // ok
Ndef(\test).softSet(\freq, 200, 0.03); // returns false if too big jump

Ndef(\test).set(\freq, 600); 

	// softSet can be risky - one can lose a parameter when moving a controller
	// too quickly. So, if we know the last value (e.g. because the same controller 
	// knows it has set to that value),  it is OK to jump:
Ndef(\test).softSet(\freq, 330, 0.03, lastVal: 630);	

Ndef(\test).softSet(\freq, rrand(300, 350), 0.01);	// sometimes yes, sometimes no


	// use unmapped, i.e. normalized values to set:

Ndef(\test).set(\freq, 600);	// ok
Ndef(\test).softSet(\freq, 0.5, 0.05, mapped: false);	// ok
Ndef(\test).softSet(\freq, 0.45, 0.03, mapped: false);	// no, too big
Ndef(\test).softSet(\freq, 0.3, 0.03, mapped: false, lastVal: 0.5);	// but ok if lastVal is close


	// example of softSet, softSet which knows lastVal,
	// softVol_ and softVol_ which knows lastVol:
(
w = Window("softSet, softVol", Rect(500, 200, 400, 240)).front;
w.view.addFlowLayout;
NdefGui(Ndef(\test), 2, w);

	// can lose control if wiggled too fast
EZSlider(w, 340@30, \softSet, \freq, { |sl| 
	Ndef(\test).softSet(\freq, sl.value, 0.05)
});

	// knows it was in control
EZSlider(w, 340@30, \knowsLast, \freq, Routine { |sl| 
	var newVal, lastVal; 
	loop { 
		newVal = sl.value;
		Ndef(\test).softSet(\freq, newVal, 0.05, lastVal: lastVal);
		lastVal = newVal;
		\dummy.yield;
	}
});

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



