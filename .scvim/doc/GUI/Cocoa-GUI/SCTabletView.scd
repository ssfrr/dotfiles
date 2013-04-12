SCTabletView			a view that receives extended wacom tablet data	

Inherits from: Object : SCView

An otherwise featureless view that receives extended wacom tablet data. It can also be used with a normal mouse but with less resolution.

See also: SC2DTabletSlider

Some Important Issues Concerning SCTabletView

Drag and drop returns and accepts a Point.

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
		x - subpixel location in view
		y - subpixel location in view
		pressure - 0..1
		tiltX : -1 (max. left) ... +1 (max. right)
		tiltY : -1 (max. down) ... +1 (max. up)
		deviceID - will be used to look up if the tip or the eraser is used
		buttonNumber - 0 left, 1 right, 2 middle wheel click
		clickCount - double click, triple click ...
			most relevant for the mouseDown, but still valid for the dragged and mouseUp
		absoluteZ - the wheel on the side of some mice
		rotation - in degrees, only on the 4d mice


Examples
	
(
w = Window.new;
t = TabletView(w,Rect(40,40,300,300));
t.background = Color.white;
w.front;

t.mouseDownAction = { arg view,x,y,pressure,tiltx,tilty,deviceID, buttonNumber,clickCount,absoluteZ,rotation;
	["down",x,y,pressure,tiltx,tilty,deviceID, buttonNumber,clickCount,absoluteZ,rotation].postln;
};

t.action = { arg view,x,y,pressure,tiltx,tilty,deviceID, buttonNumber,clickCount,absoluteZ,rotation;
	["dragging", x,y,pressure,tiltx,tilty,deviceID, buttonNumber,clickCount,absoluteZ,rotation].postln;
	t.background = Color(x / 300,y / 300,tiltx,pressure);
};

t.mouseUpAction = { arg view,x,y,pressure,tiltx,tilty,deviceID, buttonNumber,clickCount,absoluteZ,rotation;
	["up",x,y,pressure,tiltx,tilty,deviceID, buttonNumber,clickCount,absoluteZ,rotation].postln;
};

)

//Assign the same function to each action
(
w = Window.new;
t = TabletView(w,Rect(40,40,300,300));
t.background = Color.white;
w.front;

f = { arg view,x,y,pressure,tiltx,tilty,deviceID, buttonNumber,clickCount;
	[x,y,pressure,tiltx,tilty,deviceID, buttonNumber,clickCount].postln;
	t.background = Color(x / 300,y / 300,tiltx,pressure);
};

t.mouseDownAction = f;
t.action = f;
t.mouseUpAction = f;

)

// sound example

s.boot

(
SynthDef("help-2DTabletSlider",{ arg freq=440,int1=5,int2 = -5,
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
},[0.1,0.1,0.1,0.1,0.1,nil]).send(s);
)

(

	var w, v,freq,int,synth;
	synth = Synth("help-2DTabletSlider");
	w = Window.new.front;

	freq = ControlSpec(100,3000,\exp);
	int = ControlSpec(-48,48,\linear,1);
	
	v = TabletView(w,Rect(10,10,380,380));
	v.background = Color.blue.alpha_(0.2);
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
	
)



	
//An example using crucial library
(
Instr([\minimoog,\loose],{ arg freq=440,int1=5,int2 = -5,
			ffreqInterval=0,rq=0.4,gate=0.0;
	var p,c,d,f;
	c=LFNoise1.kr(0.1,0.45,0.55);
	d=LFNoise1.kr(0.1,0.45,0.55);
	f=LFNoise1.kr(0.1,2);
	p=Pulse.ar([ freq * int1.midiratio + f , freq, freq * int2.midiratio - f],
			[c,d,c],0.2);
			
	RLPF.ar(Mix.ar(p),freq * ffreqInterval.midiratio,rq)
		* EnvGen.kr(Env.adsr, gate, Latch.kr(gate,gate))

},#[
	nil,
	[[-48,48,\linear,1]],
	[[-48,48,\linear,1]],
	[[-48,48,\linear,1]]
]);

p = Patch.new([ 'minimoog', 'loose' ],[
	nil,nil,nil,nil,nil,
	KrNumberEditor(0.0,\gate) // override the default control
]);

Sheet({ arg f;
	var v,freq,int;
	freq = ControlSpec(100,3000,\exp);
	int = [-48,48,\linear,1].asSpec;
	
	p.topGui(f);
	v = TabletView(f,Rect(0,0,200,200));
	v.background = Color.white;
	v.action = { arg view,x,y,pressure,tiltx,tilty;
		p.args.at(1).value_( int.map( x / 200 ) ).changed;
		p.args.at(2).value_( int.map( y / 200 ) ).changed;
		p.args.at(3).value_( int.map( pressure ) ).changed;
	};
	v.mouseDownAction = { arg view,x,y,pressure;
		p.args.at(0).value_( rrand(30,80).midicps ).changed;
		p.args.at(5).value_( pressure ).changed;
	};
	v.mouseUpAction = { arg view,x,y,pressure;
		p.args.at(5).value_( 0.0 ).changed;
	};
});

)



