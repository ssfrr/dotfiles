SCStaticText			a view for displaying text	

Inherits from: Object : SCView : SCStaticTextBase

Inherits formatting methods from SCStaticTextBase.

Creation / Class Methods

	*new (parent, bounds)
	
		parent - The parent view.
		bounds - An instance of Rect, or a Point indicating width@height.
		
		(	
		w = Window.new.front;
		a = StaticText(w, Rect(10, 10, 200, 20));
		a.string = "an instance of String";
		)
		
Examples

// basic usage
(	
	w = Window.new.front;
	a = StaticText(w, Rect(10, 10, 200, 20));
	a.string = "Rolof's Rolex";
)

// adjust look , alignment and content
a.background=Color.grey;
a.align = \center;
a.font = Font("Monaco", 11);
a.string = "Your Rolex";

// Monitoring values in a synth
(

w = Window("Frequency Monitor", Rect(200, SCWindow.screenBounds.height-200,300,150)).front;

a = StaticText(w, Rect(45, 10, 200, 20)).background_(Color.rand);

a.string = " Current Frequency ";

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
		
		0.01.wait;
		}.loop
	
	}.play
});

CmdPeriod.doOnce({w.close});
w.onClose={r.stop; q.free; b.free }; //clean up if the window closes

)

// dynamic text

(	
	w = Window.new.front;
	w.view.background=Color.white;
	a = Array.fill(20, {StaticText(w, Rect(w.bounds.extent.x.rand, w.bounds.extent.y.rand, 160, 16))
		.string_("Rolof's Rolex".scramble)
		.align_(\center)
		.stringColor_(Color.rand)
		.font_(Font([
			"Helvetica-Bold",
			"Helvetica",
			"Monaco",
			"Arial",
			"Gadget",
			"MarkerFelt-Thin"
		].choose, 11))
	});
	
	r = {inf.do{|i|
		thisThread.randSeed_(1284);
		a.do{|item|
			// setting GUI values is asynchronous, so you must use .defer
			{item.bounds = Rect(5+w.bounds.extent.x.rand * (cos(i*0.01)).abs,
						w.bounds.extent.y.rand * sin(i*0.01),
						160, 20)}.defer;
		};
		0.15.wait;
	}}.fork;
	CmdPeriod.doOnce({w.close});
	w.onClose_({r.stop});
)







