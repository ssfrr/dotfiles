SCEnvelopeEdit			an envelope editor view	

Inherits from: Object : SCView : SCEnvelopeView

An editable Envelope view.

See also: SCEnvelopeView

Some Important Issues Regarding SCEnvelopeEdit

The breakpoints are color coded as follows:
	blue -	normal
	red -		sustain node
	green -	loop node

Creation / Class Methods

	*new (parent, bounds, env, pointsPerSegment)
	
		parent - The parent view.
		bounds - An instance of Rect, or a Point indicating width@height.
		env - The envelope. An instance of Env.
		pointsPerSegment - The resolution in points per segment. Default value is 10.

	*paletteExample (parent, bounds)

Accessing Instance and Class Variables

	refresh
	
		If the Env object is modified directly, this needs to be called to update the GUI.

	maxLevel
	maxLevel_ (level)
	
		Changes maximum level shown in editor.
		level - and Instance of Float.
		
	minLevel
	minLevel_ (level)
	
		Changes minimum level shown in editor.
		level - and Instance of Float.

	minTime
	minTime_ (sec)
	
		Changes minimum time (sec) shown in editor. Negative times are okay because Env uses inter-node durations.
		sec - An instance of Float. Seconds.
		
	maxTime
	maxTime_ (sec)
	
		Changes maximum time (sec) shown in editor.
		sec - An instance of Float. Seconds.

Subclassing and Internal Methods
	The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed.

	defaultMauseDownAction (x, y, modifiers, buttonNumber, clickCount)
	
	*viewClass
	env_ (e)
	addBreakPoint (level)
	insertAtTime (time, level)
	pointsPerSegment
	env
	initSCEnvelopeEdit (argEnv, argPPS, setMinMax)
	redraw
	updateAll
	updateSegment (segNum)
	clear
		
Examples

(
// make a basic editor
e = Env([1,2],[10]);
w = SCWindow("Env Editor", Rect(200,200,300,200));
v = SCEnvelopeEdit(w, w.view.bounds.moveBy(20,20).resizeBy(-40,-40), e, 20).resize_(5);
w.front;
)
v.addBreakPoint;

v.clear;
v.redraw;
v;
)

v.maxLevel_(2);	// to give more headroom
v.maxTime_(2);	// to increase release point
v.minTime_(-1);	// to increase attack time

e.curves_ = 'sin';	// env object is changed
v.refresh;		// must refresh editor



// Controlling a Synth

s=Server.internal;
s.boot;
(
e = Env([0, 1, 0.7, 0.9, 0], [0.03, 0.03, 0.03, 0.03], 'sin');
f = Env([0, 1, 0.7, 0.9, 0], [0.03, 0.03, 0.03, 0.03], 'sin');
w = SCWindow("Shards", Rect(100, 100, 500, 400));
v = SCEnvelopeEdit(w, w.view.bounds.resizeBy(-20, -200), e, 10).resize_(2);
SCStaticText(w, v.bounds).string_(" amplitude").resize_(2);
x = SCEnvelopeEdit(w, v.bounds.moveBy(0, 200), f, 10).resize_(2);
SCStaticText(w, x.bounds).string_(" frequency").resize_(2);
w.front;
)

(
SynthDef("sineBlip", {
	arg freq=440, vol=0.1, la0, la1, la2, la3, la4, ta0, ta1, ta2, ta3, crva,
		lf0, lf1, lf2, lf3, lf4, tf0, tf1, tf2, tf3, crvf;
	var signal, fenv, aenv;
	fenv = EnvGen.ar(Env([lf0,lf1,lf2,lf3,lf4],[tf0,tf1,tf2,tf3], crvf));
	aenv = EnvGen.ar(Env([la0,la1,la2,la3,la4],[ta0,ta1,ta2,ta3], crva), doneAction: 2);
	signal = SinOsc.ar([freq, freq*2] * fenv) * aenv * vol;
	Out.ar(0, signal.dup);
}).send(s);
)

(
Routine({
	var par, indices;
	indices = (2..21);
	loop({
		par = (indices +++ (v.env.levels ++ v.env.times ++ v.env.curves ++ x.env.levels ++ x.env.times ++ x.env.curves)).flatten;
		s.sendBundle(s.latency, [\s_new, "sineBlip", -1, 1, 1, \freq, exprand(4e3,11e3)] ++ par);
		0.04.wait;
	});
}).play;
)


