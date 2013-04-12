MonitorGui			display and control a Monitor	

Inherits from : JITGui

MonitorGui displays the state of a NodeProxy's Monitor. 
It is used in NdefGui, ProxyMixer, and NdefMixer. 

See also: NodeProxy, Ndef, JITGui, NdefGui


First examples

s.boot;
Ndef(\a).ar;
Ndef(\k).kr;

	// make a MonitorGui with all bells and whistles
m = MonitorGui.new(bounds: 500@40, options: [\playN, \name, \level, \fade]);

	// when it has a kr proxy, it is visible, but disabled
m.object_(Ndef(\k));
	// with an ar proxy, it is enabled
m.object_(Ndef(\a));

	// show its play state
Ndef(\a).play		// 
	// and volume
Ndef(\a).vol_(0.25);
Ndef(\a).stop

	// switch to playN mode - spread outputs should show
Ndef(\a).playN([0, 2]);
	// switch back to play - spread outbox goes back
Ndef(\a).stop;
Ndef(\a).play(0);


Creation

	*new (object, parent, bounds, makeSkip, options)
	
		object - the nodeproxy whose monitor state will be shown, or nil.
		parent - a parent view where MonitorGui is to be shown. If nil, a window is made.
		bounds - bounds where the view (or window) will be shown.
		makeSkip - a flag whether to create and start a SkipJack for auto-updating.
		options - an array of symbols for options of what to display. 
		
		g = MonitorGui(Ndef(\a));	// barebones
(
		w = Window.new.front; 
		w.addFlowLayout;
		g = MonitorGui(Ndef(\a), w, 300@40);
)
	// different options: 
	// a playN dialog button
g = MonitorGui.new(Ndef(\a), options: [\playN])

	// bounds 
MonitorGui.new(Ndef(\a), bounds: Rect(100, 100, 400, 30), options: [\playN])
MonitorGui.new(Ndef(\a), bounds: 400@24, options: [\playN])

	// level name and numerical value
MonitorGui.new(Ndef(\a), options: [\playN, \level])

	// a nameView and a fadeTime setter box
MonitorGui.new(Ndef(\a), options: [\playN, \name, \fade])

	// all of 'em
MonitorGui.new(Ndef(\a), options: [\playN, \level, \name, \fade])


Class Variables
	
	lastOutBus	the highest outbus number to allow. Default is 99.

				
Instance Variables

	config		some information on what to display

	ampSl		an EZSlider for Monitor volume
		
	playBut		a play button - shows play or playN 
		
	setOutBox	a numberbox to set output routing
		
	playNDialogBut	opens a dialog window for playN output routing by code
						
	fadeBox		a numberbox for setting monitor fadeTime.				

	
Some Methods

	
	playNMode_ (flag)	switches between playN mode (true) and play mode (false)
		
	checkUpdate		compare previous state with current state, and update gui elements.
		



