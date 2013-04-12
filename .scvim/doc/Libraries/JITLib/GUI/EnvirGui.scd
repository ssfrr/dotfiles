EnvirGui			display the contents of an environment for editing

Inherits from: JITGui

EnvirGui displays all keys and values of an environment, so one can change them flexibly. 
Single number get displayed with an EZSlider, pairs of numbers with an EZRanger, 
and anything else is shown as an EZText (a text field).

See also: EZText, TdefGui, PdefGui,
	NPParamGui


Creation / Class Methods

	*new (object, numItems, parent, bounds, extras, makeSkip)
	
		create a new EnvirGui
		object - the envir to display
		numItems - the number of items to display. If an envir is given, and no num, num is envir.size.
		parent - the parent view to display in; if none is given, a new window is created. 
		bounds - the bounds within which to display; if none is given, bounds are calculated.
		name - a name to use for the envir/gui; is used for the auto-created window.
		makeSkip - flag whether to make a skipjack to manage updates of the envirgui. default is true.
		
		// simple example
		g = EnvirGui.new(nil, 5);						// empty with 5 slots
		g.object_((a: 1, b: \werty, freq: [500, 2000])); 	// put some things in
		g.envir.put(\karl, \otto1);						// one more
		g.envir.putAll((b: -12, r: 1, s: 2, t: 3, u: 4, v: 5)) 

		g.object_((x: 2)); 	// put something else in

		g.envir.putAll((b: -12, r: 1, s: 2, t: 3, u: 4, v: 5)) 
				
		g.envir.removeAt(\b)
		g.envir.removeAt(\r) 
		g.envir.removeAt(\s) 
		g.envir.removeAt(\t) 
		g.envir.removeAt(\u) 
		g.envir.removeAt(\v) 

		g.parent.close;


Instance Variables 
	
	numItems	how many envir items to display 
				
	envir	the envir displayed - actually an alias for object.

	zone		the composite view the envirgui makes for itself				

	valFields	the areas in which the key-value pairs are displayed.
		
	widgets	the EZGuis that display the values: 
		Single numbers will have an EZSlider, 
		pairs of numbers will be shown as an EZRanger, 
		all other values are shown as compileStrings in an EZText.
						
	specs	EZSlider and EZRanger needs specs for their display ranges;
		if there is a global spec for that key (key.asSpec), it will be used. 
		If not, a spec is generated (see the getSpec method) and kept in these (local) specs.  	
	
	keysRotation	
		if the size of envir exceeds numItems, the keys displayed can be rotated: 
		e.g. with 10 keys displayed on 5 valFields, 
		keysRotation 0 means show keys (0..4), 
		keysRotation 2 means show keys (2..6), etc.
								
				
Some Methods
	
	object_ (obj)	set the environment to show
	
		obj - can be nil, a dictionary, an environment, or an event.
				
		g = EnvirGui((freq: 120, \amp: 0.2, \pan: -0.5), 12, nil, bounds: Rect(20, 400, 220, 100)); 
		g.object_((a: 1, b: [2, 3], c: \symbol, d: [4, 5, 6], f: { "boing".postln }))
	
	envir_(envir)	same as object_(obj)
	
	name_ (name)		if in its own window, set the window's name

		g.name_("Yoohoo");

	getSpec (key, value)
	
		For editing, specs for the parameter ranges are needed. 
		These can be set locally in the EnvirGui, or global specs will be looked up.
		If no local or global specs exist for that parameter name, getSpec makes a 
		usable guess for them.
		key - the parameter name for which to find a spec
		value - the current value of that param, which may be used for guessing specs.
		
		// inline example
		g = EnvirGui.new;
		g.getSpec(\freq, 400); // \freq exists as global spec, so use that
		g.object_((freq: 150));

		g.getSpec(\iFrek, 500); 	// no global spec, so make a new one:
								// exponential from val * 0.05 to val * 20; 
		g.specs;					// and keep it here
		g.envir.put(\iFrek, 500);

	putSpec (key, obj)		add a spec for a given key, 
						or (if it is a global key) override a global spec with a local one: 
	
		g.putSpec(\iFrek, [10, 1000, \exp]); 	
		g.putSpec(\freq, [100, 1000, \exp]); 	
		g.object_((freq: 200, iFrek: 20));


		Some internal methods:
	
	setField (index, key, value, sameKey)
				set a field by index, with the new key, value; 
				sameKey means the field had the same key already.
	setByKeys	update the widgets for the current keys

	clearField (index)	remove the EZGui at this index
	clearFields		remove all unused EZGuis	


Examples


	// Setting envir variables in a Tdef:
(
Tdef(\text).set(\note, [0, 2, 7], \dur, { [0.1, 0.2, 0.4].choose }, \pan, 0, \amp, 0.1);

w = Window("EZTexts", Rect(200, 400, 304, 120)).front;
w.addFlowLayout;

TdefGui(Tdef(\text), 0, parent: w);

e = EnvirGui(Tdef(\text).envir, 4, parent: w);

Tdef(\text, { |ev| 
	var mydur;
	loop { 
		mydur = ev.dur;
		(note: ev.note, dur: mydur, amp: ev.amp, pan: ev.pan).postln.play;
		mydur.wait;
	}
}).play;
)

	// or equivalently, use the built-in EnvirGui in TdefGui:
TdefGui(Tdef(\text), 4);

Tdef(\text).set(\yuhu, Prand([2, 3, 5, 8, 13], inf), \magic, [\abra, \cadabra]);

Tdef(\text).clear;


