SCEnvelopeView			a configurable view with nodes and connections	

Inherits from: Object : SCView

A view which can grapically display nodes at x/y coordinates, connection lines, cross-connections, node markers, and labels. All of the values for these are stored in arrays. While this view is typically used to make editable envelopes interfaces, it can be used to draw very complex interconnection graphs as well.

Some Important Issues Regarding SCEnvelopeView

The instance variable step must be explicitly set for the defautlKeyDownAction to work.

See also: SCMultiSliderView, SCEnvelopeEdit

Creation / Class Methods

	*new (parent, bounds)
		
		parent - The parent view.
		bounds - An instance of Rect, or a Point indicating width@height.
		
		(
			w = Window("envelope", Rect(150 , Window.screenBounds.height-250, 250, 100)).front;
			b = EnvelopeView(w, Rect(10, 10, 230, 70))
				.resize_(5)
				.action_({arg b; [b.index,b.value].postln})
				.value_([[0.0, 0.15, 0.5, 1.0],[0.1,1.0,0.7,0.0]])
				.curves_([5,5,-5]);
		)	

Accessing Instance and Class Variables
				
	editable
	editable_ (val)
	
		Determines if the any node is editable.
		val - An instance of Boolean.
		
	setEditable (index, boolean)
	
		Determines if the the node at index is editable.
		index -an integer.
		boolean - An instance of Boolean.
		
	step
	step_ (stepSize)
	
		Quantizes the values to the nearest multiple of stepSize.
		stepSize - An instance of Float.
						
	value
	value_ (val)
		
		Gets/sets the property, \value, by calling get/setProperty(\value, val). The setter also sets size to the size of val. This will not do the action of the slider.
		val - An instance of Array. The values mus be between 0 and 1. The form of the array must be:
		
		[ [ x1, x2, x3, ... ], [ y1, y2, y3, ... ] ]

	valueAction_ (val)
	
		Sets the property, \value, by calling (\value, val). Also sets size to the size of val. Does the sliders action.
		val - An instance of Array. The values mus be between 0 and 1 . The form of the array must be:
		
		[ [ x1, x2, x3, ... ], [ y1, y2, y3, ... ] ]

	index
	
		Gets theselected index. -1 if none selected.
		inx - an integer.
		
	lastIndex
	
		Returns the index last selected.
		
	selectIndex (index)
	
		Selects the node at index, and refreshes the view. 
		index - An integer.
	x
	y
	x_ (ax)
	y_ (ay)
	
		Get/set the x or y value at the selected index.
		ay - An instance of Float, between 0 and 1

	currentvalue
	currentvalue_ (iny)
	
		Gets/sets the y - value at the current index.
		iny - A float between 0 and 1.

	setString (index, astring)
	
		Draw the string inside the thumb at index. Make sure that ths stroke color contrasts the fill color.
		index - An integer.
		astring - An instance of String.

	strings_ (astrings)
	
		Draw a string inside the thumb at the corresponding index in the array. Make sure that ths stroke color contrasts the fill color.
		astrings - An Array of Strings;
		
	curves
	curves_(incurves)
		Set a shape to draw the connection between points. The shapes defined by Env are accepted.
		incurves - An  Array of Symbols, An  Array of SimpleNumbers, a Symbol or a SimpleNumber
		
	setEnv_(env)
		Set an Env to be shown in the view.
		
	grid
	grid_(point)
		Set a grid using a Point. x and y correspond to times and levels respectively. Specify a value of 0.0 if you do not want that axis to be drawn.
		
	gridOn
	gridOn_(flag)
		Show a grid. 
		flag - a false or true

	gridColor
	gridColor_
		Set the Color of the grid.
		
	connect (from, aconnections)
	
		Replaces the connections which were drawn at init time, and then draws new ones from the index, from, to the each of the aconnections indexes .
		from - An integer. The index form which the lines originate.
		aconnections - An Array of numbers. The indexes to which the lines are drawn.
		
	metaAction_(arg1)
	metaAction
		
		Gets/sets a function to be evaluate on Ctrl-click
		arg1 - An instance of Function. Default value is nil.
				
Customizing Appearance
	
	strokeColor_ (acolor)
	
		The line and text color of the view.
		acolor - An instance of Color.

	colors_ (strokec, fillc)
	
		Sets the stroke and fill colors of the view.
		strokec - An instance of Color.
		fillc - An instance of Color.

	drawLines (abool)
	drawLines_ (abool)
	
		Draws connecting lines between the nodes.
		abool - An instance of Boolean. default is false.

	drawRects_ (abool)
	
		Draws rectangles (thumbs) at the nodes .
		abool - An instance of Boolean. default is true.

	fillColor_ (color)
	setFillColor (index, color)
	
		The line and text color of the all the nodex (and their text), or of a specific node at indes.
		index - An integer.
		color - An instance of Color.

	thumbWidth_ (width)
	thumbHeight_ (height)
	thumbSize_ (size)
	
		Set the width, height, or size(both) of all th thumbs.
		width, height, size - The number of pixels.
		
	setThumbWidth (index, width)
	setThumbHeight (index, height)
	setThumbSize (index, size)
	
		Set the thumb width, height, or size(both) at a certain index.
		index - An integer.
		width, height, size - The number of pixels.
		
	selectionColor_ (acolor)
	
		Set the color a thumb has when selected.
		acolor - An instance of Color.

Subclassing and Internal Methods
	The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed.

	defaultKeyDownAction (char, modifiers, unicode)
	
		The default keydown actions are:
		
		key				action				comment
	shift+unicode 16rF703, 	increment x by step	shift + right arrow
	shift+unicode 16rF702, 	decrement x by step	shift + left arrow	
		unicode 16rF703, 	select next index		right arrow
		unicode 16rF702, 	select previous index	left arrow	
		unicode 16rF700, 	increment y by step	up arrow
		unicode 16rF701, 	decrement y by step	down arrow
		
		note: step must be explicitly set fro this to work.

		
	defaultGetDrag
	
		Returns this.value.
		
	defaultCanReceiveDrag
	
		The method called by default when attempting to place a drag in this object. Will recieve any drag, but the drag should be an array of values of the form:
		
		[ [ x1, x2, x3, ... ], [ y1, y2, y3, ... ] ]
										
	defaultReceiveDrag
	
		The default method called when a drag has been received. Performs value_() and reference_() using currentDrag as an argument. Does not perform the action.

	properties
	
		A list of properties to which this view responds. See SCView.
		
		[ \bounds, \visible, \enabled, \canFocus, \resize, \background, \minWidth, \maxWidth, \minHeight, \maxHeight, \value, \thumbSize, \fillColor, \strokeColor, \xOffset, \x, \y, \showIndex, \drawLines, \drawRects, \selectionSize, \startIndex, \thumbWidth, \absoluteX, \isFilled, \step ]

	size_(arg1)
	size
		
		called by value_

	items_(arg1)
	items
		
		Returns an Array


	doMetaAction
	
		Not normally called directly (called by the primitive).
		
	select (index)
	
		Selects the node at index, without refreshing the view
		index - An integer.
		

	addValue (xval, yval)
	fixedSelection_ (bool)
	
	allConnections_(arg1)
	allConnections
	
	doMetaAction
		

Examples

// use as envelope view
(
//use shift-click to keep a node selected
w = Window("envelope", Rect(150 , Window.screenBounds.height-250, 250, 100)).front;
w.view.decorator = FlowLayout(w.view.bounds);

b = EnvelopeView(w, Rect(0, 0, 230, 80))
	.drawLines_(true)
	.selectionColor_(Color.red)
	.drawRects_(true)
	.resize_(5)
	.step_(0.05)
	.action_({arg b; [b.index,b.value].postln})
	.thumbSize_(5)
	.value_([[0.0, 0.1, 0.5, 1.0],[0.1,1.0,0.8,0.0]]);

w.front;
)

// show grid
b.gridOn_(true);

// show Env
b.setEnv(Env.asr(0.5,1, 0.2));

// make the first point unmoveable

(
b.setEditable(0,false);
)

// use shift click to select/unselect the points

(
w = Window("envelope", Rect(150 , Window.screenBounds.height-250, 400, 150)).front;
w.view.decorator = FlowLayout(w.view.bounds);

b = EnvelopeView(w, Rect(0, 0, 350, 100))
	.thumbSize_(5)
	.drawLines_(true)
	.fillColor_(Color.green)
	.selectionColor_(Color.red)
	.drawRects_(true)
	.value_([(0.0, 0.1 .. 1.0), (0.0, 0.1 .. 1.0)])
	.setEditable(0,false);


)

(
r = Routine({
	var j = 0;
	20.do({ arg i;
	b.select((b.size -1).rand.abs);

	0.1.wait;
	b.x_(1.0.rand.abs);
	b.y_(1.0.rand.abs);
	});
	b.select(-1);

	});
	AppClock.play(r);
)	


//show boxes with a string in it:
(
a = Window("text-boxes", Rect(200 , 450, 450, 450));
a.view.decorator = FlowLayout(a.view.bounds);

b = EnvelopeView(a, Rect(0, 0, 440, 440))
	.thumbWidth_(60.0)
	.thumbHeight_(15.0)
	.drawLines_(true)
	.drawRects_(true)
	.selectionColor_(Color.red)
	.value_([[0.1, 0.4, 0.5, 0.3], [0.1, 0.2, 0.9, 0.7]]);
4.do({arg i;
	b.setString(i, ["this", "is", "so much", "fun"].at(i));
	b.setFillColor(i,[Color.yellow, Color.white, Color.green].choose);
});
a.front;
)

(
b.connect(3, [2.0,0.0,1.0]); // the text objects can be connected
b.connect(0,[2.0,3.0,1.0]);
)


