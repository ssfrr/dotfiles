SCPopUpMenu			a pop up menu	

Inherits from: Object : SCView : SCControlView

See also: EZPopUpMenu

Some Important Issues Regarding SCPopUpMenu

By default, SCPopUpMenu will respond only to drags where the drag contains a Number.

Creation / Class Methods

	*new (parent, bounds)
	
		parent - The parent view.
		bounds - An instance of Rect, or a Point indicating width@height.
		
		(
			w = Window.new.front;
			m = PopUpMenu(w,Rect(10,10,180,20));
			m.items = ["linear","exponential","sine","welch","squared","cubed"];
			m.action = { arg menu;
				[menu.value, menu.item].postln;
			};
		)	

Accessing Instance and Class Variables

	items
	items_ (array)
	
		array - An Array of Strings or Symbols, which make up the items in the pop up menu.
		
		The underlying OS X graphics system gives special meanings to some characters.
		e.g. :
		- is a divider line
		
		Also these: < = (
		
		(
			w=SCWindow.new.front;
			m = SCPopUpMenu(w,Rect(10,10,180,20));
		
			m.items = [
			"", 						// ignored !
			" ", 					// displays as a blank
			"1 absolute",
			"-replaced by a divider", 	// starting with a -
			"3 relative",
			
			"4 fore <= aft", 			// fore aft ( <= disappears )
			"5 fore <hello aft", 		// fore ello aft
			"6 something -> else", 		// ok
			
			"7 fore hello aft", 		// fore hello aft
			"8 fore -hello aft", 		// fore -hello aft (one - )
			"9 fore -<hello aft", 		// fore ello aft
		
			"10 something (else)", 		// item greyed out
			"11 something \(else)",		// item still greyed out
			"12 something [else]", 		// ok
			"13 something {else}", 		// ok
		
			"14 something | else" 		// ok
		
			];
		)		


	item
	
		Returns items.at(this.value)
	
	value
	
		Returns the index of the currently chosen item. This will not do the action.

	value_ (val)
	
		Sets the menu to display the item at index val of the items array. This will not do the action.
		val - The index of an item in the items array .

	valueAction_ (val)
	
		Sets the menu to display the item at index val of the items array, and evaluates action (see SCView), if the value has changed.
		val - The index of an item in the items array .
		
Customizing Appearance

	font
	font_ (argFont)
	
		Sets the Font of the pop up menu. This only changes the font for the displayed item, not for the popped up menu.
		argFont - An instance of Font.

	stringColor
	stringColor_ (color)
	
		Set the current string Color for the display of the menu items . This only changes the string color for the displayed item, not for the popped up menu.
		color - An instance of Color.

Subclassing and Internal Methods
	The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed.

	properties
	
		A list of properties to which this view responds. See SCView.
		
		returns:
		[ \bounds, \visible, \enabled, \canFocus, \resize, \background, \minWidth, \maxWidth, \minHeight, \maxHeight, \value, \font, \items, \stringColor, \focusColor ]	
		
	defaultGetDrag
	
		The method called by default when initiating a drag from an SCMenu. Returns the same as value.
	
	defaultCanReceiveDrag
	
		The method called by default when attempting to drop a drag in this object. Returns currentDrag.isNumber, i.e. by default, SCPopUpMenu will respond only to drags where the drag contains a number.	
					
	defaultReceiveDrag
	
		The default method called when a drag has been received. Performs valueAction_ with the currentDrag as an argument.
				
	defaultKeyDownAction (char, modifiers, unicode)
	
		The default keydown actions are:
		
		key				action			comment
		" " 				value + 1			space
		\r 				value + 1
		\n, 				value + 1	
		3.asAscii,			value + 1			(enter key or cmd-C on Mac OSX )
		unicode 16rF700, 	value - 1			up arrow
		unicode 16rF703, 	value + 1			right arrow
		unicode 16rF701, 	value + 1			down arrow
		unicode 16rF702, 	value - 1			left arrow
		
		All of these are done with action.
				
Examples
(
	w = Window.new("The Eightfold Path").front;
	m = PopUpMenu(w,Rect(10,10,180,20));

	m.items = [
		"right view","right thinking","right mindfulness","right speech",
		"right action","right diligence","right concentration","right livelihood"
	];
	
	m.background_(Color.white.alpha_(0.2)); // only changes the look of displayed item
	m.stringColor_(Color.white); 			// only changes the look of displayed item
	m.font_(Font("Courier", 13)); 			// only changes the look of displayed item
	m.action = { arg menu;
		[menu.value, menu.item].postln;	
	};
)
		
m.value; 			// returns the index of the current item;
m.item;			// returns the String or Symbol of the current item	
	
m.value_(2); 		// changes the displayed item, but does not evaluate the action
m.valueAction_(3); // evaluates the action.


// Play different Functions

(
s.waitForBoot({

	var w,menu,snd,funcs,b;
	
	w=Window.new.front;
	
	menu=PopUpMenu(w,Rect(10,10,90,20))
		.items_(["Sine" , "Saw" , "Noise" , "Pulse"]);
	
	funcs=[ {SinOsc.ar(440,0,0.3)} , {Saw.ar(440,0.3)} , {WhiteNoise.ar(0.3)} , {Pulse.ar(440,0.2,0.3)} ];
	
	b=Button(w,Rect(110,10,180,20))
		.states_([["play",Color.black,Color.green]])
		.mouseDownAction_({
				snd = funcs.at(menu.value).play;	
			})
		.action_({ arg butt, mod;
				snd.free;
			});
		
	w.front;
	
	p=CmdPeriod.add({b.value_(0)});// set button to 0 on hitting Cmd-period
	w.onClose_{ snd.free; CmdPeriod.removeAll };// clean up when window is closed

})
)






