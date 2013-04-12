SCScope			oscilliscope: render a buffer to a view in real time	

Inherits from: Object : SCView

An oscilloscope-type view.

See also: SCStethoscope, SCFreqScope,SCFreqScopeWindow

Some Important Issues Regarding SCScope

SCScope can only work with the internal Server.

Creation / Class Methods

	*new (parent, bounds)
	
		parent - The parent view.
		bounds - An instance of Rect, or a Point indicating width@height.

Accessing Instance and Class Variables
					
	bufnum
	bufnum_ (num)
	
		num - An integer.The bufnum of the scope's Buffer.
		
	style_ (val)
	
		The display style of the scope.
		val - an integer.		
		0 = vertically spaced
		1 = overlapped
		2 = x/y

	xZoom
	xZoom_ (val)
	
		The x- scaling of the scope.
		val - An instance of Float. Must be in steps of 2**(1/n ), where n is a positive integer
		
	yZoom
	yZoom_ (val)
	
		The y- scaling of the scope. Must be in steps of 2**(1/n ), where n is a positive integer
		val - An instance of Float.
	x
	x_ (val)
	
		The x offset of the scope in samples.
		val - An Integer.
				
	waveColors
	waveColors_ (arrayOfColors)
	
		arrayOfColors - An Array of Colors. [ color1, color2, color2, ...], corresponding to the number of channels.

Subclassing and Internal Methods
	The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed.

	properties
			
		returns;
		[ \bounds, \visible, \enabled, \canFocus, \resize, \background, \minWidth, \maxWidth, \minHeight, \maxHeight, \bufnum, \x, \y, \xZoom, \yZoom, \gridColor, \waveColors, \style]

	gridColor
	gridColor_ (color)
				
	y
	y_ (val)

Examples

// execute these in succession
// the cross platform syntax for SCScope is ScopeView
(
s = Server.internal;
s.boot;
)
(
f = Buffer.alloc(s,1024,2);
b = Bus.audio(s,1);

w=Window.new.front;
c = ScopeView(w.view,w.view.bounds.insetAll(10,10,10,10));  // this is SCScope
c.bufnum = f.bufnum;
)
(
// listening to the bus, using ScopeOut to write it to the buffer
a=SynthDef("monoscope", { arg bus, bufnum;
				var z;
				z = In.ar(bus,2);
				// ScopeOut writes the audio to the buffer
				ScopeOut.ar(z, bufnum);
			}).play(
				RootNode(s),
				[\bus,b.index, \bufnum, f.bufnum] ,
				\addToTail // make sure it goes after what you are scoping
			);

// making noise onto the buffer
d=SynthDef("noise", { arg bus;
				var z;
				z = LFSaw.ar(SinOsc.kr(0.1).range(300,1000),[0,1]*pi) * 0.1;
				Out.ar(bus, z);
			}).play(
				s,
				[\bus,b.index]
			);
)

c.style = 0 // vertically spaced
c.style = 1 // overlapped
c.style = 2 // x/y

( 
//remember to free your stuff when finished
a.free;
d.free;
f.free;
b.free;
w.close;
)


/***** Interactive Example with Sound (explains all the options) *****/

(

s = Server.internal;
s.waitForBoot({	
	
	var func, sdef1, sdef2, syn1, syn2,startButton ;
	f = Buffer.alloc(s,1024,2);
	b = Bus.audio(s,1);
	
	w=Window("Scope", Rect(150, SCWindow.screenBounds.height-500,790,400)).front;
	c = ScopeView(w,Rect(10,10,380,380)); // this is SCScope
	c.bufnum = f.bufnum;
	
	v=CompositeView(w,Rect(400,10,380,380)).background_(Color.rand(0.7));
	v.decorator = n = FlowLayout(v.bounds, margin: 0@0, gap: 5@5);
	
	a = StaticText(v, Rect(20, 70, 90, 20)).string_(" xZoom = 1").background_(Color.rand);
	m = Slider(v, Rect(20, 60, 285, 20)).background_(a.background).action_({func.value}).value_(0.5);
	d = StaticText(v, Rect(20, 70, 90, 20)).string_(" yZoom = 1").background_(Color.rand);
	g = Slider(v, Rect(20, 60, 285, 20)).background_(d.background).action_({func.value}).value_(0.5);
	
	h = StaticText(v, Rect(20, 70, 90, 20)).string_(" x = 0").background_(Color.rand);
	i = Slider(v, Rect(20, 60, 285, 20)).background_(h.background).action_({func.value}).value_(0.5);

	Button(v, Rect(0,0,380, 20))
		.states_([["waveColors = [ Color.rand, ... ]",Color.black,Color.rand]])
		.action_({c.waveColors = [Color.rand,Color.rand]});
	
	Button(v, Rect(0,0,380, 20))
		.states_([[" background = Color.rand(0.1,0.3) ",Color.black,Color.rand]])
		.action_({c.background = Color.rand(0.1,0.3) });
	
	t= Button(v, Rect(0,0,380, 20))
		.states_([["Current style is 0",Color.black,Color.rand],
			["Current style is 1",Color.black,Color.rand],
			["Current style is 2",Color.black,Color.rand]])
		.action_({func.value});
	
	func={
		c.xZoom = ([0.25, 10, \exp, 1/8, 1].asSpec.map(m.value)); a.string = " xZoom = %".format(c.xZoom);
		c.yZoom = ([0.25, 10, \exp, 1/8, 1].asSpec.map(g.value)); d.string = " yZoom = %".format(c.yZoom);
		c.x = ([ -1024,1024, \linear, 1/8, 1].asSpec.map(i.value)); h.string = " x = %".format(c.x);
//		c.y = ([-1,1, \linear, 1/16, 1].asSpec.map(k.value)); j.string = " y = %".format(c.y);
		c.style=t.value
		};
		
	startButton = Button.new(v, Rect(0,0,380, 50))
		.states_([["Start Sound",Color.black,Color.green],["Stop Sound",Color.black,Color.red]]).action_({});
	
				
	startButton.action_{
		(startButton.value==1).if{
	syn1=SynthDef("test1", { arg bus, bufnum;
					var z;
					z = In.ar(bus,2);
					// ScopeOut writes the audio to the buffer
					ScopeOut.ar(z, bufnum);
					Out.ar(0,z);
				}).play(
					RootNode(s),
					[\bus,b.index, \bufnum, f.bufnum] ,
					\addToTail // make sure it goes after what you are scoping
				);
	
	// making noise onto the buffer
	syn2=SynthDef("test2", { arg bus;
					var z;
					z = PMOsc.ar([300,250],*SinOsc.ar([0.027,0.017])*pi) * 0.1;
					Out.ar(bus, z);
				}).play(s,[\bus,b.index]);
	
		
		
		}{syn1.free; syn2.free};
	
	};
	w.onClose={syn1.free; syn2.free; b.free; f.free};
	CmdPeriod.doOnce({w.close});
})
)


