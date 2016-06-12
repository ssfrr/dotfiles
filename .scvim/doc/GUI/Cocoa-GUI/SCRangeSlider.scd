SCRangeSlider			a double-ended gui slider	

Inherits from: Object : SCView : SCControlView : SCSliderBase

A slider for setting two values (usually low and high values). Dragging in the slider sets the lo and high ranges according to mouse down and mouse up. To move the whole range, hold down the ctrl key while dragging. Arrow keys will also move the whole range.

See also: EZRanger

Some Important Issues Regarding SCRangeSlider

SCRangeSlider always has a range between zero and one. You must scale the output and input values to your needs. Using map and unmap, combined with a Spec, is helpful for this. To set the increment or decrement value of the slider, set the step .  By default, the shift, ctrl, and alt keys will modify the stepping by 100x, 10x, or 0.1x respectively, though you can customize this by setting shift_scale, ctrl_scale, or alt_scale (see SCSliderBase) .  Drag and drop returns and accepts Points. Inherits some formatting from SCSliderBase.

Creation / Class Methods

	*new (parent, bounds)
	
		parent - The parent view.
		bounds - An instance of Rect, or a Point indicating width@height.
		
		(
		w = Window.new.front;
		a = RangeSlider(w, Rect(20, 80, 120, 30))
			.lo_(0.2)
			.range_(0.4)
			.action_({ |slider|
				[\sliderLOW, slider.lo, \sliderHI, slider.hi].postln;
			});
		)

Accessing Instance and Class Variables
					
	lo
	lo_ (val)
	
		The low value of the slider. Gets/sets the property, \lo, by calling get/setProperty(\lo, val). This will not do the action of the slider.

	activeLo_ (val)
	
		Sets the property, \lo, by calling setPropertyWithAction(\lo, val). Does the sliders action, if the lo value has changed.

	hi
	hi_ (val)
	
		The high value of the slider. Gets/sets the property, \hi, by calling get/setProperty(\hi, val). This also sets the range of the slider to hi - low (which can be negative). This will not do the action of the slider.

	activeHi_ (val)
	
		Sets the property, \hi, by calling setPropertyWithAction(\hi, val). This also sets the range of the slider to hi - low (which can be negative). Does the sliders action, if the hi value has changed.

	range
	range_ (val)
	
		The range value of the slider. Gets/sets the property, \range, by calling get/setProperty(\range, val). This also sets the hi value of the slider to lo + range. This will not do the action of the slider.

	activeRange_ (val)
	
		Sets the property, \range, by calling setPropertyWithAction(\range, val). This also sets the hi value of the slider to lo + range. Does the sliders action.

	setSpan (lo, hi)
	
		A convenience method which performs both the lo_ and hi_ setters. This will not do the action of the slider.

	setSpanActive (lo, hi)
	
		A convenience method which performs both the lo_ and hi_ setters. Does the action of the slider.
	
	setDeviation(deviation, average)
	
		A convenience methods which allows to set lo and hi according to their deviation and their average instead of their absolute values.
	

	increment (zoom)
	decrement (zoom)
	
		These are the methods called by pressing the arrow keys. These methods increment or decrement both the the slider values (hi and lo) by (max(this.step, this.pixelStep) * zoom). This means that by default increment and decrement change the value by pixelStep (step is nil by default). You can set step to quantize the slider values. If you call these methods from your code, you can also change the resolution of the values with the zoom factor. This will not effect how the keys work, since they will always use a zoom factor of 1. Performs the action of the slider.
		zoom - Defaults to 1.

Subclassing and Internal Methods
	The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed.

	defaultKeyDownAction (char, modifiers, unicode)
	
		The default keydown actions are:
		
		key				action							comment
		a				activeLo_(0), activeHi_(1) with action	
		n				activeLo_(0), activeHi_(0) with action		
		x				activeLo_(1), activeHi_(1) with action		
		c				activeLo_(0.5), activeHi_(0.5) with action	
		unicode 16rF700, 	increment 						up arrow
		unicode 16rF703, 	increment 						right arrow
		unicode 16rF701, 	decrement 						down arrow
		unicode 16rF702, 	decrement 						left arrow

	properties
	
		A list of properties to which this view responds. See SCView.
		
		returns:
		[ \bounds, \visible, \enabled, \canFocus, \resize, \background, \minWidth, \maxWidth, \minHeight, \maxHeight, \knobColor, \step, \lo, \hi, \focusColor ]

	defaultGetDrag
	
		The method called by default when initiating a drag,Returns a Point( lo@hi).
		
	defaultCanReceiveDrag
	
		The method called by default when attempting to drop a drag in this object. By default, SCSlider will respond only to drags where the drag contains a Point.
					
	defaultReceiveDrag
	
		The default method called when a drag has been recieved. Sets lo and hi respectively using the Point(currentDrag.x@currentDrag.y). Performs the action.
		

Examples

(
w = Window.new.front;
a = RangeSlider(w, Rect(20, 80, 120, 30))
	.lo_(0.2)
	.range_(0.4)
	.action_({ |slider|
		[\sliderLOW, slider.lo, \sliderHI, slider.hi].postln;
	});
)

// ---------

(
w = Window.new.front;
a = RangeSlider(w, Rect(20, 80, 120, 30))
	.lo_(0.2)
	.hi_(0.8)
	.action_({ |slider|
		b.activeLo_(slider.lo); // this will trigger the action of b (and set it's value)
		b.hi_(slider.hi);
	});
b = RangeSlider(w, Rect(220, 80, 20, 130))
	.lo_(0.2)
	.hi_(0.8)
	.knobColor_(HiliteGradient(Color.grey, Color.white,\h))
	.action_({ |slider|
		[\sliderLOW, slider.lo, \sliderHI, slider.hi].postln;
	});

)

// setDeviation:
(

w = Window("setDeviation", Rect(300, 300, 300, 150));
a = RangeSlider(w, Rect(10, 10, 200, 30))
	.lo_(0)
	.hi_(1);
b = Slider(w, Rect(10, 50, 200, 30))
	.action_(
		{	arg me;
			a.setDeviation(c.value, b.value);
		});
c = Slider(w, Rect(10, 100, 200, 30))
	.action_(
		{	arg me;
			a.setDeviation(c.value, b.value);
		}
	);
c.valueAction = 0.2;
w.front;
)


// SoundExample

// Shape a bandpass filter. Hold down the ctrl-key to move the whole frequency range
(
s.waitForBoot({
	a={arg freq=1800, bw=0.2;
			var r;
			BBandPass.ar(WhiteNoise.ar(0.3), freq, bw);

			}.play;

	w = Window("2DSlider", Rect(100,Window.screenBounds.height-400, 400 ,50));
	t = RangeSlider(w, Rect(10, 10, 380, 30))
			.lo_(0.4)
			.hi_(0.6)
			.action_({|sl|
				a.set(\freq,1800*(sl.lo+sl.lo)+10,\bw, (sl.hi-sl.lo).abs+0.01);
			});
	t.doAction;
	
	w.front;
	CmdPeriod.doOnce({w.close});
})
)


