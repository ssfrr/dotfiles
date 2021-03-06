softPut 		set a (number) parameter in an environment conditionally

See also softSet, softVol_.

	changes an existing numerical value for key in a dictionary only  in two conditions: 

	* if the new value is close enough to the current value at that key;
	*or  if the setting controller knows the previous value and sends it 
		along. the idea here is that if the controller knows it did the last 
		value change, it has authority to jump now.
	
	softPut(param, val, within = 0.025, lastVal, mapped = true, spec)
		param - 	the name of the parameter (key) to set
		val - 		the value to set the param to (can be mapped or unmapped)
		within  	the normalized range within which the set is accepted - default is 0.025
		mapped	a flag whether val is mapped (within the range of param.asSpec) or unmapped (0.0-1.0)
		lastVal	the previous value that a control has set - see last examples.
		spec	a ControlSpec can be passed in. if nil, param.asSpec is used.

		NOTE: if no spec is given, or no value exists yet, softSet simply allows setting.


Typical uses would be switching to a new preset, then using a faderbox, 
and avoiding sudden controller jumps that could occur (soft takeover).

(
e = (amp: 0.1, dur: 0.2);
Tdef(\test, { 
	var dur;
	loop { 
		dur = e.dur;
		(amp: e.amp, dur: dur, degree: 7.rand).play;
		dur.wait;
	};
}).play;
)

e.put(\amp, 0.03);		// just set it	
e.put(\amp, 0.1);		
e.softPut(\amp, 0.11);	// small change, OK to set
e.put(\amp, 0.1);		
e.softPut(\amp, 0.15);	// no bigger change
e.softPut(\amp, 0.15, 0.1);	// bigger change is OK with larger within value

e.softPut(\amp, 0.01);	// no
e.softPut(\amp, 0.01, lastVal: 0.15);	// can make big jumps when lastVal is close to current.

	
	// no spec for dur exists by default:
	\dur.asSpec

e.softPut(\dur, 0.05);	// so this always really sets.



	// PatternProxies ( e.g. Tdefs, Pdefs) have a softSet method, which 
	// forwards softPut to their envirs:

Pdef(\test, Pbind(\degree, Pseq((0..7), inf))).play;

Pdef(\test).set(\amp, 0.03)
Pdef(\test).envir.softPut(\amp, 0.06); // no, too big
Pdef(\test).envir.softPut(\amp, 0.06, 0.1); // ok with wider range

	// equivalent: 
Pdef(\test).set(\amp, 0.03)
Pdef(\test).softSet(\amp, 0.1); // no, too big
Pdef(\test).softSet(\amp, 0.06, 0.1); // ok with wider "within"
Pdef(\test).get(\amp)

Pdef(\test).softSet(\amp, 0.5); // no!
Pdef(\test).softSet(\amp, 0.5, lastVal: 0.06); // ok!
Pdef(\test).softSet(\amp, 0.05, lastVal: 0.5); // ok

Pdef(\test).softSet(\dur, 0.05); // alsways ok, no spec for dur.
Pdef(\test).softSet(\dur, 0.1); // ok 

Pdef(\test).softSet(\dur, 0.05, spec: [0.03, 3, \exp]); // not OK with that spec


	// softPut and softSet can be risky - one can lose a parameter when moving a controller
	// too quickly. So, if we know the last value (e.g. because the same controller 
	// knows it has set to that value),  it is OK to jump:

	// example of softSet, softSet which knows lastVal,
	// softVol_ and softVol_ which knows lastVol:
(
w = Window("softSet, softVol", Rect(500, 200, 400, 240)).front;
w.view.addFlowLayout;
PdefGui(Pdef(\test), 2, w, 340@80);

	// can lose control if wiggled too fast
EZSlider(w, 340@30, \softSetDur, [0.03, 3, \exp], { |sl| 
	Pdef(\test).softSet(\dur, sl.value, 0.05)
});

	// knows it was in control
EZSlider(w, 340@30, \knowsLast, [0.03, 3, \exp], Routine { |sl| 
	var newVal, lastVal; 
	loop { 
		newVal = sl.value;
		Pdef(\test).softSet(\dur, newVal, 0.05, lastVal: lastVal);
		lastVal = newVal;
		\dummy.yield;
	}
});
)



