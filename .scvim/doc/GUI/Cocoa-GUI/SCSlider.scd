SCSlider			a gui slider	

Inherits from: Object : SCView : SCControlView : SCSliderBase

See also: SCRangeSlider, EZSlider

Some Important Issues Regarding SCSlider

SCSlider always has a range between zero and one. You must scale the output and input values to your needs. Using map and unmap, combined with a Spec, is helpful for this. To set the increment or decrement value of the slider, set the step.  By default, the shift, ctrl, and alt keys will modify the stepping by 100x, 10x, or 0.1x respectively, though you can customize this by setting shift_scale, ctrl_scale, or alt_scale  (see SCSliderBase) .  Inherits some formatting from SCSliderBase.

By default, SCSlider will respond only to drags where the drag contains a Number.

Creation / Class Methods

	*new (parent, bounds)
	
		parent - The parent view.
		bounds - An instance of Rect, or a Point indicating width@height.
		
		(
		w = Window.new.front;
		a = Slider(w, Rect(20, 60, 150, 20));
		a.action = { a.value.postln };
		)

Accessing Instance and Class Variables	

	value
	value_ (val)
		
		Gets/sets the property, \value, by calling get/setProperty(\value, val). This will not do the action of the slider.
	
	valueAction_ (val)
	
		Sets the property, \value, by calling setPropertyWithAction(\value, val). Does the sliders action.
		
	increment (zoom)
	decrement (zoom)
	
		These are the methods called by pressing the arrow keys. These methods increment or decrement the slider value by (max(this.step, this.pixelStep) * zoom). This means that by default increment and decrement change the value by pixelStep (step is nil by default). You can set step to quantize the increment/decrement of the slider values. If you call these methods from your code, you can also change the resolution of the values with the zoom factor. This will not effect how the keys work, since they will always use a zoom factor of 1, or a multiple of that depending on the key modifier. See SCSliderBase. Performs the action of the slider. 
		
		zoom - Defaults to 1, though it is effected by key modifiers when using arrow keys.
		
Customizing Appearance

	thumbSize
	thumbSize_ (size)
	
		size - The size of the slider button in pixels. Its width or height, depending on the slider orientation

Subclassing and Internal Methods
	The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed.

	properties

		A list of properties to which this view responds. See SCView.

		returns:
		[ \bounds, \visible, \enabled, \canFocus, \resize, \background, \minWidth, \maxWidth, \minHeight, \maxHeight, \knobColor, \step, \thumbSize, \focusColor]

	pixelStep
	
		Returns the reciprocal of: the slider width or height (depending on orientation) minus the thumbSize	

	defaultKeyDownAction (char, modifiers, unicode)
	
		The default keydown actions are:
		
		key				action				comment
		r				valueAction_(1.0.rand)	
		n				valueAction_(0)		
		x				valueAction_(1)		
		c				valueAction_(0.5)	
		]				increment by step
		[				decrement by step
		unicode 16rF700, 	increment by step		up arrow
		unicode 16rF703, 	increment by step		right arrow
		unicode 16rF701, 	decrement by step		down arrow
		unicode 16rF702, 	decrement by step		left arrow
		
	defaultGetDrag
	
		The method called by default when initiating a drag from an SCSlider. Returns the same as value.

	defaultCanReceiveDrag
	
		The method called by default when attempting to drop a drag in this object. By default, SCSlider will respond only to drags where the drag contains a Number.
			
	defaultReceiveDrag
	
		The default method called when a drag has been recieved. Performs valueAction_() using currentDrag as an argument.
		
Examples


// the simplest version will give you a very long float
(
w = Window.new.front;
c = NumberBox(w, Rect(20, 20, 150, 20));
a = Slider(w, Rect(20, 60, 150, 20))
	.action_({
		c.value_(a.value)
		});
a.action.value;
)

(// change the bounds to become vertical
w = Window.new.front;
c = NumberBox(w, Rect(20, 20, 150, 20));
a = Slider(w, Rect(200, 60, 20, 150))
	.action_({
		c.value_(a.value)
		});
a.action.value;
)


// use a Spec to round and map the output range for clearer display
(
w = Window.new.front;
b = ControlSpec(-50, 50, \linear, 0.01); // min, max, mapping, step
c = StaticText(w, Rect(20, 20, 150, 20)).align_(\center).background_(Color.rand);
a = Slider(w, Rect(20, 50, 150, 20))
	.focusColor_(Color.red(alpha:0.2))
	.background_(Color.rand)
	.value_(0.5)
	.action_({
		c.string_(b.map(a.value).asString)
		// round the float so it will fit in the NumberBox
		});
a.action.value;

)


// change the stepsize of the slider, selected via a PopUpMenu
(
w = Window.new.front;
a = ["0", "0.0625", "0.125", "0.25", "0.5", "1"];
b = Slider(w, Rect(20, 100, 100, 20))
	.action_({
		c.value_(b.value)
		}).background_(Color.rand);
d = PopUpMenu(w, Rect(20, 60, 100, 20))
	.items_(a)
	.action_({
		b.step_((a.at(d.value)).asFloat);
		});
StaticText(w, Rect(130, 60, 100, 20)).string_("change step");	
c = NumberBox(w, Rect(20, 20, 100, 20));
)


// use the slider view to accept key actions

(// select the slider, type something and watch the post window
w = Window.new;
c = Slider(w,Rect(0,0,100,30));
c.keyDownAction = { arg view,char,modifiers,unicode,keycode;
[char,modifiers,unicode,keycode].postln;
};
w.front;
)



// adding functionality to a view by the method addAction
// this is useful for adding things to existing frameworks
// that have action functions already.

(
w = Window.new("A Slider");
a = Slider.new(w, Rect(40, 10, 300, 30));
w.front
);

// now incrementally add some action to the slider
a.addAction({ |sl| sl.value.postln });
a.addAction({ |sl| w.view.background = Color.green(sl.value) });
a.addAction({ |sl| sl.background = Color.red(1 - sl.value) });

// adding and removing an action:
f = { |sl| "--------*******-------".postln; };
a.addAction(f);
a.removeAction(f);

// or remove all, of course
a.action = nil;



-----




// you can use Slider for triggering sounds also:

(
s.waitForBoot({
	SynthDef(\pluck,{arg freq=55;
		Out.ar(0,
		Pluck.ar(WhiteNoise.ar(0.06),
			EnvGen.kr(Env.perc(0,4), 1.0, doneAction: 2),
			freq.reciprocal,
			freq.reciprocal,
			10,
		coef:0.1)
		);
	}).send(s);
	

	w = Window.new("Hold arrow keys to trigger sound",Rect(300,Window.screenBounds.height-300,400,100)).front;
	a = Slider(w, Rect(50, 20, 300, 40))
		.value_(0.5)
		.step_(0.05)
		.focus
		.action_({
			// trigger a synth with varying frequencies
			Synth(\pluck, [\freq,55+(1100*a.value)]);
			w.view.background_(Gradient(Color.rand,Color.rand));
		})
});

)

// change the background color of WIndow by moving the sliders
(
w = Window("RGB fader", Rect(100, 500, 400, 400))
	.front;
f = { w.view.background_(Color.new(r.value, g.value, b.value, 1)) };
r = Slider(w, Rect(100, 140, 200, 20))
	.value_(0.5)
	.action_({ f.value });
g = Slider(w, Rect(100, 170, 200, 20))
	.value_(0.5)
	.action_({ f.value });
b = Slider(w, Rect(100, 200, 200, 20))
	.value_(0.5)
	.action_({ f.value });
f.value;
);







