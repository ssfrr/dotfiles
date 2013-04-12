SCUserView			user-definable view	

Inherits from: Object : SCView

SCUserView is a user-definable View intended mainly for use with Pen and drawHooks. It is also good for making custom buttons or other gui interfaces and displays. Thus anything you can draw with the methods of Pen, combined with mouse tracking, can be used to create a vast variety of interfaces and displays. When a view is refreshed, either maunually, or triggered by a refresh of the parent view, drawFunc is evaluated. Using refreshInRect constrains the receiver's refresh area to the rectangle passed in a Rect (see SCView).

See also: GUI-Overview, SCWindow, Pen, Color, and String SCUserView-Subclassing

Creation / Class Methods

	*new (parent, bounds)
	
		parent - The parent view.
		bounds - An instance of Rect, or a Point indicating width@height.

Accessing Instance and Class Variables
	
				
	drawFunc_(arg1)
	drawFunc
		
		Set the function which should be evaluated if the view is refreshed. This happens every time the view or the whole window is refreshed (manually by calling SCView:refresh, SCWindow:refresh or e.g. by selecting the view or resizing the window).
.
		arg1 - An instance of Function. Default value is nil. Refreshing passes the instance of SCUserView itself as the first argument to the function.

	clearOnRefresh
	clearOnRefresh_ (bool)
	
		Determines whether the drawn content of the view is cleared on refresh.
		bool - An instance of Boolean. Default value is true.
		
	drawingEnabled
	drawingEnabled_(bool)
	
		Determines whether to execute the draw function or not
		bool - An instance of Boolean. Default value is true.
	
	animate_(bool)
	
		Determines whether the view should refresh itself internally at a constant frame rate or not.
		Use thisProcess.setDeferredTaskInterval(1/fps) to change this global frame rate. The default is 60fps.
		bool - An instance of Boolean. Default value is false.
	
	frame
	
		An Integer counter that increases by one each time the view is redrawn. Useful for driving animation.
	
	frameRate
	
		A Float that represents the current average frame rate. Useful for benchmarking while animating. If this value drops below 60, it is an indication of that the current drawFunc is heavy for the program to execute.
	
	draw
	
		Evaluates the draw function, passing the instance of SCUserView itself as the first argument to the function
		
	clearDrawing
	
		If clearOnRefresh is set to false, then you can use this to manually clear the drawing (you must refesh in order for it to show)
		
Deprecated

	mousePosition
	
		Deprecated. R the relative position of the mouse cklick as a Point.
		
Subclassing and Internal Methods
	The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed. For a Tutorial on how to subclass SCUserView to make your own custom GUI Widgets, see SCUserView-Subclassing

	init (argParent, argBounds)
	
		parent - The parent view.
		bounds - An instance of Rect, or a Point indicating width@height.
		
	keyDownFunc
	keyDownFunc_ (action)
	
		Deprecated. Use keyDownAction instead. See SCView.

	mouseDownFunc
	mouseDownFunc_ (action)
	
		Deprecated. Use mouseDownAction instead. See SCView.

	mouseMoveFunc
	mouseMoveFunc_ (action)
	
		Deprecated. Use mouseMoveAction instead. See SCView.
		
	mouseUpFunc
	mouseUpFunc_ (action)
	
		Deprecated. Use mouseUpAction instead. See SCView.
		
Examples

GUI-Overview contains an elobarate example on how to make a gui widget with SCUserView using interface level coding. For a Tutorial on how to write a subclass of SCUserView to make your own custom GUI Widgets, see SCUserView-Subclassing

// Basic Usage. Resize the window to refresh the drawing. Or use mouse click.

(	
	w=Window.new;
	v=UserView(w, w.view.bounds.insetBy(50,50));
	v.background_(Color.rand);
	v.drawFunc={|uview|
			
			Pen.moveTo(0@uview.bounds.height.rand);
			Pen.lineTo(uview.bounds.width@uview.bounds.height.rand);
			Pen.stroke;
		};
	v.mouseDownAction={v.refresh};
	w.front;
	
)



// Coordinates are relative to the SCUserView
// Try resizing the Window.

(	
	var func;
	
	func = {|me|
		Pen.use{
			10.do{
				Color.red(rrand(0.0, 1), rrand(0.0, 0.5)).set;
				Pen.addArc((400.exprand(2))@(100.rand), rrand(10, 100), 2pi.rand, pi);
				Pen.perform([\stroke, \fill].choose);
			}
		}
	};
	
	w = SCWindow.new("DrawFunc Examples").front;
	w.view.background_(Color.white);
	
	3.do{|i|
		v = SCUserView(w, Rect(20+(i*120), 100, 100, 100))
			.drawFunc_(func);
		v.resize=3; // the func coordinates ar valid even though the view move on resize
		v.background_(Color.rand);
	};
	
	w.refresh;
)


// Mouse Tracking
// Set the function which should be evaluated if the mouse is at the end of tracking (mouse-up).
// This function will be passed four arguments: theView, x coordinate, y coordinate, and keyboard modifiers.
	
(
	var drawFunc, mouseDownFunc, mouseUpFunc, mouseMoveFunc, sat = 0, startX;
	
	drawFunc = {|me|
		Pen.use{
			10.do{
				Color.red(rrand(0.0, 1), rrand(0.0, 0.5)).set;
				Pen.addArc((400.exprand(2))@(100.rand), rrand(10, 100), 2pi.rand, pi);
				Pen.perform([\stroke, \fill].choose);
			}
		}
	};
	
	mouseDownFunc = {|me, x, y, mod|
		startX = x;
		postf("begin path: x=% realtive mouse coordinates:%\n",startX, x@y);
	};
	
	mouseUpFunc = {|me, x, y, mod|
		postf("end path: (startX-x)==% mouse coordinates:%\n",(startX-x), x@y);
		
	};
	
	mouseMoveFunc = {|me, x, y, mod|
		sat = ((startX-x)/100);
		(x@y).postln;
		me.refresh;
	};
	
	w = SCWindow.new.front;
	w.view.background_(Color.white);
	3.do{|i|
		v = SCUserView(w, Rect(20+(i*120), 100, 100, 100));
		v.background_(Color.rand);
		v.drawFunc = drawFunc;
		v.mouseDownAction = mouseDownFunc;
		v.mouseUpAction = mouseUpFunc;
		v.mouseMoveAction = mouseMoveFunc;
	};
	w.refresh;
)


// Prevent redrawing:

(	
	var func, views;
	
	func = {|me|
		Pen.use{
			10.do{
				Color.red(rrand(0.0, 1), rrand(0.0, 0.5)).set;
				Pen.addArc((400.exprand(2))@(100.rand), rrand(10, 100), 2pi.rand, pi);
				Pen.perform([\stroke, \fill].choose);
			}
		}
	};
	
	w = SCWindow.new("DrawFunc Examples").front;
	w.view.background_(Color.white);
	views = {|i|
		v = SCUserView(w, Rect(20+(i*120), 100, 100, 100));
		v.drawFunc = func;
		v.clearOnRefresh_(false);
	} ! 3;
	w.refresh;
	{views.do{|v| v.drawFunc = nil}}.defer(0.4);
)


// Use the mouse to draw on the view

(
	var w, txt, tmppoints, all;
	tmppoints = [];
	
	w = SCWindow("draw on me", Rect(128, 64, 340, 360));
	
	v = SCUserView(w,w.view.bounds)
		.mouseMoveAction_({|v,x,y|
			[x,y].postln;
			
			tmppoints = tmppoints.add(x@y);
			v.refresh;
	})
		.mouseUpAction_({|v,x,y|
			all = all.add(tmppoints.copy);
			tmppoints = [];
			v.refresh;
	})
		.drawFunc_{|me|
			Pen.use {	
				Color.white.set;
				Pen.fillRect(me.bounds.moveTo(0,0));			
				Pen.width = 1;
				Color.black.set;
	
				Pen.beginPath;
				
				tmppoints.do{	|p, i|
					if(i == 0){
					Pen.moveTo(p);
					}{
					Pen.lineTo(p);
					}
				};
				all.do{|points|
					points.do{|p, i|
						if(i == 0){
							Pen.moveTo(p);
						}{
							Pen.lineTo(p);
						}
					};
				};
				Pen.stroke;
			};
		};	
		
	w.front;
)


// Animation
// with mouse interaction

(
var width = 400, height = 400, mx = 0, my = 0;
w = Window("animation and mouse interaction", Rect(100, 200, width, height), false);
u = UserView(w, Rect(0, 0, width, height));
u.background = Color.black;
u.animate = true;										//animate this view
u.drawFunc = {
	Pen.fillColor = Color.green;
	Pen.stringAtPoint(u.frameRate.asString, Point(10, 10));	//get frame rate
	Pen.stringAtPoint(u.frame.asString, Point(10, 30));		//get frame counter
	Pen.color = Color.white;
	Pen.moveTo(Point(my, mx));
	100.do{|i|
		var x = sin(u.frame*0.04.neg+i)*(5*i)+mx;			//use .frame to drive animation
		var y = cos(u.frame*0.05+i)*(5*i)+my;
		Pen.lineTo(Point(y, x));
		Pen.addOval(Rect(x, y, i, i));
	};
	Pen.fillStroke;
};
u.mouseDownAction = {|v, x, y|
	mx = x;
	my = y;
};
u.mouseMoveAction = u.mouseDownAction;
w.front;
)

u.animate = false;	//animation can be paused and resumed
u.animate = true;
w.close;			//stops animation



// Simple ball animation
//

(
var width = 400, height = 400, xspeed = 3, yspeed = 2, x = width*0.5, y = height*0.5;
w = Window("ball", Rect(100, 200, width, height));
u = UserView(w, Rect(0, 0, width, height));
u.background = Color.black;
u.animate = true;
u.drawFunc = {
	if(x<0 or:{x>width}, {xspeed = 0-xspeed});
	if(y<0 or:{y>height}, {yspeed = 0-yspeed});
	x = x+xspeed;
	y = y+yspeed;
	Pen.fillColor = Color.white;
	Pen.fillOval(Rect.aboutPoint(Point(x, y), 8, 8));
};
w.front;
)

(	//replace the drawFunc above while running
u.drawFunc = {
	Pen.fillColor = Color.red;
	Pen.fillOval(Rect(200, 200, sin(u.frame*0.031)*200, sin(u.frame*0.044)*200));
	Pen.fillOval(Rect(200, 200, sin(u.frame*0.052)*200, sin(u.frame*0.065)*200));
	Pen.fillOval(Rect(200, 200, sin(u.frame*0.073)*200, sin(u.frame*0.086)*200));
}
)

//close the window to stop
w.close;


// Clearing on Refresh
//
// Set the behaviour for refreshing the view.
// If this flag is true (the default) the view will be cleared before each refresh call,
// otherwise It will draw in top of it.
// On OSX this functionality is only available for the version >= 10.4 .

(
	var width = 640, height = 480, w, theta = 0, drawFunc;
	w = Window( "trails", Rect( 128, 64, width, height ), false );
	drawFunc = { arg view;
		var x = 20 * sin( theta ), y = 42 * cos( theta );
		theta = theta + 0.01;
		Pen.fillColor_( Color.red( 0.2, 0.1 ));
		Pen.fillRect( Rect( 0, 0, width, height ));//draw a semitransparent rect filling the screen
		Pen.strokeColor_( Color.white );
		Pen.translate( width * 0.5, height * 0.5 );
		6.do { arg i;
			Pen.rotate( theta * (1 - (i / 6)) );
			Pen.scale( 0.7 + (i * 0.4), 0.4 + (i * 0.5) );
			Pen.strokeOval( Rect.aboutPoint( Point( x, y ), 60, 40 ));
		};
	};
	x = UserView( w, Rect( 10, 10, width - 20, height - 20 ))
		.canFocus_( false )
		.drawFunc_( drawFunc )
		.clearOnRefresh_( false );

	w.front;
	x.animate = true
)


// Use refreshInRect(aRect).
// Constrains the receiver's refresh area to the rectangle passed in aRect.
// you may use Quartz Debug's flash screen updates to see the refresh area of the view

(
	var userView, win, blob = Rect(0, 0, 50, 50), trackblob=false, pmouse;
	
	a = SCImage.new("/Library/Desktop Pictures/Ripples Blue.jpg");
	
	win = SCWindow.new("refreshInRect Test", Rect(400, 400, 600, 200), scroll:true).front;
	win.onClose_({ a.free; });
	
	userView = SCUserView(win, Rect(10,10,2000,800))
		.backgroundImage_(a, 5)
		.drawFunc_({|me|
			Color.blue.setFill;
			Pen.fillRect(blob);
		})
		.mouseDownAction_({|v, x, y, mod|
			pmouse = x@y;
			trackblob = blob.containsPoint(pmouse);
		})
		.mouseUpAction_({|v, x, y, mod|
			trackblob = false;
		})
		.mouseMoveAction_({|v, x, y, mod|
			var refresh, mouse, delta;
			mouse = x@y;
			
			if(trackblob, {
				refresh = blob.copy;
				delta = mouse-pmouse;
				blob = blob.moveBy(delta.x, delta.y);
				refresh = refresh.union(blob);
				v.refreshInRect(refresh);
			});
			pmouse = mouse;
		});
	
	blob = blob.moveBy(userView.bounds.left, userView.bounds.top);
	userView.bounds.postln;
)






