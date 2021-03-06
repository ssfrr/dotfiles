SCQuartzComposerView			view for rendering Quartz Composer Compositions	

Inherits from: Object : SCView

SCQuartzComposerView allows for the rendering of Quartz Composer Compositions within the standard OSX SC GUI system. Quartz Composer is a visual programming environment for processing and rendering graphical data, which is distributed free of charge as part of Apple's XCode Development Tools. QC is highly optimised to work with the OSX graphics system, and in general should be more efficient than Pen. For more information on QC see: http://developer.apple.com/documentation/GraphicsImaging/Conceptual/QuartzComposer/index.html

You can access input and output ports using the methods setInputValue, getInputValue and getOutputValue, or (do to a slight of hand in the implementation, using the port keys as getters and setters directly. The following two lines of code are thus equivalent:

myQCView.setInputValue(\valueIn, 1);
myQCView.valueIn = 1;


Creation / Class Methods

	*new (parent, bounds)
		
		parent - The parent view.
		bounds - An instance of Rect, or a Point indicating width@height.
		
		(
		w = SCWindow("Simple QC Test").front;
		b = SCButton(w, Rect(0, 0, 150, 20))
			.states_([["pick another QC file"]])
			.action_({ File.openDialog("", { |path| m.path_(path) }) });
		m = SCQuartzComposerView(w, Rect(0,20,400, 260));
		m.path = Document.current.path.dirname ++ "/Cells.qtz";
		)
		m.start;
		m.stop;

Instance Methods

	path
	path_ (argpath)
	
		Returns the path of the currently loaded composition as a String, or loads a new QC composition from the file at the location specified by the String argpath.
		argpath - A file path as a String.
		
	inputKeys
	
		Returns an Array of Symbols corresponding to the keys of the currently loaded composition's input ports.
				
	outputKeys
		
		Returns an Array of Symbols corresponding to the keys of the currently loaded composition's output ports.	
		
	start
	
		Start rendering the loaded composition.
		
	stop
	
		Stop rendering the loaded composition.
		
	setInputValue (key, value)
	
		Set the value of an input port at key.

		key - A String or Symbol matching the port's key.
		value - The type of value must correspond to the type of the port, but Floats, Integers, and Booleans are converted if needed. (true = 1, false = 0)

	getInputValue (key)
	
		Get the current value of an input port. The type of object returned will correspond to the port's type.
		key - A String or Symbol matching the port's key.
		
	getOutputValue (key)
	
		Get the current value of an output port. The type of object returned will correspond to the port's type.
		key - A String or Symbol matching the port's key.
		
	maxFPS_ (rate)
	
		Set the maximum frames per second at which the composition will render.
		rate - A value of 0 indicates no limit.
		
	openInQC
	
		Open the currently loaded composition in Quartz Composer. You will need to reload the composition into the view before any saved changes take effect.
		
Subclassing and Internal Methods
	The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed.

	doesNotUnderstand (selector, args)

Examples


////////// Simple example
(
w = SCWindow("Simple QC Test").front;
b = SCButton(w, Rect(0, 0, 150, 20))
	.states_([["pick another QC file"]])
	.action_({ File.openDialog("", { |path| m.path_(path) }) });
m = SCQuartzComposerView(w, Rect(0,20,400, 260));
m.path = Document.current.path.dirname ++ "/Cells.qtz";
)
m.start;
m.stop;

////////// Set and get inputs and outputs
(
w = SCWindow("SCTV").front;
m = SCQuartzComposerView(w, Rect(0,20,400, 260));
m.path = Document.current.path.dirname ++ "/SCQuartzComposerViewTest.qtz";
m.start;
)

// get the names of input and output keys
m.inputKeys;
m.outputKeys;
m.openInQC; // you can see the published inputs and outputs in the composition

// You can access input and output ports using setInputValue, getInputValue and getOutputValue
// or directly using the keys as getters and setters
m.setInputValue(\direction, 1);
m.direction = 0;
m.direction;
m.fontSize; // font size in QC Units
m.fontSize_(0.1);

m.string_("SCTV").fontName_("Courier");
m.startColor_(Color.green);
m.billboardEnable_(false);
m.billboardEnable_(true);
m.maxFPS_(5.0);
m.maxFPS_(10);
m.maxFPS_(0.0); // no max

m.getOutputValue(\interpResult); // current rotation of the text in degrees
m.interpResult;
m.systemTime; // current System Time published in the composition
m.endColor.class; // yup, it's a SC Color object
m.endColor == Color.white;

(
// probably more efficient to do this in QC, but...
{
c = Color.blue;
100.do({ m.startColor_(c = c.vary(1)); 0.1.wait; });
}.fork(AppClock);
)

m.bounds = Rect(100, 20, 200, 260);

m.stop;

///////////// Fullscreen

(
w = SCWindow("SCTV", Rect(0,0,360, 280), border: false).front;
b = SCButton(w, Rect(0, 0, 150, 20))
	.states_([["Close Me"]])
	.action_({w.close});
m = SCQuartzComposerView(w, Rect(0,20,360, 260));
m.path = Document.current.path.dirname ++ "/SCQuartzComposerViewTest.qtz";

m.resize = 5;
m.start;
)

w.fullScreen;


////////// Structure test
(
w = SCWindow("SCTV").front;
m = SCQuartzComposerView(w, Rect(0,20,400, 260));
m.path = Document.current.path.dirname ++ "/SCQuartzComposerViewStructureTest.qtz";
m.start;
)

m.inputKeys;
m.outputKeys;
m.openInQC; // Take a look at the various inputs and outputs. Select and mouseover for key names.

// set several parameters at once
// [background color, num copies, scale, string, [font size in QC units, font]]
m.structure = [Color.red, 4, 1.5, "Hello", [0.2, "Courier"]];
m.structure = [Color.red, 3, 1.5, "World", [0.4, "Arial"]];
m.structure = [Color.red, 4, 0.1, "!!", [0.7, "Times"]];
m.structure = [Color.black, 4, 0.1, "!!!", [0.6, "Courier"]];
m.dictStructure = IdentityDictionary[\x->(-0.4), \y->0.4];

// get stuff out
// QCView stores all structures as instances of NSCFDictionary internally
// so all structure outputs are instances of IdentityDictionary
m.structure = [Color.blue, 4, 0.2, "Gruess Welt", [0.12, "Zapfino"]];
x = m.stringStruct; // separates the string into components
x[\component_1];

// pass something through
m.arbStructIn = ["foo", "bar", ["foobar"]]; // array in
x = m.arbStructOut; // IdentDict out with Integer Symbols as keys
x[\0];
x[\2][\0];
(
// convert to array
y = Array.newClear(x.size);
x.keysValuesDo({|i, elem| y[i.asInteger] = elem});
y.postln;
)

// use QC to concat the strings)
m.stringConcatIn = ["foo", "bar"]; // array in
x = m.stringConcatOut; // String Out


////////// Control some audio: Stupid Pan Example

(
w = SCWindow("Stupid Pan Example", Rect(0,20,600, 150)).front;
m = SCQuartzComposerView(w, Rect(0,20,600, 100));
m.path = Document.current.path.dirname ++ "/Stupid Pan.qtz";
m.resize = 5;
m.start;
)

s.boot;
// use mouse to set pan position
(
{
loop({
{ Pan2.ar(Saw.ar(mul: 0.1) * EnvGen.ar(Env.perc, timeScale: 4, doneAction: 2), m.x_pos) }.play;
1.wait;
});
}.fork(AppClock);
)

////////// Sonogram

// could be better optimised, but proves the concept
(
w = SCWindow("Sonogram", Rect(0,20,600, 300)).front;
m = SCQuartzComposerView(w, Rect(0,20,600, 256));
m.path = Document.current.path.dirname ++ "/SCQCsonogramCount2.qtz";
m.start;
m.setInputValue(\framesPerView, 300);
m.setInputValue(\magnitudes, (0, 0.01..1));
)

s.boot;
b = Buffer.alloc(s,256);
(
a = { FFT(b, LFSaw.ar(4000)); 0.0 }.play; // sawtooth

p = 0.25; i = 0;
//m.setInputValue(\period, p);
//m.maxFPS_(p.reciprocal * 2);
SystemClock.sched(0.0, {
b.getn(0, 256, { arg buf;
	var z, x;
	z = buf.clump(2).flop;
	z = [Signal.newFrom(z[0]), Signal.newFrom(z[1])];
	x = Complex(z[0], z[1]);
	//{m.setInputValue(\magnitudes, x.magnitude.resamp1(m.bounds.height * 0.5));}.defer
	{m.setInputValue(\magnitudes, x.magnitude * 0.025); m.setInputValue(\count, i);}.defer;
	i = i + 1;
}); p
});
)

a.free;
a = { FFT(b, Dust2.ar(500) * 5); 0.0 }.play; // Impulses

a.free;
c = Buffer.read(s, "sounds/a11wlk01.wav");
(
m.setInputValue(\framesPerView, 50);
a = { var colum;
	colum = PlayBuf.ar(1, c, BufRateScale.kr(c) * Line.kr(1, 3, 20), loop: 1);
	FFT(b, colum);
	colum
}.play;
)

///////////// Cheap Level Meter
(
w = SCWindow("Level Meters", Rect(128, 64, 200, 400)).front;

m = SCQuartzComposerView(w, Rect(20,20,50, 360));
n = SCQuartzComposerView(w, Rect(130,20,50, 360));
m.path = Document.current.path.dirname ++ "/SCLevelMeter.qtz";
n.path = Document.current.path.dirname ++ "/SCLevelMeter.qtz";
m.maxFPS_(20); n.maxFPS_(20);
m.start; n.start;
~meters = [m, n];
)

s.boot;

// MouseX controls noise amp
(
o = OSCresponder(s.addr, '/tr', {arg time, resp, msg;
	{~meters[msg[2]].level = (msg[3] + 0.01).explin(0.01,1.01, 0, 1);}.defer;
}).add;
b = Buffer.read(s, "sounds/a11wlk01.wav");	
a = { var colum, noise, imp, delimp;
	imp = Impulse.kr(20);
	delimp = Delay1.kr(imp);
	colum = PlayBuf.ar(1, b, BufRateScale.kr(b), loop: 1);
	noise = PinkNoise.ar(MouseX.kr);
	// measure Peak
	SendTrig.kr(imp, 0, Peak.ar(colum, delimp));
	SendTrig.kr(imp, 1, Peak.ar(noise, delimp));
	[colum, noise];
}.play;
)

a.free;


/// using an event type to control a QCView by patterns:

Event.addEventType(\quartz, { |server|
	var latency = server.latency;
	var view = ~view.postln;
	var key = ~key, value = ~value;
	AppClock.sched(latency, { view.postln; view.setInputValue(key, value) });
});


(
w = SCWindow("Level Meters", Rect(128, 64, 200, 400)).front;

m = SCQuartzComposerView(w, Rect(20,20,50, 360));
m.path = "Help/GUI/Cocoa-GUI/SCQuartzComposerView/SCLevelMeter.qtz".standardizePath;
m.maxFPS_(20);
m.start;
)

(
Pbind(
	\type, \quartz,
	\view, m,
	\key, \level,
	\value, Pwhite(0, 1.0, inf).explin(0.01,1.01, 0, 1),
	\dur, 0.1
).play;
)

m.setInputValue(\level, 0.5);


