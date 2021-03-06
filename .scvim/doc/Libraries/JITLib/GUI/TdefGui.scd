TdefGui 	a line of editing controls for a Tdef, and optionally its envir.

Inherits from: JITGui: TaskProxyGui (like PdefGui)

A gui showing the Tdef's name, playing state, source state, and envir state. 
Optionally, its envir can also be edited.

First example:

g = TdefGui();				// make a TdefGui 
g.object = Tdef(\a);			// show when a Tdef is put in
Tdef(\a, { "boing".postln }); 	// show whether it has a source
Tdef(\a).play; 				// show whether playing, stopped, or ended, and pausable
Tdef(\a).set(\abc, 123); 		// show whether the tdef has an envir

g = TdefGui(Tdef(\a), 3);	// with an envirgui for 3 items
Tdef(\a).set(\a, 12, \lofreq, [1, 10], \str, "someString", \oops, \oneSymbolTooMany);

(							// put it in an existing window - margin becomes 0@0
w = Window().front; w.addFlowLayout;
TdefGui(Tdef(\a), 0, w);
TdefGui(Tdef(\a), 3, w);
)
Details on the GUI elements:

name button: 
	when selected, typing the delete key will delete its tdef.

play/stop button : 
	indicates whether the tdef is playing: 
		" >"  	if stopped, 
		" _" 	if playing and active, 
		" |" 	if it is playing, but the stream has ended. 
	
pause/resume button: 
	only visible if one can pause or resume the Tdef, i.e. while it is playing.
	"paus" is shown when you can pause it,
	"rsum" is shown when you can resume it.

src button: 
	opens a document to edit the source (function) of the Tdef.
	green if a source exists, white if the source is nil.

env button: 
	click opens a document to edit the envir of the Tdef, 
	option-click opens a new TdefGui with a big enough 
	EnvirGui for the Tdef's envir.
	green if the tdef has an envir, white if the envir is nil.


Creation Methods

	*new (object, numItems, parent, bounds, extras, makeSkip)
	
		Create a new JITGui that will be watching an object and display its state.
		object - 	the object to watch 
		numItems - the number of display items to use, e.g. how many fields for text, 
				or how many EZSliders for single-number parameters.
		parent - 	a parent view on which to display. If nil, a new window is created;
				parent can also be an existing window or a composite view.
		bounds - 	a desired size and position where to display a JITGui. can be nil, 
				a point, or a rect. JITGuis know their minimum size (minSize), 
				and if bounds is nil, minSize is used.
				if bounds is a point or rect, it will be set to at least minSize.
				With a rect one can also supply a position where to display.
				If a point,shown size is the maximum of bounds and minSize 
		options - 	a list of additional information, e.g. flags about optional buttons.
				(this is used is some subclasses)
				
		makeSkip - A flag whether to make a skipjack. If one uses a TdefGui as part of a 
				larger gui ensemble, one may want to call checkUpdate on all of them 
				together, not with separate skipJacks.


(
Tdef(\a, { |e| 100.do { |i| i.postln; 0.5.wait } });
t = TdefGui(Tdef(\a), 4);
Tdef(\a).set(\freq, 200, \dur, 0.1, \otto, 12, \ann, 1234);
)

Tdef(\a).stop;
Tdef(\a).play;
Tdef(\a).pause;
Tdef(\a).resume;

t.object_(nil);
t.object_(Tdef(\a));

(
w = Window("put it in a selfmade window").front;
w.addFlowLayout;
w.view.decorator.shift(50, 50);
TdefGui(Tdef(\a), 12, w)
)

Tdef(\b,  { |e| 100.do { |i| Tdef(\a).set(\otto, 8.rand); exprand(0.1, 3.0).wait } });
Tdef(\b).play;
TdefGui(Tdef(\b));

	// see all Tdefs: 
TdefAllGui(16);

See also TdefAllGui, PdefGui, PdefAllGui.


Instance Variables
	
	object 		a Tdef, or nil
	
	numItems	the number of items in the envirGui 
							
	parent		the parent view 
	
	bounds 		the bounds of the zone

	zone			the CompositeView within which the TdfGui is shown
						
	
	nameBut, playBut, pauseBut, srcBut, envBut	the buttons
										
	envirGui		the gui for the Tdef's envir - if numItems > 0.
		
				
Instance Methods

	object_ (obj)	put an object in the gui. 		
	
		// if the jitGui is in its own window, you can:
	moveTo (h, v)	move it to some specific location.

	clear			set the TdefGui's object to nil
				
	close		and close its window.

	
Internal methods:

	srcString		a compileString that recreates the Tdef. 
		
		// assume g from above is still there
		g.srcString;

	editString (edKey)		a compileString that recreates the Tdef's envir at edKey. 
	editStrings (edKeys)	a compileString that recreates the Tdef's envir at edKeys.
	
		Short prose description of method.
		edKey - Explanation of edKey. Default value is nil. Other information.
		
		// assume g from above is still there
		g.editString;
		Tdef(\a).set(\foo, \bar);
		g.editString(\foo);

		g.editStrings;

	getUsedKeys				the keys in use in the envir
		
		g.getUsedKeys;


	openDoc (strings, bounds)  	open a document with some strings at some location.
							used with src button, env button.
			
		g.openDoc(g.editStrings);


	makeEnvirGui				make an envirGui within zone.


