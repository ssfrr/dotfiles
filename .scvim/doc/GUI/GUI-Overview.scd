GUI Overview and Introduction

See also: GUI-Classes, GUI, ViewRedirect.

SuperCollider provides for using different gui kits, and also provides syntax for transparently writing kit and platform independent code. Two main classes control this mechnanism: the gui factory abstraction class, GUI, and the subclasses of ViewRedirect, which transparently uses the GUI class to redirect to the kit-specific gui class.

For a table of all gui classes and their equivalents, see GUI-Classes.
For information on switching gui kits, see the documentation for GUI.

Basic usage: Kits and Syntax

	w=Window("Test Window").front; // Window is a subclass of ViewRedirect
	w.postln // w now contains the class appropriate to the gui kit

Kit-dependant gui classes have a prefix. For example, to make a window, the CocoaGUI kit uses SCWindow, or the swing kit uses JSCWindow. It is generally discouraged to use the kit-dependant classes directly. Instead, you simply use the subclasses of ViewRedirect. In most cases this involves simply using the class base name without any prefix, like in the example above. Behind the scenes, the above technique actually automatically redirects to the appropriate GUI class method. For a table of all gui classes and their kit-dependent equivalents, see GUI-Classes.

Depending on the curent GUI.scheme the example above is equivalent to writing, for example:

	SCWindow("Test Window").front; // cocoa version
	
	or
	
	JSCWindow("Test Window").front; // swing version

Basic Usage: Windows, Containers and Decorators

(
	// Window returns the window class for the current kit
	w = Window( "my name is...", Rect( 128, 64, 340, 360 ));

	w.view.decorator = FlowLayout( w.view.bounds ); // comment this out for no decorator
	// w.addFlowLayout // you can use this instead of the above line for brevity.
	
	w.view.background = Color( 0.6, 0.8, 0.8 );

	32.do({ arg i;
		// Here Button returns the button class for the current kit
		b = Button( w, Rect( rrand( 20, 300 ), rrand( 20, 300 ), 75, 24 ));
		b.states = [[ "Start " ++ i, Color.black, Color.rand ],
				[ "Stop " ++ i, Color.white, Color.red ]];
	});

	w.front;
)

w.postln //prints the window instance for the current gui kit
b.postln //prints the button instance for the current gui kit

In the above example, first a Window was created. A Window automatically has its own top level container, which is a subclass of CompositeView. A CompositeView can have a decorator, which automatically places the contents in a predetermined order. In this case it is a FlowLayout, which is the only one that currently exists. This is optional however. Try commenting out the decorator in the example above.

Window and CompositeView both have addFlowLayout utility methods which assign an instance of FlowLayout to their view decorators and return the decorator.

Most gui objects are subclasses of View. All subclasses of View are created with the same beginning arguments, parent and bounds, for example, Slider(parent, bounds).

The parent is a container view of some kind, and the bounds are an instance of Rect or a Point (for width and height only). Using a Point is convenient if you are using a decorator for the postioning.

	(
	w=Window.new.front;				// Use Rect for precise placement in a CompositeView
	Slider(w, Rect (50,50,250,20)); 	// Slider is actually placed in w.view, which is a top view.
	Slider(w.view, Rect (50,100,250,20)) // So this is equivalent when Window is used as a parent
	)

You can easily nest containers, decorators and views to make complex layouts, and you can use colors to visually separate them:
	
	(
	w=Window.new.front;
	w.view.decorator = FlowLayout(w.view.bounds); // notice that FlowView refers to w.view, not w
	
	v=CompositeView(w, Rect(5,5,190,390));
	v.background = Color.rand; 					// set the color
	v.decorator = FlowLayout(v.bounds);
	
	y=CompositeView(w, Rect(205,5,190,390));
	y.background = Color.rand;					// set the color
	y.decorator = FlowLayout(y.bounds);
	
	14.do{ Slider(v, 180@20).background_(v.background) };// Points used, since the layout is handled by a decorator.
		
	18.do{ Slider2D(y,58@58).background_(Color.rand); };
	
	)
	
Container Coordinates

Container and User views use relative bounds coordinates, which are measured from the parent view's top left corner.

	(  
	w=Window.new.front;					// Use Rect for precise placement in a CompositeView
	v=CompositeView(w, Rect(50,50,300,300));
	v.background_(Color.grey);				// give the subview a visible color
	Slider(v, Rect (50,50,220,20)) 			// so this is equivalent when Window is used as a parent
	)


Window Coordinates

For a Window, the bounds coordinates are measured from the bottom left of the screen.
The bounds.rect differs from that of views, and is the following: Rect(left, bottom, width,height). Typically, you will call Window.screenBounds to place a window precisely independently of the screen size you are working on.

	(
	w=Window.new("A Precisely Placed Window",
		Rect(100, Window.screenBounds.height-300, 300, 200 )
		
		).front;
	) //since the window is 200 high and the bottom is at screenBounds.height-300, the top is 100 from the screen top

Resizing

Views can resize or stretch according to nine differents states, according to the instance variable resize. For documentation and examples see resize.


Actions: Performing Things with a GUI Widget

Gui widgets typically have an action, which is a Function or FunctionList to be evaluated when the user interacts with the widget.
You can set the action, or use addAction, or removeAction to determine how a widget interacts with your code.
	
	(
	w = Window ("A Slider");
	a = Slider (w, Rect(40, 10, 300, 30));
	a.action={ |sl| sl.value.postln }; // set the action of the slider
	w.front
	);
	
	// now incrementally add some more actions to the slider
	a.addAction({ |sl| w.view.background = Color.green(sl.value) });
	a.addAction({ |sl| sl.background = Color.red(1 - sl.value) });
	
	// adding and removing an action:
	f = { |sl| "--------*******-------".postln; };
	a.addAction(f);
	a.removeAction(f);
	
	// or remove all, of course
	a.action = nil;

GUI Timing: System Clock and App Clock

See: AppClock, TempoClock, SystemClock

Calls to the gui system from from the lang must be made from the AppClock, since the SystemClock is reserved for high priority sound related tasks. If you want to control a gui with a Routine or Task, then you must either use the AppClock to play them, or use the defer mechanism, which schedules a Function in the AppClock:
	
	(
	w=Window.new.front;
	Routine{
		20.do{
		w.bounds=Rect(200.rand, 200+200.rand, 300,300);
		0.1.wait;
		};
		w.close;
	}.play(AppClock)
	)
	
The same thing using the defer mechanism and a SystemClock:
	
	(
	w=Window.new.front;
	Routine{
		20.do{
		{w.bounds=Rect(200.rand, 200+200.rand, 300,300) }.defer; // you must defer this
		0.1.wait;
		};
		{w.close}.defer; // you must defer this
	}.play(SystemClock)
	)

In reality, defer simply schedules a Routine in an AppClock.

Asynchronous GUI Techniques: Communicating with the Sound Server

Sending values from a gui object to the sound server is basically the same as sending from the lang. Gui widgets typically have an action, which is a Function or FunctionList to be evaluated when the user interacts with the widget.

// use arrow keys to change frequency

	(	
	s.waitForBoot({
		
		n={arg freq=220;
			var out;
			out=SinOsc.ar(freq,0,0.2);
			8.do{out = AllpassN.ar(out, 0.2,0.02+0.20.rand,8)};
			out;
		}.play;
		
		w = Window("Use arrow keys to change the frequency by steps", Rect(100, 500, 500, 120));
		
		b = 	NumberBox(w, Rect(200, 10, 100, 20));
		b.value = 220;
		
		b.action = {arg numb; n.set(\freq, numb.value); }; // set the action here to change the frequency.
				
		b.addAction ( {w.view.background = Color.rand}); // add another action here.

		b.step=55; //make the step a fraction of the freq
		b.focus;
		w.front;
		
		CmdPeriod.doOnce({w.close});
		
	});
	)

Recieving values, however is asynchronous, and requires either using an OSCresponderNode, or polling values.
In this example a Routine polls values:

	(
	
	w = Window("Frequency Monitor", Rect(200, Window.screenBounds.height-200,300,150)).front;
	w.view.background_(Color.grey(0.9));
	
	a = StaticText(w, Rect(45, 10, 200, 20)).background_(Color.rand);
	
	a.string = "Current Frequency";
	
	Button.new(w, Rect(45, 70, 200, 20)).states_([["close",Color.black,Color.rand]]).action_({w.close});
	
	s.waitForBoot({
	
		b=Bus.new(\control,0,1);
		
		q=SynthDef(\Docs_FreqMonitor, {var freq,snd;
			freq=LFNoise0.ar(2, 400, 650);
			snd=SinOsc.ar(freq,0,0.2);
			Out.ar(0,snd);
			Out.kr(b.index,freq); // output the frequency to a control bus
		}).play;
				
		r= Routine{
			{			// Set the value of the StaticText to the value in the control bus.
						// Setting GUI values is asynchronous, so you must use .defer in the system clock.
						// Also you must check if the window is still open, since Routine will continue for at least
						// one step after you close the window.
			b.get( {arg v; {w.isClosed.not.if{ a.string= " Current Frequency: "++v.round(0.01)}; }.defer} );
			// b.get sends query to the server, and waits for a response before it sets the StaticText.
			
			0.01.wait;
			}.loop
		
		}.play
	});
	
	CmdPeriod.doOnce({w.close});
	w.onClose={r.stop; q.free; b.free }; //clean up if the window closes
	
	)

Here an OSCreponder changes a gui. See OSCresponderNode for more examples. It is important here that the action of the responder is defered.


	(
	s.waitForBoot({
	
		w=Window.new.front;
		w.view.background_(Color.blue(0.3));
		
		x={	var d,arr,out;
			d = Dust.kr(2,0.2);	// generate triggers for SendTrig and for DynKlank
			SendTrig.kr(d, 0, 0.9); // send message to lang
			
			arr=Array.fill(4, {TRand.kr(50+500.rand,1200+1200.rand,d)});
			out=DynKlank.ar(`[arr, nil, [1, 1, 1, 1]], K2A.ar(d)*0.1);
			Limiter.ar(out,0.5)
			
		}.play;
			
		
		// register to receive this message
		a = OSCresponderNode(s.addr, '/tr',
			{ {w.refresh}.defer }).add; // you must use defer here
			
		w.drawHook = {|me|
			Pen.use{
				90.do{
					Pen.strokeColor=Color.rand.alpha_(rrand(0.1,0.9));
					Pen.addArc(400.rand@400.rand, rrand(10, 100), 2pi.rand, pi);
					Pen.stroke;
				};
			}
		};
			
			
		
		CmdPeriod.doOnce({w.close}); //close window when sound is stopped
		w.onClose=({a.remove; x.free;});// clean up
	
		});
	)

Custom GUI: designing your own widgets using UserView

UserView is generally speaking a view in which you can draw, and for which you can define mouse, key, and drag and drop actions. For documentation on all of these, see the UserView, View, and Pen help files. The example below, however, will demonstrate a basic example of these techniques for designing a widget. The steps you need to take are the following:
(1) Create a User View (2) define a draw function (3) define an action (4) define mouse actions (5) define key actions (6) define drag and drop actions. You can omit steps which you don't want.

Caution, subclassing differs in many points from the example below. For a subclassing template and a quick tutorial on how to write a custom widget as a SCUserView subclass, see SCUserView-Subclassing.	

	(
	var value = 0.5;
	w = Window.new.front;
	
	// (1) create a user view
	v = UserView(w,Rect(50,50,200,20));
	// (2) define a drawing function for Pen
	
	v.drawFunc = {
		// Draw the fill
		Pen.fillColor = Color.grey;
		Pen.addRect(Rect(0,0, v.bounds.width*value,v.bounds.height));
		Pen.fill;
		// Draw the triangle
		Pen.fillColor = Color.red;
		Pen.moveTo(((v.bounds.width*value)-5) @ v.bounds.height);
		Pen.lineTo(((v.bounds.width*value)+5) @ v.bounds.height);
		Pen.lineTo(((v.bounds.width*value)) @ (v.bounds.height/2));
		Pen.lineTo(((v.bounds.width*value)-5) @ v.bounds.height);
		Pen.fill;
		// Draw the frame
		Pen.strokeColor = Color.black;
		Pen.addRect(Rect(0,0, v.bounds.width,v.bounds.height));
		Pen.stroke;
		};
		
	// (3) set an action to the user view		
	v.action = {value.postln; v.refresh};
	
	// (4) define mouse actions
	v.mouseDownAction = {arg view, x = 0.5,y, m;
		//m.postln;
		([256, 0].includes(m)).if{ // restrict to no modifier
		value = (x).linlin(0,v.bounds.width,0,1); v.doAction};
		};
	
	v.mouseMoveAction = v.mouseDownAction;
	
	// (5) (optional) define key actions
	v.keyDownAction = { arg view, char, modifiers, unicode,keycode;
		if (unicode == 16rF700, { value = (value+0.1).clip(0,1) });
		if (unicode == 16rF703, { value = (value+0.1).clip(0,1) });
		if (unicode == 16rF701, { value = (value-0.1).clip(0,1) });
		if (unicode == 16rF702, { value = (value-0.1).clip(0,1) });
		v.doAction;
	};
	
	// (6) (optional) define drag and drop
	v.beginDragAction = {value}; // what to drag
	v.canReceiveDragHandler = {View.currentDrag.isNumber}; // what to receive
	v.receiveDragHandler = {value = View.currentDrag; v.doAction }; // what to do on receiving
	
	
	// just for testing drag and drop
	Slider(w,Rect(50,100,200,20));
	
	StaticText(w,Rect(50,150,350,50)).string_("To Test Drag and Drop,\nHold down Cmd (Ctl) Key");
	
	)

Automatic GUI

You can get a quick simple automatic interface for a Synth with SynthDesc : makeWindow.

	(
	s.waitForBoot({
		SynthDef("test", { arg out, freq=330, amp=0.6;
			Out.ar(out, SinOsc.ar(freq,0,amp))
		}).add;
		
	
		SynthDescLib.global.at(\test).makeWindow;
	});
	)


Helper Methods in GUI

*stringBounds( string, font )

Returns a Rect object describing the bounds occupied by the given string if it was painted using the given font. Note that this method is asynchronous in SwingOSC, hence it is advised to use it inside a Routine.(not necessary on CocoaGUI). Example:

	(
	{
		var text = "Test", bounds, font, fonts, rect = Rect.new, total = Rect.new;
		
		fonts = Font.availableFonts;
		w = Window.new( "String Bounds", resizable: false );
		w.view.background = Color.blue;
		10.do({
			font		= Font( fonts.choose, exprand( 6, 36 ));
			bounds	= GUI.stringBounds( text, font );
			rect.set( rect.right, rect.bottom, bounds.width + 4, bounds.height + 2 );
			StaticText.new( w, rect )
				.font_( font ).align_( \center ).string_( text ).background_( Color.white );
			total	= total.union( rect );
		});
		w.bounds = total.moveTo( 200, 200 );
		w.front;
	}.fork( AppClock );
	)

Browsers and Inspectors

These classes use the current GUI kit implementation as returned by GUI.current . You usually do not instantiate them directly, but use one of the "Plus-GUI" methods described in the next paragraph.

ObjectInspector
StringInspector
ClassInspector
FunctionDefInspector
MethodInspector
SlotInspector
FrameInspector

ClassBrowser


"Plus-GUI" methods are methods added to other classes such as String or Server that provide GUI functionality for those classes. These methods use the current GUI kit implementation as returned by GUI.current .

.inspect
	Examples for Inspectors:
		Server.default.inspect;
		Server.inspect;

.browse
	Examples for Browsers:
		UGen.browse;				// ClassBrowser
		SynthDescLib( \myLib ).read.browse;

.makeWindow
	Examples for Server:
		if( s.window.notNil, {s.window.close});
		s.makeWindow;
		s.scope;

.plot
	Examples for Plotting:
		see ArrayedCollection, Buffer, Env, Function, Signal, SoundFile, Wavetable

.scope
	Examples for Scoping
		see Bus, Function, Server, UGen, ScopeView, Stethoscope




