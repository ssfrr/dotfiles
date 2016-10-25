SCListView			a list view	

Inherits from: Object : SCView : SCControlView

See also: SCPopUpMenu

Some Important Issues Regarding SCListView

By default, SCSlider will respond only to drags where the drag contains a Number.

Creation / Class Methods

	*new (parent, bounds)
	
		parent - The parent view.
		bounds - An instance of Rect, or a Point indicating width@height.
		
		(
		w = Window.new.front;
		v = ListView(w,Rect(10,10,120,200));
		v.items = [ "item 1", "item 2", "item 3", "item 4", "item 5"];
		v.action = { arg q; [ q.value, v.items[ q.value ] ].postln;	};
		)

Accessing Instance and Class Variables

	items
	items_ (array)
	
		array - An Array of Strings or Symbols, which make up the items in the pop up menu.
		
	item
	
		Returns items.at(this.value)
		
	value
	value_ (val)
	
		Gets/sets the index of the currently highlighted item. This will not do the action.
		val - The index of an item in the items array .

	valueAction_ (val)
	
		Sets the menu to highlight the item at index val, and evaluates action (see SCView), if the value has changed.
		val - The index of an item in the items array .
		
	enterKeyAction_(arg1)
	enterKeyAction
		
		Instead of, or additionally to defining an action (see SCView), you can define an action which will be performed only if you hit the enter key while the list view is focussed.
				
Customizing Appearance

	font
	font_ (argFont)
	
		Sets the Font of the list. Default value is the default font: Font.default .
		argFont - An instance of Font.

	stringColor
	stringColor_ (color)
	
		Set the string Color for the unselected items in the list .
		color - An instance of Color.
				
	selectedStringColor
	selectedStringColor_ (color)
	
		Set the string Color for the selected item .
		color - An instance of Color.

	hiliteColor
	hiliteColor_ (color)
	
		Set the background Color for the selected item .
		color - An instance of Color.

	colors
	colors_(incolors)
		
		Set the background Color for the items.
		incolor - An Array of Colors

Subclassing and Internal Methods
	The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed.

	defaultKeyDownAction (char, modifiers, unicode)
	
		The default keydown actions are:
		
		key				action				comment
		" " 				value + 1	with action	space
		\r 				enterKeyAction
		\n, 				enterKeyAction	
		3.asAscii,			enterKeyAction			(enter key or cmd-C on Mac OSX )
		unicode 16rF700, 	value - 1 with action		up arrow
		unicode 16rF703, 	value + 1 with action		right arrow
		unicode 16rF701, 	value + 1 with action	down arrow
		unicode 16rF702, 	value - 1 with action		left arrow

	properties
	
		A list of properties to which this view responds. See SCView.
		
		returns:
		[ \bounds, \visible, \enabled, \canFocus, \resize, \background, \minWidth, \maxWidth, \minHeight, \maxHeight, \value, \font, \items, \stringColor, \align, \itemColors, \focusColor ]

	init (argParent, argBounds)
	
		Overrides SCView:init.
		
	defaultGetDrag
	
		The method called by default when initiating a drag from an SCListView. Returns the same as value.
			
	defaultCanReceiveDrag
	
		The method called by default when attempting to drop a drag in this object. Returns the result of currentDrag.isNumber.
				
	defaultReceiveDrag
	
		The default method called when a drag has been received. Performs valueAction_ with the currentDrag as an argument.

Examples

(

w = Window.new.front;

v = ListView(w,Rect(10,10,120,70))
	.items_([ "SinOsc", "Saw", "LFSaw", "WhiteNoise", "PinkNoise", "BrownNoise", "Osc" ])
	.background_(Color.clear)
	.hiliteColor_(Color.green(alpha:0.6))
	.action_({ arg sbs;
		[sbs.value, v.items[sbs.value]].postln;	// .value returns the integer
	});
)


// Sound example use to switch Filters
(
Server.default = s = Stethoscope.defaultServer.boot;
s.waitForBoot({
	var f, freq, ww;
	n={r=LFSaw.ar([220, 530],0,0.3)*LFPulse.ar(12,0,0.3,0.4); [r[0],Delay2.ar(r[1])]}.play;
	freq={SinOsc.kr(0.5,0,4000,4200)}.play;
	w=Window("Filters").front;
	v = ListView(w,Rect(10,10,180,120))
		.items_([ "No Filter","RLPF", "RHPF", "BPF", "Resonz", "MoogFF" ])
		.background_(Color.clear)
		.hiliteColor_(Color.green(alpha:0.6))
		.action_({arg v;
			v.value.switch(
			0,{try{f.free};"test".postln},
			1,{try{f.free};f={ReplaceOut.ar(0,RLPF.ar(In.ar(0,2),In.kr(0,1),0.2,0.3))}.play(addAction:\addToTail)},
			2,{try{f.free};f={ReplaceOut.ar(0,RHPF.ar(In.ar(0,2),In.kr(0,1),0.2,0.3))}.play(addAction:\addToTail)},
			3,{try{f.free};f={ReplaceOut.ar(0,BPF.ar(In.ar(0,2),In.kr(0,1),0.2,1.5))}.play(addAction:\addToTail)},
			4,{try{f.free};f={ReplaceOut.ar(0,Resonz.ar(In.ar(0,2),In.kr(0,1),0.2,2))}.play(addAction:\addToTail)},
			5,{try{f.free};f={ReplaceOut.ar(0,MoogFF.ar(In.ar(0,2),In.kr(0,1),1.5))}.play(addAction:\addToTail)}
			);
		
		});
		
	ww=FreqScope.new(400, 200, 0);
	w.bounds=Rect(50,Window.screenBounds.height-300,200,200);
	ww.window.bounds=ww.window.bounds.moveTo(255,Window.screenBounds.height-328);
	CmdPeriod.doOnce({{ww.window.close}.defer(0.5);w.close;});
			//defer or crash, because FreqScopeWindow Class contains its own routine for cleaning up on CmdPeriod
	w.onClose_({n.free;f.free;freq.free});
});
)



