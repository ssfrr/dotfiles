SCWindow			Cocoa user interface window	

Inherits from: Object

A class representing a user interface window in the Cocoa gui system on OSX.

Besides providing a window in which to host SCView, SCWindow is also a canvas on which you can draw using Pen. See the SCPen file for many examples.

For modal versions of SCWindow see SCModalWindow and SCModalSheet.

See also: SCView, GUI, SCScrollTopView, SCPen, SCUserView, SCImage, SCModalWindow, SCModalSheet
		SCVLayoutView, SCHLayoutView, FlowLayout
	
Some Important Issues Regarding SCWindow

If you try to set parameters of a Window or a GUI widget from a  Routine , which uses the SystemClock by default, you must wrap it in a deferred function: { myWindow.bounds_( Rect(100,500,200,200) ) }.defer .  You do not need to use .defer, if you use the AppClock.

Creation / Class Methods

	*new(name, bounds, resizable, border, server, scroll)
	
		Creates a new SCWindow instance. You will need to call front (see below) on it before it will be visible.
		name - The name that will be displayed in the title bar. An instance of String or Symbol. The default is 'panel'.
		bounds - A Rect specifying the location and size of the window. The size does not include the title bar. N.B. Location is measured from the bottom left	of the screen. This is different from view location, which is measured from the upper left of the window (not including the title bar). The default is Rect(128, 64, 400, 400).
		resizable - A Boolean indicating whether this window can be resized by the user. The default is true.
		border - A Boolean indicating whether this window has a border. Borderless windows have no title bar and thus can only be closed in code. The default is true.
		server - This is a dummy argument which is here to provide compatibility with SwingOSC and has no effect. See GUI for more details.
		scroll - A Boolean indicating whether this window will add scrollers if its contents exceed its bounds. If this is set to true resize settings will be ignored for enclosed views. See SCScrollTopView. The default is false.
		
		w = Window.new;
		w.front; // draw it and bring it to the front

	*allWindows
	
		Returns an Array of all open SCWindows.
		
	*initAction
	*initAction_(func)
	
		Get/set and action to be performed when any window is created.
		func - An instance of Function or FunctionList
		
	*closeAll
	
		Closes all open SCWindows.
		
	*screenBounds
	
		Returns a Rect indicating the bounds of the current screen in pixels.
			

Instance Methods
	
	addFlowLayout(margin, gap)
		
		A convenience utility which sets view.decorator to FlowLayout and returns the decorator. See FlowLayout for examples.
		margin - An instance of Point
		gap - An instance of Point

	acceptsClickThrough_(boolean)
	acceptsClickThrough
		
		Set or return a Boolean indicating whether or not the window receives clicks when it is not front-most. The default is true.

	acceptsMouseOver_(boolean)
	acceptsMouseOver
		
		Set or return a Boolean indicating whether or not the window receives mouseOver events. The default is false.
	
	alpha_(alpha)
	
		Set the transparency of this window. alpha is a Float between 0.0 (invisible) and 1.0 (opaque).

	alwaysOnTop_(bool)
	alwaysOnTop
		
		Set or return a Boolean value indicating whether this window is always front-most. The default is false.
		
	bounds_(argBounds)
	bounds
		
		Set or return a Rect corresponding to the location and size of the window. The size does not include the title bar. N.B. Location is measured from the bottom left of the screen. This is different from view location, which is measured from the upper left of the window (not including the title bar). Note that because of the way Cocoa applications work, setting the bounds doesn't complete until the application finishes its current application event cycle. Thus, if you check the bounds in the same chunk of code, the SCWindow will not yet return the updated values.
		
		(
		w = Window.new("test");
		w.front;
		w.bounds = Rect(150, 450, 150, 150);
		w.bounds.postln; // still the old bounds
		{ w.bounds.postln; nil }.defer(0.1); // next application event cycle
		)
		
	close
	
		Closes this window.
		
	drawHook_(function)
	drawHook
		
		Set or return a drawing Function. See Pen for more information and many examples.
		
	front
	
		Display this window and bring it to the front.		
	
	fullScreen
	endFullScreen
		
		Puts the window in or out of full screen mode. Putting a window into fullScreen mode may change its bounds. 
		Use the escape key to exit full screen mode and close the window.		
		(
		w = Window.new(border: false);
		w.view.background_(Color.rand);
		w.front;
		w.fullScreen;
		Button.new(w, Rect(200,200,200,200)).states_([["Close Window"]]).action_({w.endFullScreen;w.close});
		)
	
	isClosed
	
		Returns a Boolean indicating whether this window has been closed.
		
	minimize
	
		Minimize this window to the dock.
		
	name_(argName)
	name
		
		Set or return a String corresponding to the text in this window's title bar.
		
	onClose_(val)
	onClose
		
		Set or return a Function to be evaluated when the window is closed.
			
	addToOnClose(function)
	removeFromOnClose(funcion)
		
		Add or remove a Function to be evaluated when the window is closed.	
			
	refresh
	
		Force this window and its contents to redraw. This is sometimes necessary in order to update drawing.
		
	setInnerExtent(w,h)
	
		Changes the size of this window while keeping the top left corner fixed. This is the usual desired behavior, as by default Cocoa uses a flipped coordinate system.
		
	setTopLeftBounds(rect,menuSpacer)
	
		Sets the bounds of the window using topLeft as a reference point, just like in View.  The menuSpacer defaults to 45, the height of the OSX menu bar.
	
	userCanClose_(bool)
	userCanClose
		
		Set or return a Boolean value indicating whether the user can close this window by clicking on its close button. The default is true.
		
	view
	asView
	
		Returns this window's top level view, which contains all of its other views. This will be an instance of SCTopView or SCScrollTopView depending on the value passed to the scroll argument when the window was created. See *new above.
				
	currentSheet
		
		Returnscurrent modal sheet attached to this window, if it exists. See SCModalSheet
		
Examples



//how to add views
(
var w;
w = Window("my name is... panel", Rect(128, 64, 340, 360));

32.do({ arg i;
	b = Button(w, Rect(rrand(20,300),rrand(20,300), 75, 24));
	b.states = [["Start "++i, Color.black, Color.rand],
		["Stop "++i, Color.white, Color.red]];
});
w.front;
)

// using a decorator on this window's top view
(
var w;
w = Window("my name is... panel", Rect(128, 64, 340, 360));

w.view.decorator = FlowLayout(w.view.bounds);
// w.addFlowLayout; // you can als write this instead of the line above

w.view.background = Color(0.6,0.8,0.8);
32.do({ arg i;
	b = Button(w, Rect(rrand(20,300),rrand(20,300), 75, 24));
	b.states = [["Start "++i, Color.black, Color.rand],
		["Stop "++i, Color.white, Color.red]];
});

w.front;
)

// setting bounds
// use screenbounds for precise placement from the top

(
x = Window.new("test", Rect(100,Window.screenBounds.height-180,300,100));x.front;
)

// bounds.top refers to the bottom edge of the window,
// measured from the bottom of the screen. Different than in View.
x.bounds_(Rect(100,400,300,300));



// borderless windows
w = Window.new(border:false).front; // can't be manually closed
w.close; // so close it in code

// onClose
(
x = Window.new.front;
x.alpha = 0.8;
x.onClose_({ y = Synth.new(\default) }); //close the window and the synth plays
)
x.close;
y.free;

// a window with scrollers
(
w = Window(scroll: true); // you must set this when the window is created
c = Slider2D(w, Rect(0, 0, 1500, 300));
d = Slider(w, Rect(0, 310, 20, 300));
c.background = Color.grey.alpha = 0.6;
d.background = Color.grey.alpha = 0.6;
w.front;
)


// drawing dynamically in a window with Pen
(
var w, much = 0.02, string, synth;

w = Window.new("swing", Rect(100, 100, 300, 500)).front;
w.view.background_(Color.new255(153, 255, 102).vary);

string = "swing ".dup(24).join;

w.drawHook = Routine {	
	var i = 0;
	var size = 40;
	var func = { |i, j| sin(i * 0.07 + (j * 0.0023) + 1.5pi) * much + 1 };
	var scale;
	Pen.font = Font("Helvetica-Bold", 40);
	loop {	
		i = i + 1;
		string.do {	|char, j|
			
			scale = func.value(i, j).dup(6);
			
			Pen.fillColor = Color.new255(0, 120, 120).vary;
			Pen.matrix = scale * #[1, 0, 0, 1, 1, 0];
			Pen.stringAtPoint(char.asString,
				((size * (j % 9)) - 10) @ (size * (j div: 9))
			);
		};
		0.yield // stop here, return something unimportant
	}
};

fork { while { w.isClosed.not } { defer { w.refresh }; 0.04.wait; } };

w.front;

)



