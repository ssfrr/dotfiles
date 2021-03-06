SCButton			a multi-state button	

Inherits from: Object : SCView : SCControlView

Some Important Issues Regarding SCButton

Failure to set any states at all results in an invisible button.

The button performs its action upon releasing the mouse. In musical contexts, you might want to use mouseDownAction_() to set a function to be performed on pressing the mouse (see SCView, and examples below).

If the drag contains a number, then valueAction_() is performed using the currentDrag. If the drag contains anything else, action ist set to the current drag. You could, for example, drag a function to an SCButton, and action would then be set to that function.

Creation / Class Methods

	*new (parent, bounds)
	
		parent - The parent view.
		bounds - An instance of Rect, or a Point indicating width@height.
		
		(
		w = Window.new("The Four Noble Truths");
		
		b = Button(w, Rect(20,20,340,30))
				.states_([
					["there is suffering", Color.black, Color.red],
					["the origin of suffering", Color.white, Color.black],
					["the cessation of suffering", Color.red, Color.white],
					["there is a path to cessation of suffering", Color.blue, Color.clear]
				])
				.action_({ arg butt;
					butt.value.postln;	
				});
		w.front;
		)

Accessing Instance and Class Variables
	
	states
	states_ (array)
	
		An array of labels and colors defining the states ofthe button
		array - an Array of arrays of the form [ [String, strColor, bgColor] , .... ]
								
	value
	
		Returns the index of the current state. This will not evaluate the function assigned to action (see SCView).

	value_ (val)
	
		Sets the button to display the state at index val of the states array. This will not evaluate the function assigned to action (see SCView).
		val - The index of an item in the states array .

	valueAction_ (val)
	
		Sets the button to display the item at index val of the states array, and evaluates action (see SCView), if the value has changed.
		val - The index of an item in the states array .

	font
	font_ (argFont)
	
		Sets the Font of the button. Default value is the default font: Font.default .
		argFont - An instance of Font.

Subclassing and Internal Methods
	The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed.

	doAction (modifiers)
	
		The method called by the primitive upon releasing the mouse.
		modifiers - A key modifier number, which is passed to the action as its second argument upon mouse-releasing the button.

	defaultKeyDownAction (char, modifiers, unicode)
	
		The default keydown actions are:
		
		key				action		comment
		" " 				value + 1		space
		\r 				value + 1
		\n, 				value + 1	
		3.asAscii,			value + 1		(enter key or cmd-C on Mac OSX )
		
		To change these use defaultKeyDownAction_ , see SCView.

	properties
		
		A list of properties to which this view responds. See SCView.
		
		returns:
		[ \bounds, \visible, \enabled, \canFocus, \resize, \background, \minWidth, \maxWidth, \minHeight, \maxHeight, \value, \font, \states, \focusColor ]
		
	defaultGetDrag
	
		The method called by default when initiating a drag from an SCButton. Returns the same as value.
	
	defaultCanReceiveDrag
	
		The method called by default when attempting to drop a drag in this object. By default, SCButton will respond only to drags where the drag contains a Number or Function.
						
	defaultReceiveDrag
	
		The default method called when a drag has been recieved. If the drag contains a number, then action ist set to the current drag. Otherwise valueAction_() is performed using the currentDrag.
				
Examples

(
w = Window.new("Example");

b = Button(w, Rect(90,20,200,30))
		.states_([
			["sine", Color.black, Color.rand],
			["saw", Color.black, Color.rand],
			["noise", Color.black, Color.rand],
			["pulse", Color.black, Color.rand]
		])
		.action_({ arg butt;
			butt.value.postln;	
		});
w.front;
)

// does not do action
b.value = 2;

// does action if it results in a change of value
b.valueAction = 3;

// clips to size of states
b.valueAction = -1;

// floats no problem
b.valueAction = 3.3;


//In a musical context, a button-down press is more meaningful than a button-up (release) as it's more
//intuitive to press a button on the beat. For that you can use View's mouseDownAction
//(a superclass of Button)

(
s.waitForBoot({
	w = Window.new;
	b = Button(w, Rect(20,20,80,26))
			.states_([["play", Color.black, Color.rand]])
			.mouseDownAction_({
				a = 	{EnvGen.kr(Env.adsr,doneAction:2)*SinOsc.ar(440,0,0.4)}.play;	
			})
			.action_({ arg butt, mod;
				a.release(0.3);
			});
	w.front;
})
)


// if you drag a function to a button, the the button's action is set to that function.
// you can us this for swapping functions.
(

s.waitForBoot({
	var w,p,snd,b;
	
	w = Window.new;
	
	b=Button(w, Rect(20,20,80,26))
			.states_([["start a sound", Color.black, Color.green],["stop", Color.black, Color.red]])
			.action_({});
				
	v=VLayoutView(w,Rect(140,20,200,300)); //Group the following views
	StaticText(v, Rect(20,20,180,60))
		.string_("The button does nothing at first, so try dragging a function to the button");
	
	DragSource(v, Rect(20,20,80,26))
		.object_(
			{|b| (b.value==1).if{snd={ SinOsc.ar(440,0,0.6) }.play}{snd.free};}//a button action function
			)
		.string_("a play sine function").align_(\center).background_(Color.rand);
		
	DragSource(v, Rect(20,20,80,26))
		.object_(
			{|b| (b.value==1).if{snd={ Saw.ar(440,0.4) }.play}{snd.free};} //a button action function
			)
		.string_("a play saw function").align_(\center).background_(Color.rand);
		
	DragSource(v, Rect(20,20,80,26))
		.object_(
			{|b| (b.value==1).if{snd={ WhiteNoise.ar(0.4) }.play}{snd.free};} //a button action function
			)
		.string_("a play noise function").align_(\center).background_(Color.rand);
		
	p=CmdPeriod.add({b.value_(0)});// set button to 0 on hitting Cmd-period
	w.onClose_{ snd.free; CmdPeriod.removeAll };//clean up when window is closed
	w.front;

})
)

// Using Routine to set button states on the fly.
(
var update, w, b;
		w = Window.new("State Window", Rect(150,Window.screenBounds.height-140,380,60));
		
		// a convenient way to set the button label
		update = {
			|but, string| but.states = [[string.asString, Color.black, Color.red]];
			but.refresh;
		};
		
		b = Button(w, Rect(10,10,360,40));
		b.font_(Font("Impact", 24));
		
		update.value(b, "there is only one state");
		
		// if an action should do something different each time it is called, a routine is the
		// right thing to use. This is better than creating variables outside and setting them
		// from the action function to keep state from one action to the next

		b.action_(Routine { |butt|
						rrand(15, 45).do { |i|
							update.value(butt, "%. there is still only 1 state".format(i + 2));
							0.yield; // stop here
						};
						w.close;
				});

		w.front;
)

// Using Routine to set button states on the fly 2.
(
s.waitForBoot({
var update, w, b;
		w = Window.new("State Window", Rect(150,Window.screenBounds.height-140,380,60));
		
		// a convenient way to set the button label
		update = { |but, string|
		but.states = [[string.asString, Color.black, Color.red]]; but.refresh };
		
		b = Button(w, Rect(10,10,360,40));
		b.font_(Font("Impact", 24));
		
		update.value(b, "there is only one state");
		
		// if an action should do something different each time it is called, a routine is the
		// right thing to use. This is better than creating variables outside and setting them
		// from the action function to keep state from one action to the next
		
		b.action_(Routine { |butt|
					var synth, guessVal;
						update.value(butt, "there are only two states");
						0.yield; // stop here
						update.value(butt, "click me");
						0.yield; // stop here
						update.value(butt, "click me again");
						0.yield; // stop here ..
						// create a synth
						synth = { |freq=1000, rate=5|
							Ringz.ar(
								Impulse.ar(rate.lag(4) * [1,1.01]), freq, rrand(0.01, 0.1),0.3
							)
						}.play;
						0.yield;
						guessVal = exprand(200.0, 18000).round;
						synth.set(\freq, guessVal); // set the synth
						update.value(butt, "?");
						0.yield;
						update.value(butt, guessVal.asString + "Hz"); // display frequency
						0.yield;
						synth.set(\rate, rrand(10, 50)); // set trigger rate
						// start an independent process
						fork({ 5.wait; synth.release; update.value(butt, "."); 1.wait; w.close }, AppClock);
				});
		CmdPeriod.doOnce({w.close});
		w.front;
});
)


// complex drag and drop example
// try dragging the buttons to white slot, adn then between white slots, or simply out fo the view

(
var w, f, slots;
var insert, remove;

slots = Dictionary.new;

remove = {arg slot, id;
	[slot, id].postln;
};

insert = {arg slot, fx;
		if(fx!=""){
			slots["slot"++slot].value_(0).states_([[fx, Color.white, Color.blue]]);
			[slot, fx].postln;
			}{
			slots["slot"++slot].value_(0).states_([[ "", Color.white, Color.white ]]);
			remove.value(slot, fx);
		};
};

w = Window.new("",Rect(200, 400, 448, 180));
w.view.decorator = f = FlowLayout(w.view.bounds);

StaticText(w, 400@20).string_("Drag & Drop holding down Cmd-key");
f.nextLine;
6.do{arg i;
	var fxwin, winOpen=false, empty = [ "", Color.white, Color.white ];
	
	slots["slot"++i] = Button.new(w, 70@70)
	.states_([empty])
	.action_({|v|
			if((slots["slot"++i].states[0][0]!="")&&(winOpen==false)){
				fxwin = Window(slots["slot"++i].states[0][0], Rect(rrand(0,500),rrand(0,500),200,200)).front;
				fxwin.view.background_(Color.rand);
				fxwin.onClose_({winOpen=false});
				winOpen = true}
				{if(winOpen==true){fxwin.front}};
				
	})
	.canReceiveDragHandler_({View.currentDrag.isString})
	.receiveDragHandler_({
		insert.value(i, View.currentDrag);
	})
	.beginDragAction_({
		var drag;
		drag = slots["slot"++i].states[0][0];
		slots["slot"++i].value_(0).states_([empty]);
		remove.value(i, View.currentDrag);
		drag;
	})
	.keyDownAction_({ arg view,char,modifiers,unicode,keycode;
				switch (keycode)
				{51} {slots["slot"++i].value_(0).states_([empty]);
				slots["slot"++i].refresh;
				remove.value(i, View.currentDrag);
				};
	});

};
	
f.nextLine;

["a", "b", "c", "d", "e", "f"].do{arg item, i;
	Button.new(w, 70@70)
	.states_([ [ item ] ])
	.action_({|v| })
	.beginDragAction_({item})
};
w.front;
)



