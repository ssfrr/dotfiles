SC2DSlider			a two-dimensional GUI slider	

Inherits from: Object : SCView : SCControlView : SCSliderBase

See also: SC2DTabletSlider , SCTabletView

Some Important Issues Regarding SC2DSlider

SC2DSlider values always have ranges between zero and one. You must scale the output and input values to your needs. Using map and unmap, combined with a Spec, is helpful for this. To set the increment or decrement value of the slider, set the step .  By default, the shift, ctrl, and alt keys will modify the stepping by 100x, 10x, or 0.1x respectively, though you can customize this by setting shift_scale, ctrl_scale, or alt_scale  (see SCSliderBase) . Drag and drop returns and accept a Point. Inherits some formatting form SCSliderBase.

Creation / Class Methods

	*new (parent, bounds)

		parent - The parent view.
		bounds - An instance of Rect, or a Point indicating width@height.
		
		(
		w = Window("2DSlider", Rect(100,100, 140 ,140)).front;
		t = Slider2D(w, Rect(20, 20,80, 80))
				.action_({|sl|
					[\sliderX, sl.x, \sliderY, sl.y].postln;
				});
		)

Accessing Instance and Class Variables
		
	x
	x_ (val)
	
		The horizontal value of the 2d slider. Gets/sets the property, \x, by calling get/setProperty(\x, val). This will not do the action of the slider.

	activex_ (val)
	
		Sets the property, \x, by calling setPropertyWithAction(\x, val). Does the sliders action, if the x value has changed.

	y
	y_ (val)
	
		The vertical value of the 2d slider. Gets/sets the property, \y, by calling get/setProperty(\y, val). This will not do the action of the slider.

	activey_ (val)
	
		Sets the property, \y, by calling setPropertyWithAction(\y, val). Does the sliders action, if the y value has changed.

	setXY (x, y)
	
		A convenience method which performs both the x_ and y_ setters. This will not do the action of the slider.

	setXYActive (x, y)
	
		A convenience method which performs both the x_ and y_ setters. Does the action of the slider.

	incrementY
	
		Increments y by 1/bounds.height, unless the hight value is out of bounds. Does the action of the slider.

	decrementY
	
		Decrements y by 1/bounds.heitght, unless the hight value is out of bounds. Does the action of the slider.

	incrementX
	
		Increments x by 1/bounds.width, unless the hight value is out of bounds. Does the action of the slider.

	decrementX
	
		Decrements x by 1/bounds.width, unless the hight value is out of bounds. Does the action of the slider.

Subclassing and Internal Methods
	The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed.

	defaultKeyDownAction (char, modifiers, unicode)
	
		The default keydown actions are:
		
		key				action									comment
		r				activex_(1.rand), activey_(1.rand) with action 	random
		n				activex_(0), activey_(0) with action			left lower corner	
		x				activex_(1), activey_(1) with action			top left corner
		c				activex_(0.5), activey_(0.5) with action			centered
		unicode 16rF700, 	incrementY 								up arrow
		unicode 16rF703, 	incrementX 								right arrow
		unicode 16rF701, 	decrementY 								down arrow
		unicode 16rF702, 	decrementX								left arrow

	defaultGetDrag
		
		The method called by default when initiating a drag. Returns a Point (lo@hi).
		
	defaultCanReceiveDrag
	
		The method called by default when attempting to place a drag in this object. By default, SCSlider will respond only to drags where the drag contains a Point.
			
	defaultReceiveDrag
	
		The default method called when a drag has been recieved. The default action performed when receiving a drag. Sets x and y respectively using the Point ( currentDrag.x@currentDrag.y) . Performs the action.
		
	properties
	
		A list of properties to which this view responds. See SCView.
		
		returns:
		[ \bounds, \visible, \enabled, \canFocus, \resize, \background, \minWidth, \maxWidth, \minHeight, \maxHeight, \knobColor, \step, \x, \y ]
		
Examples

(
w = Window("Slider2D", Rect(100,100, 140 ,140));
t = Slider2D(w, Rect(20, 20,80, 80))
		.x_(0.5)	// initial location of x
		.y_(1)	// initial location of y
		.action_({|sl|
			[\sliderX, sl.x, \sliderY, sl.y].postln;
		});
w.front;
)

t.x 			// get the x loc
t.x_(0.25) 	// set the x loc


// drag an drop Points
(
w = Window("Slider2D", Rect(100,100, 500 ,300));
w.view.decorator = FlowLayout(w.view.bounds);
t = Slider2D(w, Rect(20, 20,280, 280))
		.x_(0.5)	// initial location of x
		.y_(1)	// initial location of y
		.background_( Color.rand )
		.action_({|sl|
			[\sliderX, sl.x, \sliderY, sl.y].postln;
		});
t.step_(0.01);

n=CompositeView.new(w, 200@300);
n.decorator= FlowLayout(n.bounds);

v = { |i| DragBoth.new(n, Rect(0, i * 20, 200, 20)).background_( Color.rand ).align_(\center) }.dup(5);

StaticText.new(n,200@150).string_("hold down cmd and drag points from the slider to the drag slots, or reverse").stringColor_(Color.white);
		
		
w.front;
)

// Shape a Sound
(
s.waitForBoot({
	a={arg mod=0.05, index=0.05;
			var r,out,out2;
			r=Saw.ar(8,0.03);
			out=PMOsc.ar(440,
				660*mod,3*index, 0,
				Lag.ar(r,0.01,1));
			[out,Delay1.ar(out)];

			}.play;

	w = Window("Slider2D", Rect(100,Window.screenBounds.height-400, 300 ,300));
	w.view.decorator = FlowLayout(w.view.bounds);
	t = Slider2D(w, Rect(0, 0,292, 292))
			.y_(0.05)
			.x_(0.05)
			.background_( Color.rand )
			.knobColor_(Color.rand)
			.action_({|sl|
				a.set(\mod,sl.x,\index,sl.y);
			});
	
	w.front;
	CmdPeriod.doOnce({w.close});
})
)




