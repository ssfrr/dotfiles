SCScrollView			container view with scrollers	

Inherits from: Object : SCView : SCContainerView : SCCompositeView : SCTopView : SCScrollTopView

A container view which allows the user to scroll across content which exceeds the view's visible bounds.

See also: SCWindow GUI

Some Important Issues Concerning SCScrollView

SCScrollView inherits most of it's important methods from it's superclass, SCScrollTopView. Please see its helpfile for more information.

Setting the Internal Bounds

The size of the contained 'canvas' is determined by the bounds of the views which it encloses. Resize settings are thus ignored for contained views. To set it to a particular size, you can add a SCCompositeView or other container view, but there is no direct setter. One should not use a decorator such as FlowLayout directly on a SCScrollView, only on a container view within it.

Action Functions with Scrolling SCViews

A SCScrollTopView or SCScrollView's action function is evaluated when a user scrolls the view or sets the visibleOrigin. See the example below.

Creation

	*new(parent, bounds)
	
		Returns a new SCScrollView. (Inheritted from SCView).
		parent - A SCWindow, or a container view such as SCCompositeView.
		bounds - A Rect, which specifies the position of this view in its parent.		

Instance Methods
	
	hasBorder_(bool)
	hasBorder
		
		These methods get and set a Boolean indicating whether or not a black border is drawn around the view. This border is drawn within the bounds of the SCScrollView. Thus the bounds do not change when a border is added, but the visible area is slightly reduced.	

Examples

(
w = Window.new;

b = ScrollView(w, Rect(0,0,150,100));
c = Slider2D(b, Rect(0,0,100,100));	
d = Slider2D(b, Rect(100,0,100,100));

w.front;
)

w.view.background = Color.white;

b.background = Color.grey;

d.bounds = Rect(100,0,1000,100); // the 'canvas' grows to accomodate it

b.resize = 5; // the ScrollView resizes, but not its contents

b.hasBorder_(true);

b.hasBorder_(false);

b.visibleOrigin;

b.visibleOrigin = Point(2000, 0); // clips to the bounds of its contents

b.hasHorizontalScroller_(false);

b.hasVerticalScroller_(true);

b.autohidesScrollers_(false);

w.close;


// Force a 'canvas' size

(
w = Window.new;

b = ScrollView(w, Rect(0, 0, 300, 300)).hasBorder_(true);
c = CompositeView(b, Rect(0, 0, 500, 500)); // 'canvas' is this big
c.decorator = FlowLayout(c.bounds); // now we can use a decorator
	
Slider2D(c, Rect(0, 0, 240, 240));
Slider2D(c, Rect(0, 0, 240, 240));
Slider2D(c, Rect(0, 0, 240, 240));

c.decorator.nextLine;
w.front;
)


// "Rulers", using an action function

(
var drawFunc;
w = Window.new;

a = ScrollView(w, Rect(40, 40, 300, 300));
b = ScrollView(w, Rect(0, 40, 40, 300)).hasHorizontalScroller_(false).hasVerticalScroller_(false)
	.autoScrolls_(false);
c = ScrollView(w, Rect(40, 0, 300, 40)).hasHorizontalScroller_(false).hasVerticalScroller_(false)
	.autoScrolls_(false);
b.background = Color.grey;
c.background = Color.grey;

d = UserView(a, Rect(0, 0, 620, 620));
e = UserView(b, Rect(0, 0, 40, 630));
f = UserView(c, Rect(0, 0, 630, 40));

a.action = { var origin;
	origin = a.visibleOrigin;
	b.visibleOrigin = 0@(origin.y);
	c.visibleOrigin = (origin.x)@0;
};

drawFunc = {
	30.do({arg i;
		(i+1).asString.drawAtPoint((i+1 * 20)@0, Font("Courier", 9), Color.black);
	});
};

d.drawFunc = {
	Pen.use({
		Pen.translate(0, 5);
		drawFunc.value;
	});	
	Pen.translate(15, 0).rotate(0.5pi);
	drawFunc.value;
};

e.drawFunc = {	
	Pen.translate(40, 0).rotate(0.5pi);
	drawFunc.value;
};

f.drawFunc = {
	Pen.translate(0, 25);
	drawFunc.value;
};

w.front;
)


