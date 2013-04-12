SCScrollTopView			an SCTopView with scrollers	

Inherits from: Object : SCView : SCContainerView : SCCompositeView : SCTopView

A top level container view which allows the user to scroll across content which exceeds a window's visible bounds. A SCScrollTopView is created for you automatically if you pass true for the scroll argument in SCWindow:new. You do not need to create instances of this class directly.

See also: SCWindow GUI SCScrollView

Setting the Internal Bounds

The size of the contained 'canvas' is determined by the bounds of the views which it encloses. Resize settings are thus ignored for contained views. To set it to a particular size, you can add a SCCompositeView or other container view, but there is no direct setter. One should not use a decorator such as FlowLayout directly on a NSScrollTopView, only on a container view within it.

Action Functions with Scrolling SCViews

A SCScrollTopView or SCScrollView's action function is evaluated when a user scrolls the view or sets the visibleOrigin. See the example in the SCScrollView help file.

Instance Methods

A window's SCScrollTopView can be accessed using the SCWindow:view method. See the examples below.
	
	autohidesScrollers_(bool)
	autohidesScrollers
		
		Set or return a Boolean value indicating whether this view only shows its scrollers when the bounds of the enclosed content exceed the the bounds of this view. Autohiding is done independently for each axis. The default is true.
		
	autoScrolls_(bool)
	autoScrolls
		
		Set or return a Boolean value indicating whether this view scrolls automatically when you drag on a contained control view past the edge of visible bounds. The default is true.	
		
	hasHorizontalScroller_(bool)
	hasHorizontalScroller
		
		Set or return a Boolean value indicating whether this view has a horizontal scroller. The default is true.
		
	hasVerticalScroller_(bool)
	hasVerticalScroller
		
		Set or return a Boolean value indicating whether this view has a vertical scroller. The default is true.
	
	innerBounds
		
		Returns a Rect corresponding to the size of the enclosed canvas. Note that you cannot set this directly. The size of the innerBounds will be either the visible bounds or the smallest Rect which contains all enclosed subviews, whichever is larger. See discussion above.
		
	visibleOrigin_(point)
	visibleOrigin
		
		Set or return the coordinates of the current visible origin (the upper lefthand corner) of the enclosed 'canvas'. point is an instance of Point.
				

Examples

(
w = Window(scroll: true); // you must set this when the window is created
c = Slider(w, Rect(0,0,100,30));
w.front;
)

c.resize = 2; // resize settings are ignored if scrolling is enabled.

d = Slider(w, Rect(1500, 40, 100, 30)); // a horizontal scroller appears

w.view.autohidesScrollers_(false); // autohide is enabled by default, but we can turn it off


w.view.visibleOrigin = 1500@0; // but we can still scroll using the visibleOrigin method



