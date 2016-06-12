SCNumberBox			a box for displaying and editing numerical values	

Inherits from: Object : SCView : SCStaticTextBase

See also: SCTextField

Some Important Issues Regarding SCNumberBox
Whatever is entered into the number box is converted to a Float upon hitting return or enter. You can also use exponential notation for entering a number, e.g. "2.1e-2" will be converted to 0.02. Drag and drop accepts a Number.  SCNumberBox inherits formatting methods from SCStaticTextBase. 

By default, scroll is set to to true, and you can use mouse scrolling in the SCNumberBox by step. By default, the shift, ctrl, and alt keys will modify the arrow stepping and scrolling by 100x, 10x, or 0.1x respectively, though you can customize this by setting shift_scale, ctrl_scale, or alt_scale..  


Creation / Class Methods

	*new (parent, bounds)
	
		parent - The parent view.
		bounds - An instance of Rect, or a Point indicating width@height.
		
		(
		w = Window("NumberBox Example", Rect(100, 500, 400, 120));
		b = 	NumberBox(w, Rect(150, 10, 100, 20));
		b.value = rrand(1,15);
		b.action = {arg numb; numb.value.postln; };
		w.front
		)

Accessing Instance and Class Variables

	value
	value_ (val)
	
		Sets/gets the number box value. This will not evaluate the function assigned to action (see SCView).
		val - A numerical value. You can also use exponential notation for entering a number, e.g. 2.1e-2 will be converted to 0.02.

	valueAction_ (val)
	
		Sets the number box to display val, and evaluates action (see SCView), if the value has changed.
		val - The index of an item in the items array .

	step_(val)
	step
		
		The size of the step for the increment and decrement methods.
		val - An instance of Float.

	clipLo_(aFloat)
	clipHi_(aFloat)
	clipLo
	clipHi
		
		Constrain the receiver's value to clipLo and clipHi.
		clipLo defaults to -inf - no clipping.
		clipHi defaults to inf - no clipping.
		aFloat - An instance of Float.

Mouse click and drag scrolling behavior

	scroll_(bool)
	scroll
		
		Enable/disable the receiver's mouse click and drag scrolling behavior.
		scroll defaults to true. 
		
	scroll_step_(val)
	scroll_step
		
		The default size of the step for mouse scrolling. This is modified by shift_scale, ctrl_scale, and alt_scale.
		val - An instance of Float.

	shift_scale_(aFloat)
	shift_scale
		
		A value for increment's or decrement's zoom argument while mouse scrolling  or arrow keys, and while the shift key is pressed. 
		shift_scale defaults to 100.
		aFloat - An instance of Float.

	ctrl_scale_(aFloat)
	ctrl_scale
		
		A value for increment's or decrement's zoom argument while mouse scrolling or arrow keys, and while the ctrl key is pressed. 
		ctrl_scale defaults to 10.
		aFloat - An instance of Float.
		
	alt_scale_(aFloat)
	alt_scale
		
		A value for increment's or decrement's zoom argument while mouse scrolling or arrow keys, and while the alt key is pressed. 
		ctrl_scale defaults to 0.1.
		aFloat - An instance of Float.

Customizing Appearance

	boxColor
	boxColor_ (color)
	
		This has been deprecated. Use background / background_ instead. See SCView.
		
	normalColor_(arg1)
	normalColor
		
		The default is Color.black. You can use the normalColor and the stringColor in combination to indicate if the contents of the box have changed. When you create the box, its string color is the color you set in stringColor. The if you change the box contents, either with the keyboard or with the setter, value_ , then the color changes to normalColor.  
		
		arg1 - An instance of Color.
		
		(
		w = Window("NumberBox Example", Rect(100, 500, 400, 120));
		b = 	NumberBox(w, Rect(150, 10, 100, 20));
		b.value = 5;
		b.stringColor=Color.black;
		b.normalColor=Color.green(0.8);
		b.action = {arg numb; numb.value.postln; };
		w.front
		)
		
		b.value = 12;
		
	typingColor_(arg1)
	typingColor
		
		The string color while typing a new value in the number box. The default is Color.red.
		arg1 - An instance of Color.
						
Subclassing and Internal Methods
	The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed.

	increment(mul)
	
		Increments the value of the box by step. Called by defaultKeyDownAction, but you can call it directly too.

	decrement(mul)
	
		Decrements the value of the box by step. Called by defaultKeyDownAction, but you can call it directly too.
		
	keyString_(arg1)
	keyString
		
		A String containing what the user types into the number box. It is converted to a Float upon hitting return or enter. This also allows you to use exponential notation for entering a number, e.g. 2.1e-2 will be converted to 0.021 .
		
	init (argParent, argBounds)
	
		Overrides the init method of SCView.

	defaultKeyDownAction (char, modifiers, unicode)
	
		The default keydown actions are:
		
		key				action				comment
		3.asAscii,			enter typed value		(enter key or cmd-C on Mac OSX )
		unicode 16rF700, 	increment by step		up arrow
		unicode 16rF703, 	increment by step		right arrow
		unicode 16rF701, 	decrement by step		down arrow
		unicode 16rF702, 	decrement by step		left arrow	

	properties
		
		A list of properties to which this view responds. See SCView.
		
		returns:
		[ \bounds, \visible, \enabled, \canFocus, \resize, \background, \minWidth, \maxWidth, \minHeight, \maxHeight, \string, \font, \stringColor, \boxColor, \focusColor ]
		
	defaultGetDrag
	
		The method called by default when initiating a drag from an SCNumberBox. Returns object.asFloat.
		
	defaultCanReceiveDrag
	
		The method called by default when attempting to place a drag in this object. By default, SCNumberBox will respond only to drags where the drag contains a Number.
								
	defaultReceiveDrag
	
		The default method called when a drag has been received. Performs valueAction_() using currentDrag as an argument	
Examples

(
	w = Window("NumberBox Example", Rect(100, 500, 400, 120));
	b = 	NumberBox(w, Rect(150, 10, 100, 20));
	b.value = rrand(1,15);
	b.action = {arg numb; numb.value.postln; };
	w.front
)
// try these one at time
b.value = rrand(1,15) ; 	// sets the value but does not perform the action
b.valueAction_(5); 		// sets the value and performs the action
b.step_(0.1);			// change the increment/decrement size for the arrow keys
b.scrollStep=10;    // change the increment/decrement size for the mosueScrolling

b.background_(Color.grey); 			// change the background color of the box
b.typingColor_(Color(0.3,1,0.3)); 	// change the typing color for the box
b.normalColor_(Color.white);		// change the normal color for the box. won't change until next value change

b.setProperty(\stringColor,Color.white);
b.setProperty(\align,\center);

b.increment; // increment or decrement by step
b.decrement;



// change freqency of a playing synth by step using arrow keys

(	
	s.waitForBoot({
		
		n={arg freq=220;
			var out;
			out=SinOsc.ar(freq,0,0.2);
			8.do{out = AllpassN.ar(out, 0.2,0.02+0.20.rand,8)};
			out;
		}.play;
		
		w = Window("Use arrow keys to change the frequency by steps", Rect(100, 500, 500, 120));
		b = 	NumberBox(w, Rect(200, 10, 100, 20));
		b.value = 220;
		b.action = {arg numb; n.set(\freq,numb.value); };
		b.step=55; //make the step a fraction of the freq
		b.focus;
		w.front;
		
		CmdPeriod.doOnce({w.close});
		
	});
)






