EZNumber			wrapper class for label and number box	

Inherits from: Object : EZGui

EZNumber is wrapper class which creates an (optional) StaticText, and a NumberBox.

Some Important Issues Regarding NumberBox
If the parent is nil, then EZNumber will create its own window. See EZGui more options. 

Scrolling and Arrow Keys
EZNumber scrolls by default, using the step size of the ControlSpec. If the controlSpec's step is set to 0, or is not set, then the the stepping and scrolling will be guessed according to the minval and maxval values of the spec on creation of the view.  Unlike the step variable of a regular NumberBox, controlSpec.step is also the smallest possible increment for the EZNumber.  By default, the shift-key modifier  will allow you to step by 100 x controlSpec.step , while the ctrl-key will give you 10x controlSpec.step.  Since the alt-key would give you 0.1 of the minimum step, it is disabled by default, but you can change that by setting numberView.alt_step to any value you like. Accordingly you can customize the other modifiers to fit your needs. See NumberBox.

Creation / Class Methods

	*new (parent, bounds, label, controlSpec, action, initVal, initAction, labelWidth, numberWidth, unitWidth, labelHeight, layout, gap)
	
		parent - The parent view or window. If the parent is nil, then EZNumber will create its own Window, and place it conveniently on the screen if the bounds are a Point. If the bounds are a Rect, then the Rect determines the window bounds.
		bounds - An instance of Rect or Point. Default value is 160@20.

		label - The label. Default value is nil. If nil, then no StaticText is created.		
		controlSpec - The ControlSpec for scaling the value.
		action - A Function called when the value changes. The function is passed the EZNumber instance as its argument.
		initVal - The value to initialize the slider and number box with. If nil, then it uses the ControlSpec's default value.
		initAction - A Boolean indicating whether the action function should be called when setting the initial value. The default is false.
		labelWidth - Number of pixels width for the label. The  default is 60. In the \horz layout, if you specify the numberWidth, then the labelWidth is ignored and is set to the bounds.width - unitWidth - numberWidth. 	
		numberWidth - Number of pixels width for the number box. The  default is 45. In \line2 layout, numberWidth defaults to the bounds.width minus the unitWidth. 
		unitWidth - Number of pixels width for the unit label. The default is 0.  If unitWidth is 0, then no unitLabel is created. In the \line2 layout, if you specify the numberWidth, then the unitWidth is ignored and is set to the bounds.width - unitWidth - numberWidth.
		labelHeight- Default is 20;
		layout- \line2, or \horz. The default is horz; \line2 is a two line version.
		gap - A Point. By default, the view tries to get its parent's gap, otherwise it defaults to 2@2. Setting it overrides these.
		margin - A Point. This will inset the bounds occupied  by the subviews of view.

		(
		w = Window.new.front;
		g = EZNumber(	w,  	// parent
				150@20,	// bounds
				" test ",	// label
				\freq, 	// controlSpec
				{|ez| (ez.value.asString ++" is the value of " ++ ez).postln}, // action
				330,		// initValue
				true		// initAction
		);
		g.setColors(Color.grey,Color.white);
		);
		
				
		// Simplest version, no parent view, so a window is created
		(
			g=EZNumber(label:" test ", controlSpec: \amp.asSpec.step_(0.01) );
			g.action_({|ez| (ez.value.asString ++" is the value of " ++ ez).postln});
		);

The contained views can be accessed via the EZNumber instance variables:
	labelView, numberView
	
	
	numberView
		
		Returns the numberView
				
	action
	action_(arg1)
	
		A function to be evaluated when the value changes. Te first argument will be the EZNumber.
		arg1 - An instance of Function or FunctionList. Default value is nil.
				
	value
		
		The value of the slider
				
	round_(arg1)
	round
		
		Rounds the values in the number box.
								
	controlSpec_(arg1)
	controlSpec
		
		An instance of ControlSpec for scaling the values.
				
	value
	value_ (val)
	
		Gets/sets the list/menu to the index at value. Does not perform the action.
		val - An integer.

	valueAction_ (val)
	
		Sets the value and performs the action at the index value and the global action.
		val - An integer.
		
	doAction
	
		Performs the action at the current index and the global action.


	set (label, spec, argAction, initVal, initAction)
	
		Set the args after creation.
		
		
	enabled
	enabled_(bool)
	
		Sets/gets if the list is enabled.
		bool - An Instance of Boolean. Default is true;
		

Changing Appearance
	
	setColors(stringBackground,stringColor,numBackground,
		numStringColor,numNormalColor,numTypingColor,background)
	
		stringBackground - An instance of Color. The background of the label and unit views.
		stringColor - An instance of Color. The stringColor of the label and unit views.
		numBackground - An instance of Color. The background of the number view.
		numStringColor - An instance of Color. The stringColor of the number view.
		numNormalColor - An instance of Color. The normalColor of the number view.
		numTypingColor - An instance of Color. The typingColor of the number view.
		background - An instance of Color. The backround of the enclosing view.
		
	font_(font)
		Set the Font used by all the views.
		font - An instance of Font. 


Examples


// Simplest version
(		// basic use
		w=Window.new.front;
		g=EZNumber(w, 170@16," test  ", \freq,unitWidth:30, numberWidth:60,layout:\horz);
		g.setColors(Color.grey,Color.white);
);


// lots of numberviews on on view
(
w=Window.new.front;
w.view.decorator=FlowLayout(w.view.bounds);
w.view.decorator.gap=2@2;

40.do{
		g=EZNumber(w, 170@16," test  ", \freq,unitWidth:30, numberWidth:60,layout:\horz);
		g.setColors(Color.grey,Color.white, Color.grey(0.8));
};
);


// click these parentheses to see all features and layouts 
(   

m=nil;
m=2@2;		//comment for no margin

/////////////////
/// Layout \horz

(		// all features
		g=EZNumber(nil, 170@20," freq  ", \freq,unitWidth:30, numberWidth:60,layout:\horz,margin:m);
		g.setColors(Color.grey,Color.white,background: Color.grey(0.7));
		g.window.bounds = g.window.bounds.moveBy(-180,50);
);

(		// no unitView
		g=EZNumber(nil, 170@20," freq  ", \freq,unitWidth:0, numberWidth:60,layout:\horz,margin:m);
		g.setColors(Color.grey,Color.white,background: Color.grey(0.7));
		g.window.bounds = g.window.bounds.moveBy(-180, -20);
);

(		// no label, with unit. use window name as label
		g=EZNumber(nil, 120@20,nil, \freq,unitWidth:30, numberWidth:60,layout:\horz,margin:m);
		g.setColors(Color.grey,Color.white,background: Color.grey(0.7));
		g.window.bounds = g.window.bounds.moveBy(-180, -90);
		g.window.name="Freq";
);


(		// no units, no label; use window name as label;
		g=EZNumber(nil, 120@20, nil, \freq,unitWidth:0, numberWidth:60,layout:\horz,margin:m);
		g.setColors(Color.grey,Color.white,background: Color.grey(0.7));
		g.window.bounds = g.window.bounds.moveBy(-180, -160);
		g.window.name="Freq";
);

/////////////////
/// Layout \line2

(		// all features
		g=EZNumber(nil, 120@42," freq  ", \freq,unitWidth:30, numberWidth:60,layout:\line2,margin:m);
		g.setColors(Color.grey,Color.white,background: Color.grey(0.7));
		g.window.bounds = g.window.bounds.moveBy(100,50);
);

(		// no unitView, with label
		g=EZNumber(nil, 170@42," freq  ", \freq,unitWidth:0, numberWidth:60,layout:\line2,margin:m);
		g.setColors(Color.grey,Color.white,background: Color.grey(0.7));
		g.window.bounds = g.window.bounds.moveBy(100, -50);
);
(		// no unitView, no label; use window name as label
		g=EZNumber(nil, 170@20,nil, \freq,unitWidth:0, numberWidth:60,layout:\line2,margin:m);
		g.setColors(Color.grey,Color.white,background: Color.grey(0.7));
		g.window.bounds = g.window.bounds.moveBy(100,-150);
		g.window.name="Freq";
);


)	
	
	
	
// Sound example
(
// start server
s.waitForBoot({
	
	var w, startButton, noteControl, cutoffControl, resonControl;
	var balanceControl, ampControl;
	var node, cmdPeriodFunc;
	
	// define a synth
	SynthDef("window-test", { arg note = 36, fc = 1000, rq = 0.25, bal=0, amp=0.4, gate = 1;
			var x;
			x = Mix.fill(4, {
				LFSaw.ar((note + {0.1.rand2}.dup).midicps, 0, 0.02)
			});
			x = RLPF.ar(x, fc, rq).softclip;
			x = RLPF.ar(x, fc, rq, amp).softclip;
			x = Balance2.ar(x[0], x[1], bal);
			x = x * EnvGen.kr(Env.cutoff, gate, doneAction: 2);
			Out.ar(0, x);
		}, [0.1, 0.1, 0.1, 0.1, 0.1, 0]
	).load(s);
	
	
	
	// make the window
	w = Window("another control panel", Rect(200, 400, 300, 180));
	w.front; // make window visible and front window.
	w.view.decorator = FlowLayout(w.view.bounds);
	
	w.view.background = Color.rand;
	
	// add a button to start and stop the sound.
	startButton = Button(w, 75 @ 20);
	startButton.states = [
		["Start", Color.black, Color.green],
		["Stop", Color.white, Color.red]
	];
	startButton.action = {|view|
			if (view.value == 1) {
				// start sound
				node = Synth( "window-test", [
					"note", noteControl.value,
					"fc", cutoffControl.value,
					"rq", resonControl.value,
					"bal", balanceControl.value,
					"amp", ampControl.value.dbamp ]);
			} {
				// set gate to zero to cause envelope to release
				node.release; node = nil;
			};
	};
	
	// create controls for all parameters
	w.view.decorator.nextLine;
	noteControl = EZNumber(w, 160 @ 20, "Note ", ControlSpec(24, 60, \lin, 1),
		{|ez| node.set( "note", ez.value )}, 36);
		
	w.view.decorator.nextLine;
	cutoffControl = EZNumber(w, 160 @ 20, "Cutoff ", ControlSpec(200, 5000, \exp),
		{|ez| node.set( "fc", ez.value )}, 1000);
		
	w.view.decorator.nextLine;
	resonControl = EZNumber(w, 160 @ 20, "Reson", ControlSpec(0.1, 0.7),
		{|ez| node.set( "rq", ez.value )}, 0.2);
		
	w.view.decorator.nextLine;
	balanceControl = EZNumber(w, 160 @ 20, "Balance ", \bipolar,
		{|ez| node.set( "bal", ez.value )}, 0);
		
	w.view.decorator.nextLine;
	ampControl = EZNumber(w, 160 @ 20, "Amp ", \db,
		{|ez| node.set( "amp", ez.value.dbamp )}, -6);
		
	
	// set start button to zero upon a cmd-period
	cmdPeriodFunc = { startButton.value = 0; };
	CmdPeriod.add(cmdPeriodFunc);
	
	// stop the sound when window closes and remove cmdPeriodFunc.
	w.onClose = {
		node.free; node = nil;
		CmdPeriod.remove(cmdPeriodFunc);
	};
});
)
	


