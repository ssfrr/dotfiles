SC2DTabletSlider			a 2D slider with support for extended wacom data	

Inherits from: Object : SCView : SCControlView : SCSliderBase : SC2DSlider

See also: SC2DSlider, SCTabletView

Some Important Issues Concerning SC2DTabletSlider

Inherits much of its behavior form SC2DSlider and SCSliderBase. Drag and drop returns and accepts a Point.

Creation / Class Methods

	*new (parent, bounds)
	
		parent - The parent view.
		bounds - An instance of Rect, or a Point indicating width@height.

Accessing Instance and Class Variables
	
	mouseDown (x, y, pressure, tiltx, tilty, deviceID, buttonNumber, clickCount, absoluteZ, rotation)
	mouseUp (x, y, pressure, tiltx, tilty, deviceID, buttonNumber, clickCount, absoluteZ, rotation)
	doAction (x, y, pressure, tiltx, tilty, deviceID, buttonNumber, clickCount, absoluteZ, rotation)
	
		Each of the three actions are passed the following wacom tablet values:
		view - the view
		x - 0..1 value
		y - 0..1 value
		pressure - 0..1
		tiltX - 0..1 where available
		tiltY - 0..1 where available
		deviceID - will be used to look up if the tip or the eraser is used
		buttonNumber - 0 left, 1 right, 2 middle wheel click
		clickCount - double click, triple click ...
			most relevant for the mouseDown, but still valid for the dragged and mouseUp
		absoluteZ - the wheel on the side of some mice
		rotation - in degrees, only on the 4d mice

Examples

(
var window;
var slider;

window = Window("2DSlider", Rect(100,100, 140 ,140));
window.front;

	slider = TabletSlider2D(window, Rect(20, 20,80, 80))
			.x_(0.5).y_(1);
	slider.mouseDownAction = { arg view,x,y,pressure,tiltx,tilty,deviceID, buttonNumber,clickCount;
		["down",view,x,y,pressure,tiltx,tilty,deviceID, buttonNumber,clickCount].postln;
	};	
	slider.action = { arg view,x,y,pressure,tiltx,tilty,deviceID, buttonNumber,clickCount;
		[view,x,y,pressure,tiltx,tilty,deviceID, buttonNumber,clickCount].postln;
	};
	slider.mouseUpAction = { arg view,x,y,pressure,tiltx,tilty,deviceID, buttonNumber,clickCount;
		["up",view,x,y,pressure,tiltx,tilty,deviceID, buttonNumber,clickCount].postln;
	};
	slider.setProperty(\clipInBounds,0)
)

// drag an drop Points
(

w = Window("TabletSlider2D", Rect(100,100, 500 ,300));
w.view.decorator = FlowLayout(w.view.bounds);

t = TabletSlider2D(w, Rect(20, 20,280, 280))
		.x_(0.5)	// initial location of x
		.y_(1)	// initial location of y
		.knobColor_(Color.rand)
		.action_({|sl|
			[\sliderX, sl.x, \sliderY, sl.y].postln;
		});
t.step_(0.01);

n=CompositeView.new(w, 200@300);
n.decorator= FlowLayout(n.bounds);

v = { |i| DragBoth(n, Rect(0, i * 20, 200, 20)).align_(\center).background_(Color.rand) }.dup(5);
StaticText.new(n,200@150).string_("hold down cmd and drag points from the slider to the drag slots, or reverse").stringColor_(Color.white);	
		
w.front;
)

// sound example

(
s.waitForBoot({
	
	var w, v,int,synth;
	
	synth=SynthDef("help-TabletSlider2D",{ arg freq=440,int1=5,int2 = -5,
				ffreqInterval=0,rq=0.4,gate=0.0;
		var p,c,d,f;
		c=LFNoise1.kr(0.1,0.45,0.55);
		d=LFNoise1.kr(0.1,0.45,0.55);
		f=LFNoise1.kr(0.1,2);
		p=Pulse.ar([ freq * int1.midiratio + f , freq, freq * int2.midiratio - f],
				[c,d,c],0.2);
		Out.ar(0,
			RLPF.ar(Mix.ar(p),freq * ffreqInterval.midiratio,rq)
				* EnvGen.kr(Env.adsr, gate, gate)
		)
	},[0.1,0.1,0.1,0.1,0.1,nil]).play(s);
	
	w = Window.new.front;
	
	int = ControlSpec(-48,48,\linear,1);
	
	v = TabletSlider2D(w,Rect(10,10,380,380));
	v.background = Color.blue.alpha_(0.2);
	v.knobColor = Color.red;
	v.action = { arg view,x,y,pressure,tiltx,tilty;
		synth.set(	
				\int1, int.map(x),
				\int2, int.map(y),
				\ffreqInterval, int.map(pressure),
				\gate, pressure.postln
			);
	};
	
	v.mouseDownAction = { arg view,x,y,pressure;
		synth.set(
				\freq , rrand(30,80).midicps,
				\gate, pressure.postln
			)
	};
	v.mouseUpAction = { arg view,x,y,pressure;
		synth.set( \gate, 0.postln )
	};
});
)


