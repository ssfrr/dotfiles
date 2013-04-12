NdefParamGui			display the settings of a nodeproxy

Inherits from: JITGui : EnvirGui

NdefParamGui displays all settings and mappings of a nodeproxy, so one can change them flexibly. 
Single number get displayed with an EZSlider, and anything else is shown as an EZText (a text field). 
Its main use is within NdefGui and PxMix.

See also: EZText, NdefGui, PxMix


Creation / Class Methods

	*new (object, numItems, parent, bounds, options, makeSkip)
	
		create a new NdefParamGui
		object - the nodeproxy whose settings are to be displayed
		numItems - the number of items to display. If an envir is given, and no num, num is envir.size.
		parent - the parent view to display in; if none is given, a new window is created. 
		bounds - the bounds within which to display; if none is given, bounds are calculated.
		options - 	a list of additional information, e.g. flags about optional buttons.
		makeSkip - flag whether to make a skipjack to manage updates of the envirgui. default is true.
		
		// simple example
		g = NdefParamGui.new(nil, 5);	// empty with 5 slots
		g.object_(Ndef(\a)); 			// put in a nodeproxy
		Ndef(\a, { |freq = 300, amp = 0.2| SinOsc.ar(freq) * amp });
		Ndef(\a).set(\freq, 2000);		// add a setting
		
		g.object_(nil); 			// put in a nodeproxy

		g.object_(Ndef(\a)); 			// put in a nodeproxy
		Ndef(\a).set(\amp, 0.125);		// add a setting
		Ndef(\a, { |freq = 300, amp = 0.2| SinOsc.ar(freq) * amp });
		Ndef(\a).set(\freq, 234);		// add a setting

		Ndef(\a).play
		Ndef(\lfo, { LFNoise0.kr([12, 8], 200).sum + 500 });
		Ndef(\a).map(\freq, Ndef(\lfo));	// mapped proxies are shown
	
	name_ (name)		if in its own window, set the window's name

		g.name = "Yoohoo";

	Multichannel controls are shown in EZText:
	
		Ndef(\a, { |freqs = #[300, 303], pan, amp = 0.2, moddd = 0.1| SinOsc.ar(freqs).sum * amp });
		Ndef(\a).play
		Ndef(\a).setn(\freqs, [300, 350])
		Ndef(\a).setn(\freqs, [330, 350])
		Ndef(\a).set(\harm, 123)

		Ndef(\a).nodeMap.clear
		
		Ndef(\lfos, { LFNoise0.kr([12, 8], 200) + 500 });
		Ndef(\a).map(\freqs, Ndef(\lfos))

		g.parent.close

	// put an NdefParamGui in an existing window - margin becomes 0@0
(
w = Window().front; 
w.addFlowLayout;
g = NdefParamGui(Ndef(\a), 3, w);
NdefParamGui(Ndef(\c), 15, w);
)
	// even 
Ndef(\c).set(\otto, 123, \mops, [1,2,3], \kotzt, [0, 6, 0, 6]);
Ndef(\c).nodeMap.clear



