SCKnob			a gui control with round, horizontal or vertical action	

Inherits from: Object : SCView : SCUserView

See also: EZKnob

Creation / Class Methods

	*new (parent, bounds)
	
		parent - The parent view.
		bounds - An instance of Rect, or a Point indicating width@height.
		
		(
		w=Window.new("Knob", Rect(640,630,270,70)).front;
		k = Knob.new(w, Rect(20, 10, 48, 48));
		k.action_({|v,x,y,m| postf("action func called: %\n", v.value); });
		)

	*defaultMode
	*defaultMode_(val)
	
		Class variable that states the default tracking mode for new knobs..
		val - An instance of Symbol. \vert, \round, or \horiz. Default value is \round.
		
Accessing Instance and Class Variables

	centered
	centered_ (bool)
	
		If true, the knob's center scale, 0.5 is zero in the value scale. eg. as in a pan control. .
		bool - An instance of Boolean.  Default is false.
		
	mode
	mode_(arg1)
		
		The knob's tracking mode .
		arg1 - An instance of Symbol. \round, \horiz or \vert. Default  is  \round .
		
	value
	value_ (val)
		
		Gets/sets the the value. This will not do the action.
		val -  A Number.
	
	valueAction_ (val)
	
		Sets the value. Does the action.
		val -  A Number.

	keystep
	keystep_(arg1)
		
		The step by which the value is incremented/decremented with the keyboard.
		arg1 - A Float. Default is 0.01.
		
	step
	step_(arg1)
		
		The step in which the value is incremented/decremented while draging in \horiz and \vert modes.
		arg1 - A Float. Default is 0.01.
		
	increment
	decrement
	
		Increments or decrements the value by keystep.
		
	refresh
		
		Redraws the knob
		
Customizing Appearance

	color_(arg1)
	color
		
		arg1 - An Array of Colors: [center Color,  value Color, range Color, dial Color].
				
	skin
	skin_ (newskin)
	
		Get, set the skin of the knob.  See Examples below for how to set  a skin. 
		newskin - An instance of Symobl. The default is \default:
		
		(
		scale:	Color.black.alpha_(0.3),
		center:	Color.blue(0.7, 0.5),
		level:	Color.green(0.8, 0.8),
		dial:	Color.black.alpha_(0.7),
		defaultMode: 'round'
		)
	
Subclassing and Internal Methods
	The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed.
	
	defaultKeyDownAction (char, modifiers, unicode)
	
		The default keydown actions are:
		
		key				action					comment
		r				valueAction_(1.0.rand)	
		n				valueAction_(0)		
		x				valueAction_(1)		
		c				valueAction_(0.5)	
		]				increment by keystep
		[				decrement by keystep
		unicode 16rF700, 	increment by keystep		up arrow
		unicode 16rF703, 	increment by keystep		right arrow
		unicode 16rF701, 	decrement by keystep		down arrow
		unicode 16rF702, 	decrement by keystep		left arrow
		
	mouseDown (x, y, modifiers, buttonNumber, clickCount)
	mouseMove (x, y, modifiers)

	*isSquare
	*isSquare_(bool)
	*viewClass
	*compactRatio
	*initClass
	*paletteExample (parent, bounds)
	oldMethodsCompat
	init (argParent, argBounds)
	bounds_ (rect)
	calcConsts (rect)
	draw
	
Examples


// examples
(
var window, size = 32; // try different sizes - from 15 to 200 or more!
window = Window.new("Knob", Rect(640,630,270,70)).front;
k = Knob.new(window, Rect(20, 10, size, size));
k.action_({|v,x,y,m| postf("action func called: %\n", v.value); });
//k.color[1] = Color.gray(alpha:0);
)
k.value
k.value = 0.25
k.valueAction = 0.125

// modes
k.mode = \vert;
k.mode = \horiz;
k.mode = \round; // default

k.visible
k.visible = false
k.visible = true
k.enabled = false
k.enabled_(true)
k.canFocus = false
k.canFocus = true

// centered mode - like in a pan or eq gain control etc.
(
var window;
window = Window.new("Pan Knob", Rect(640,630,270,70)).front;
k = Knob.new(window, Rect(20,10,36,36));
k.action_({|v,x,y,m| \pan.asSpec.map(v.value).postln; })
//	.mode_(\horiz)
	.centered_(false)
	.value_(\pan.asSpec.unmap(0)); // 0.5
//k.color[1] = Color.gray(alpha:0);
)
k.centered
k.centered = true
k.centered = false

// mouseOverAction
(
var size = 28;
GUI.skins.default.knob.mySkin = ( );
w = Window.new("Knobs", Rect(384,630,320,80));
w.acceptsMouseOver=true; // true in parent window!
w.view.decorator = FlowLayout(w.view.bounds, 10@4, 10@4);
h = StaticText(w, 300 @ 16).background_(Color.blue(0.2,0.1));
w.view.decorator.nextLine;
k = Array.fill(8, {|item, i|
	var knob;
	knob = Knob.new(w, size @ size)
	//	.canFocus_(false)
		.action_({|v,x,y,m| h.string = "value: " ++ v.value.asString; })
		.mouseOverAction_({|v,x,y| h.string = "value: " ++ v.value.asString; });
	
	GUI.skins.default.knob.mySkin.center_(Color.rand);
	knob.skin_( GUI.skins.default.knob.mySkin );
	knob;
});
w.front
)
k.collect(_.value);

// step - 'horiz' and 'vert' modes only
(
var window, midispec;
midispec = [0,127,'linear',1].asSpec;
window = Window.new("step Knob", Rect(640,630,270,70)).front;
k = Knob.new(window, Rect(20,10,32,32));
k.action_({|v,x,y,m| midispec.map(v.value).postln; })
       .value_(midispec.unmap(0));

k.mode = \vert;

)
k.step
k.step = 10/127 // step by 10

k.mode = \horiz;
k.mode = \round;

// on Sheet
(
	Sheet({ arg l;
		l.view.decorator.gap=4@4;
		l.view.decorator.margin=4@4;
		c = Array.fill(8, { Knob.new(l, 28@28) });
	}, "Knob")
)
c
c.collect(_.value);

// GUI Kit
(
	f = {
		var size = 32;
		w = GUI.window.new("GUI.knob Test", Rect(580,590,300,80));
	
		k = GUI.knob.new(w, Rect(20, 10, size, size));
		k.action_({|v| v.value.postln; });
	
		w.front;
	};
)

GUI.cocoa; // select cocoa gui
f.value;

GUI.swing; // select swing gui
f.value;

// GUI skins
//	default skin
//	GUI.skins.knob.default = (
//		scale: Color.black.alpha_(0.3),
//		dial: Color.black.alpha_(0.7),
//		center: Color.blue(0.7, 0.5),
//		level: Color.green(0.8, 0.8)
//	);
				
GUI.skins.knob.default.level
GUI.skins.knob.default.center


GUI.skins.keys
GUI.skins.default.keys

(
GUI.skins.default.knob.mySkin = ( );

Sheet({ arg l;
	
	a = Array.fill( 8, {
	
		GUI.skins.default.knob.mySkin.center_(Color.rand);
		
		Knob(l, 32@32).skin_( GUI.skins.default.knob.mySkin );
	})
	
}, "Knobs");
)

a.collect(_.value);

// drag and drop
(
var w, txt, size = 36;
w = Window.new("Knobs", Rect(400,400,250,100)).front;
w.acceptsMouseOver=true;
w.view.decorator = FlowLayout(w.view.bounds).gap_(10 @ 10).margin_(10 @10);
txt = StaticText(w, 200 @ 14);
w.view.decorator.nextLine;

k = Knob(w, size @ size);
k.action = {arg v,x,y;  v.value.postln; txt.string_("value: " ++ v.value); };
k.mouseOverAction = {|v| txt.string_("value: " ++ v.value); };

j = Knob(w, size @ size);
j.action = {arg v,x,y;  j.value.postln; txt.string_("value: " ++ v.value); };
j.mouseOverAction = { txt.string_("value: " ++ j.value); };

n = NumberBox(w, 100 @ 20);
//n.setProperty(\boxColor,Color.grey(alpha:0.0));
n.value = 0.0;
)

// customize drag and drop methods
k.canReceiveDragHandler
k.canReceiveDragHandler = false; // don't accept drops

k.canReceiveDragHandler = { View.currentDrag.isFloat }; // accept only if drag is float

k.receiveDragHandler = { ("value droped in: " ++ View.currentDrag).postln }

k.receiveDragHandler = { k.valueAction = View.currentDrag.clip(0.0, 1.0); }

k.beginDragAction = { ("drag out -> " ++ k.value).postln; }

k.beginDragAction = { k.value.asFloat; }


