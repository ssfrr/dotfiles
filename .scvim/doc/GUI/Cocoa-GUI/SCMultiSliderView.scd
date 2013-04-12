SCMultiSliderView			a richly configurable view for graphically displaying and editing an array of values

Inherits from: Object : SCView

SCMultiSliderView on the surface is like a group of sliders. However, various graphical options allow you to use it for displaying and editing graphic representations of array values. It is also the super class of SCEnvelopeView.

See also: SCEnvelopeView

Some Important Issues Regarding SCMultiSliderView

If no instance variables other than parent and bounds are set, then a multislider with bounds.width/12 sliders is created. However, the default thumbSize is 12 and the gap default is 1. The view width has to be 13*n+2 for all the sliders to automatically fit in the view.

So if you want a specific number of sliders, then it is best to specify the size and set elasticMode to 1. Then you will get a multislider which distrubutes size amount of sliders over bounds.width, where the slider widths are at maximum indexThumbSize (default 12) and the gap is adusted accordingly.

Creation / Class Methods

	*new (parent, bounds)
		
		parent - The parent view.
		bounds - An instance of Rect, or a Point indicating width@height.
		
		(
		n=20;
		w = Window.new.front;
		m = MultiSliderView(w,Rect(10,10,n*13+2,100)); //default thumbWidth is 13
		m.value=Array.fill(n, {|v| v*0.05}); // size is set automatically when you set the value
		m.action = { arg q;
			q.value.postln;
		};
		)

Accessing Instance and Class Variables

	size
	size_(arg1)
		
		Gets/sets the size of the array returned by action, if you explicitly set the size. If you do not set the size nor value, then the size of the array returned by action will be the amount of sliders in the view, which is bounds.width/12. Changing size, after the the multislider has been drawn or after the value array has been set, will lead to unexpected results. Instead, you should change the content of value, if you need to change the multislider contents.
		
		arg1 - An Integer.
	
	indexIsHorizontal_ (val)
	
		Determines the index direction (vertical/horizontal) of the slider.
		val - An instance of Boolean. Default is true.

	editable
	editable_ (val)
	
		Determines if the sliders are editable. If editable is false, the multislider will still execute action on mouse click.
		val - An instance of Boolean.
		
	readOnly_ (val)
	
		val - boolean.
				
	step
	step_ (stepSize)
	
		Quantizes the values to the nearest multiple of stepSize.
		stepSize - An instance of Float.
		
Accessing and Setting Values

	value
	value_ (val)
		
		Gets/sets the property, \value, by calling get/setProperty(\value, val). The setter also sets size to the size of val. This will not do the action of the slider.
		val - An instance of Array.
	
	valueAction_ (val)
	
		Sets the property, \value, by calling setPropertyWithAction(\value, val). Also sets size to the size of val. Does the sliders action.
		val - An instance of Array.

	index
	index_ (inx)
	
		Gets/sets the first index of the selection range.
		inx - an integer.
				
	selectionSize
	selectionSize_ (aval)
	
		Gets/sets the size of the selection. Can be 0.
		aval - An integer.
				
	startIndex_ (val)
	
		val - An integer.
		
	currentvalue
	currentvalue_ (iny)
	
		Gets/sets the value at the current index.
		iny - A float between 0 and 1.
		
	reference
	reference_ (val)
	
		Sets a reference value, and draws it according to other drawing options: as a line, or a thumb.		
		val - An Array of Floats between 0 and 1;
						
	metaAction_(arg1)
	metaAction
		
		Gets/sets a function to be evaluate on Ctrl-click
		arg1 - An instance of Function. Default value is nil.

Customizing Appearance

	showIndex_ (abool)
	
		Highlights the currently selected index.
		abool - An Instance of Boolean. Default is false.

	elasticMode
	elasticMode_ (mode)
	
		Determines if the sliders are distributed over the width of the view. If resize is 2, 3, or 8, then the width and gap of the individual sliders will adjust automatically using a maximum slider with of thumbSize.
		mode - 0 or 1
		
	thumbSize_ (val)
	
		Sets the indexThumbSize_ of the sliders. If elasticMode is 1, then it determines the maximum indexThumbSize of the slider as well as the 	valueThumbSize.
		val - A Float or Integer.

	indexThumbSize_ (val)
	
		The size of the slider thumb in the index direction.
		val - A Float or Integer.

	valueThumbSize_ (val)
	
		The size of the slider thumb in the value direction.
		val - A Float or Integer.

	drawLines (abool)
	drawLines_ (abool)
	
		Draws connecting lines between the values.
		abool - An instance of Boolean. default is false.

	drawRects_ (abool)
	
		Draws the thumbs of the sliders.
		abool - An instance of Boolean. default is true.
	
	gap
	gap_ (inx)
		
		Set/get the property, \xOffset, which is gap between the sliders. This value is ignored if elasticMode is set to 1.
		inx - An integer.
		
	isFilled_ (abool)
	
		If set to true, this extends the thumb-rectangle to the edge, like in a bar graph. Fills the area between 0 and the value, or between 0 and the reference, depending on other draw options. If drawLines_(true) and drawRects_(false) and isFilled_(true), then it will fill the value between the value and the reference only.
		abool - An instance of Boolean.
		
		(
		n=80;
		w = Window.new;
		m = MultiSliderView(w,Rect(10,10,20*13+2,100)); //default thumbWidth is 13
		m.elasticMode_(1);
		m.value=Array.fill(n, {|v| 1.0.rand});
		m.reference=Array.fill(n, {|v| 0.5});
		m.action = { arg q;q.value.postln; };
		m.isFilled_ (true);
		m.drawLines_(true);
		m.drawRects_(false);
		w.front;
		)
		
	fillColor_ (acolor)
	
		The fill color of the view.
		acolor - An instance of Color.

	strokeColor_ (acolor)
	
		The line color of the view.
		acolor - An instance of Color.

	colors_ (strokec, fillc)
	
		Sets the stroke and fill colors of the graph.
		strokec - An instance of Color.
		fillc - An instance of Color.

Subclassing and Internal Methods
	The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed.

	defaultKeyDownAction (char, modifiers, unicode)
	
		The default keydown actions are:
		
		key				action				comment
		unicode 16rF703, 	increment index by 1	right arrow
		unicode 16rF702, 	decrement index by 1	left arrow	
		unicode 16rF700, 	decrement gap by 1		up arrow
		unicode 16rF701, 	increment gap by 1		down arrow

	properties
		
		A list of properties to which this view responds. See SCView.
		
		returns:
		[ \bounds, \visible, \enabled, \canFocus, \resize, \background, \minWidth, \maxWidth, \minHeight, \maxHeight, \value, \thumbSize, \fillColor, \strokeColor, \xOffset, \x, \y, \showIndex, \drawLines, \drawRects, \selectionSize, \startIndex, \referenceValues, \thumbWidth, \absoluteX, \isFilled, \step, \elasticResizeMode ]		
	defaultGetDrag
	
		The method called by default when initiating a drag from an SCNumberBox.
		Tho following describes the defaultbehavior:
		
		a) if selectionSize is 0, returns the content of value (an Array):
		b) if selectionSize > 1, returns an Array with the values at the indexes in the selection;
		
		if references is not nil, returns an array containing (a) or (b) , and an array of the relevant reference values ; [ [values], [references] ]
		
	defaultCanReceiveDrag
	
		The method called by default when attempting to place a drag in this object. Will recieve any drag, but the drag should either be an array of values, ( [ values ] ), or an array containg an array of values and an array of reference values ( [ [values], [references] ] ).
								
	defaultReceiveDrag
	
		The default method called when a drag has been received. If the currentDrag is a String, then Performs value_() and reference_() using currentDrag as an argument. Does not perform the action.

	doMetaAction
	
		Not normally called directly (called by the primitive).


Examples

// basic
(
n=20;
w = Window.new.front;
m = MultiSliderView(w,Rect(10,10,n*13+2,100)); //default thumbWidth is 13
m.value=Array.fill(n, {|v| v*0.05}); // size is set automatically when you set the value
m.action = { arg q;
	q.value.postln;
};
)	


// looks like a candlestick graph
(
var size;
size = 350 / 6;
w = Window.new;
w.view.decorator = FlowLayout(w.view.bounds);
m = MultiSliderView(w, Rect(0, 0, 350, 100));	
m.value_(Array.fill(size, {0.01}));
m.isFilled_(true); // width in pixels of each stick
m.indexThumbSize_(2.0); // spacing on the value axis
m.gap_(4);
w.front;
)

// rotate the above graph
(
m.bounds_(Rect(0, 0, 100, 350));
m.indexIsHorizontal_(false);
)


Interactive Example (explains all the graphic options)

(
n=40;

w = Window("MultiSlider Options", Rect(200, Window.screenBounds.height-550, 600, 450));
f={	
	w.view.decorator = FlowLayout( w.view.bounds, 10@10, 10@2 );
	m = MultiSliderView(w,Rect(0,0,580,200)); // default thumbWidth is 13
	m.value=Array.fill(n, {|v| 0.5+((0.3*v).sin*0.25)});
	m.action = { arg q;q.value.postln; };
	
	StaticText(w,380@18).string_("indexThumbSize or thumbSize");
	Slider(w,580@10).action_({arg sl; m.indexThumbSize=sl.value*24}).value_(0.5);
	StaticText(w,380@18).string_("valueThumbSize");
	Slider(w,580@10).action_({arg sl; m.valueThumbSize=sl.value*24}).value_(0.5);
	StaticText(w,580@18).string_("xOffset or gap");
	Slider(w,580@10).action_({arg sl;0.5- m.xOffset=sl.value*50});
	StaticText(w,580@18).string_("setProperty(\\startIndex)");
	Slider(w,580@10).action_({arg sl; m.setProperty(\startIndex, sl.value *m.size )};);
	
	CompositeView(w,580@10);//spacer
	Button(w,100@20).states_([["RESET",Color.red]])
		.action_({ w.view.removeAll; f.value; });
	h=StaticText(w,450@18).string_("").stringColor_(Color.yellow);
	Button(w,100@20).states_([["elasticMode = 0"],["elasticMode = 1",Color.white]])
		.action_({|b| m.elasticMode = b.value});
	Button(w,160@20).states_([["indexIsHorizontal = false"],["indexIsHorizontal = true",Color.white]])
		.action_({|b| m.indexIsHorizontal = b.value.booleanValue}).value_(1);
	Button(w,120@20).states_([["isFilled = false"],["isFilled = true",Color.white]])
		.action_({|b| m.isFilled = b.value.booleanValue});
	Button(w,120@20).states_([["drawRects = false"],["drawRects = true",Color.white]])
		.action_({|b| m.drawRects = b.value.booleanValue}).valueAction_(1);
	Button(w,100@20).states_([["drawLines = false"],["drawLines = true",Color.white]])
		.action_({|b| m.drawLines = b.value.booleanValue});
	Button(w,160@20).states_([["readOnly = false"],["readOnly = true",Color.white]])
		.action_({|b| m.readOnly = b.value.booleanValue});
	Button(w,120@20).states_([["showIndex = false"],["showIndex = true",Color.white]])
		.action_({|b| m.showIndex = b.value.booleanValue});
	Button(w,120@20).states_([["reference = nil"],["reference filled",Color.white],["reference random",Color.yellow]])
		.action_({|b| b.value.booleanValue.if({
			(b.value>1).if(
				{m.reference=Array.fill(n, {1.0.rand})},
				{m.reference=Array.fill(m.size, {0.5})});
				},{ q=m.value;m.reference=[]; h.string="reference can't be returned to nil presently. please hit RESET."}
			)
		});
	Button(w,180@20).states_([["fillColor = Color.rand"]]).action_({m.fillColor=Color.rand});
	Button(w,180@20).states_([["strokeColor = Color.rand"]]).action_({m.strokeColor=Color.rand});
	Button(w,180@20).states_([["background = Color.rand"]]).action_({m.background=Color.rand});
	
};
f.value;
w.front;

)


Load a Sound file


(
// press shift to extend the selection
// use as waveView: scrubbing over the view returns index
// if showIndex(false) the view is not refreshed (faster);
// otherwise you can make a selection with shift - drag.
var size, file, maxval, minval;
size = 640;
a = Window("test", Rect(200 , 140, 650, 150));
a.view.decorator = FlowLayout(a.view.bounds);
b = MultiSliderView(a, Rect(0, 0, size, 50));
b.readOnly_(true);
a.view.decorator.nextLine;



d = Array.new;
c = FloatArray.newClear(65493);

r = Slider( a, Rect(0, 0, size, 12));
r.action = {arg ex; b.setProperty(\xOffset, (ex.value * 4) + 1 )};

file = SoundFile.new;
file.openRead("sounds/a11wlk01.wav");
file.numFrames.postln;
file.readData(c);
// file.inspect;
file.close;
minval = 0;
maxval = 0;
f = Array.new;
d = Array.new;
c.do({arg fi, i;
	if(fi < minval, {minval = fi});
	if(fi > maxval, {maxval = fi});

	//f.postln;
	if(i % 256 == 0,{
		d = d.add((1 + maxval ) * 0.5 );
		f = f.add((1 + minval ) * 0.5 );
	
		minval = 0;
		maxval = 0;
	});
});

b.reference_(d); // this is used to draw the upper part of the table
b.value_(f);

r = Slider( a, Rect(0, 0, size, 12));
r.action = {arg ex; b.setProperty(\startIndex, ex.value *f.size )};

// b.enabled_(false);
b.action = {arg xb; ("index: " ++ xb.index).postln};
b.drawLines_(true);
b.drawRects_(false);
b.isFilled_(true);
b.selectionSize_(10);
b.index_(10);
b.thumbSize_(1);
b.gap_(0);
b.colors_(Color.black, Color.blue(1.0,1.0));
b.showIndex_(true);
a.front;

)

Use as Sequencer

// example with sound
(
var size;
size = 12;
s.waitForBoot{	
	n={arg freq=330; SinOsc.ar(freq,0,0.2)}.play;

	w = Window("test", Rect(200 , 450, 10 + (size * 17), 10 + (size * 17)));
	w.view.decorator = FlowLayout(w.view.bounds);
	b = MultiSliderView(w, Rect(0, 0, size * 17, size * 17));
	b.value_( Array.fill(size,{|i| i/size}) );
	b.background_(Color.rand);
	b.action = {arg xb;
		n.set(\freq, 330+(1100*xb.value.at(xb.index)));
		("index: " ++ xb.index ++" value: " ++ xb.value.at(xb.index)).postln};
	b.elasticMode_(1); // makes the squares fit evenly
	b.setProperty(\showIndex, true); // cursor mode
	b.readOnly=true;
	w.front;
	
	r = Routine({
		0.1.wait;
		30.do({ arg i;
			b.index_(i%size);
			
			b.doAction;
			0.1.wait;
		});
		
		20.do({ arg i;
			b.index_(b.size.rand);
			b.doAction;
			[0.1,0.2].choose.wait;
		});
		1.wait;
		n.free;
		{w.close}.defer;
	});
	AppClock.play(r);
};
)
Note: this forces the entire view to redraw at each step and will spend a lot of CPU.




