JITGui		a superclass for just in time interfaces

Inherits from: Object

Proxies for synths, tasks and patterns as implemented in JITLib are extremely flexible. 
Having guis that represent their changeable states makes it easier to understand 
what is going on, especially when using multiple proxies together. 
JITGuis follow a special strategy described below.

See also:  
	EnvirGui, 
	TdefGui, TdefAllGui, (TaskProxyGui)	// TdefGui replaces obsolete TdefEditor
	PdefGui, PdefAllGui, (TaskProxyAllGui)	// PdefGui replaces obsolete PdefEditor
	NdefGui, MonitorGui, NdefParamGui 	// replace NodeProxyEditor, ProxyMonitorGui
	ProxyMixer	
	NdefMixer

	still to be done:
	(ProxyChain) ProxyChainGui
	(PxPreset) PxPresetGui
	(maybe SoftSet)


Creation

	*new (object, numItems, parent, bounds, options, makeSkip)
	
		Create a new JITGui that will be watching an object and displaying its state.
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
				
		makeSkip - A flag whether to make a skipjack.
		
		g = JITGui.new(nil, 0);		// make one
		g.object = 123;			// object gets shown asCompileString
		g.object = (key: \otto); 	// if the object understands .key, key gets shown
		g.object = Pseq([1, 2, 3], inf);
		g.close;


Accessing Instance Variables
	
	g.dump;

	object 		the object to watch 
	numItems 	the number of display items to use, e.g. how many fields for text, 
				or how many EZSliders for single-number parameters.				
	parent 		a parent view on which the gui is displayed. 
	bounds 		the size and position of the JITGui
							
	zone			a CompositeView inside the parent that holds the JITGui's views.
	minSize		a JITGuis calculates its own minimum size based on numItems and options.
	defPos		the default position where the JITGui is shown if it is in its own window.

			// Appearance:
	skin			the GUI skin to use. By default this is GUI.skins.jit.				
	font			the font, also taken from JITGui.skin.
	
			// specific in the JITGui class: 
	nameView	displays the object's key if available.
	csView		displays the object's compileString.
		
			// common to all JITGuis: 
	prevState	the last observed state which is kept around for comparison.	

	skipjack		the skipjack that watches the object's state so it can be updated.
	scroller		an EZScroller used for scrolling which of a list of items is shown. 
				see e.g. TdefGui for usage.
	hasWindow	a flag whether the JITGui has made its own window, and thus owns it.


Instance Methods

	object_ (obj)	put an object in the gui - if the gui accepts it.	

	accepts(obj)	test whether obj is a valid object to show in a JITGui.
				In JITGui itself, all objects are accepted, in the subclasses, 
				obj can either be nil or a specific class, such as Tdef, Pdef, Ndef, 
		
	name_		set the text of the nameView and the window (if it hasWindow)
	getName		ask the object its name, or return '_anon_'
	winName		return a suitable name for a window: "JITGui_objname"
	 
	moveTo (h, v)	if it has its own window, one can move it to some specific location.

	close		close its window.



How JITGuis work: 
	A JITGui watches the state of its object by calling its (the gui's) getState method.
	It compares the new state of the object with the previous state stored in prevState.
	When something has changed, the gui elements concerned are updated.
	
Methods that subclasses should implement

	You can write your own subclasses to JITGui very efficiently by 
	implementing appropriate variants of the following methods in your class.
	For examples of these methods, see TaskProxyGui, EnvirGui, NodeProxyGui.

	setDefaults	used to calculate the required onscreen size for the jitGui's zone. 
				Should determine zone size based on numItems and options. 
				also, defPos (where to show your jitGui by default) can be set here, 
				and possibly modifications to the skin used. 
		
	accepts (obj)	a test whether obj can be shown in the particular kind of JITGui.
				Subclasses of JITGui are made for special objects, e.g. Pdefs, 
				so they should test whether obj is the right kind.

	makeViews	create all the views of the jitGui inside the zone.


For updating the JITGui, these are essential:
			
	getState		ask the object for all aspects of its current state that will be displayed.

	checkUpdate	get the object's current state with prevState, compare it with prevState, 
				update all gui elements that need to be changed, 
				and store the new state as prevState.
				This method is called in the skipJack.


More methods you may want to overwrite if required:

	calcBounds 	how to calculate the bounds for the zone in which to display
	
	makeWindow	how to make a window when no parent is given
	
	makeZone	how to initalize the zone within the parent window or view

	getName		a method for generating a name for the object. 
	
	winName		a method for generating a name for the JITGui's window.

	makeScroller	Some objects may have more elements to display than the gui has slots, 
				e.g. a ProxySpace can have more proxies than the mixer has numItems.
				Then, only numItems elements are shown, and the others can be scrolled
				to with scroller - an EZScroller next to the slot elements. 
				The makeScroller method knows where in the zone to put the scroller.


	// some layout tests
	
	// make its own window - defPos, minSize is used
g = JITGui(Ndef(\a));

	// make its own window, specific size
g = JITGui(Ndef(\a), bounds: 390@20);

	// provide full bounds
g = JITGui(Ndef(\a), bounds: Rect(200, 500, 390, 24));

	// extent is 0@0: minSize x, y is used
g = JITGui(Ndef(\a), bounds: Rect(200, 500, 0, 0));
g = JITGui(Ndef(\a), bounds: Rect(200, 500, 0, 50));
g = JITGui(Ndef(\a), bounds: Rect(200, 500, 500, 0));


(	// put a JITGui in an existing window:
w = Window().front; 
g = JITGui(Ndef(\a), 0, w, bounds: 300@48);
)

(	// 5 lines high
w = Window().front; 
g = JITGui(Ndef(\a), 5, w);
)

(	// recommended: use a FlowLayout.
w = Window().front; 
w.addFlowLayout;		
EZSlider(w, 300@100, \test, []);
g = JITGui(Ndef(\a), 0, w, bounds: 300@40);
)



