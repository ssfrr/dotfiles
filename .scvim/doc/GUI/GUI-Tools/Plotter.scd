Plotter			plot numerical data on a window or view	

Inherits from: Object

Plot data of up to three dimensions on a Window or UserView.

See also: plot.


Creation / Class Methods

	*new(name, bounds, parent)
		name - Plot window title.
		parent - Either a Window/View may be passed in - then the plot is embedded. Otherwise a new Window is created.
		bounds - the window bounds (a Rect)
		
		(
		a = Plotter("the plot", Rect(600, 30, 800, 250));
		a.value = (0..1000).normalize(0, 14pi).curdle(0.01).scramble.flat.sin;
		)

		
	
	something.plot2(args)
	
		// plot array
		[1, 6, 2, -5, 2].plot2;
		(0..100).normalize(0, 8pi).sin.plot2;
		// nested arrays
		{ (0..100).normalize(0, 15.0.rand).sin }.dup(3).plot2;
		{ { (0..17).normalize(0, 15.0.rand).sin }.dup(4) }.dup(3).plot2;
		// UGen functions
		{ SinOsc.ar([700, 357]) * SinOsc.ar([400, 476]) * 0.2 }.plot2;
		// Buffer
		Buffer.read(s, "sounds/SinedPink.aiff").plot2;
		// Env
		Env.perc(0.4, 0.6).plot2;
		
	something.plotGraph2(n,from,to,...)
	
		{ |x| sin(x) }.plotGraph2(300,0,2*pi);
		{ |x| sin(1/x)*x }.plotGraph2(from:0.0001,to:0.2);	
		

Keyboard shortcuts

When the plotter window has focus, the following keyboard shortcuts can be used to change the display:
	
			+ / -		vertical zoom
			=		compare plot channels
			n		toggle normalize display (0..1) / (-1..1), or fit range
			s		toggle superposition  (see: superpose)
			m		switch plot mode (see: plotMode)
			
			e		toggle editing (see: editMode)
			g 		toggle horizontal (domain) grid
			G 		toggle vertical (codomain) grid
			
			ctrl-+ / -	zoom font
			alt-click	post value

				

Accessing Instance and Class Variables
	
	makeWindow(parent, bounds)
		Open given plotter in a new window or within a given composite view.
		parent - Either a Window/View may be passed in - then the plot is embedded. Otherwise a new Window is created.
		bounds - the window bounds (a Rect).
	
	plotMode_(symbol)
	plotMode
		
		Set the style of data display. 
		Available modes: 
		\linear	connecting data points with linear interpolation
		\points	draw data points only
		\plines	combination of lines and points
		\levels	horizontal lines
		\steps	connecting data points with step interpolation
		
		a = (0..20).scramble.plot2;
		a.plotMode = \points; a.refresh;
		a.plotMode = \plines; a.refresh;
		a.plotMode = \levels; a.refresh;
		a.plotMode = \steps; a.refresh;
		a.plotMode = \linear; a.refresh;
		
	setProperties(...pairs)
		
		Set properties of all plot views. Defaults are taken from GUI.skin.at(\plot);
		Supported properties: 
			font, fontColor, gridColorX, gridColorY, plotColor (an array), backgroundColor,
			gridLinePattern, gridLineSmoothing (bool), labelX, labelY, gridOnX (bool), gridOnY (bool)
		
		(
		a = { (0..30).scramble }.dup(2).plot2;
		a.setProperties(
			\fontColor, Color.red, 
			\plotColor, Color.blue, 
			\backgroundColor, Color.black,
			\gridColorX, Color.white,
			\labelX, "Humidity"
		); 
		a.refresh;
		);
		
		GUI.skin.at(\plot); // defaults

	editMode_(boolean)
	editMode
		
		If the edit mode is set to true, the data may be edited via cursor.
		
		a = (0..20).plot2;
		a.editMode = true; // now edit the data by clicking into the plot..
		a.value; // the value
		
	resolution_(val)
	resolution
		
		Set the number of data points displayed maximally per pixel (default: 1)
		
		a = (0..200).scramble.plot2;
		a.resolution = 8; a.refresh; // resizing the window shows interpolation
		a.resolution = 1; a.refresh;
		
	findSpecs_(boolean)
	findSpecs
		
		If true (default: true), specs are derived from new data (using min and max values) automatically.
		
	superpose_(boolean)
	superpose
		
		If set to true, plotter displays channels on top of each other (keyboard shortcut: s)
		
		a = { (0..30).scramble }.dup(2).plot2;
		a.superpose = true; a.refresh;
		
		
	value
	value_(array)
		
		Return or set the data values. Data may be numerical arrays of up to 3 dimensions.
		
		a = [1, 4, 2, 7, 4].dup(2).plot2;
		a.value;
	
	data
		
		Reference to the current internal data.
		
		
	cursorPos
		
		Return the last cursorPos (a Point)
	
	plots
		
		Return the single subplots (a Plot).
		
	specs
	specs_(list)
		
		Set or get the spec for the y-axis (codomain).
		
		(
		a = { (40..3000).scramble }.dup(2).plot2;
		a.specs = \freq.asSpec; a.refresh;
		)
	
	domainSpecs
	domainSpecs_(list)
		
		Set or get the spec for the x-axis (domain).
		
		a = { (40..300).scramble }.dup(2).plot2;
		a.domainSpecs = \freq.asSpec; a.refresh;
	
	editFunc
	editFunc_(func)
		
		Supply a function which is evaluated when editing data. The function is called with the arguments: plotter, plotIndex, index, val, x, y
		
		(
		a = { (0..10).scramble.normalize }.dup(2).plot2;
		a.editMode = true;
		a.editFunc = { |...args| args.postln };
		);
		
		// using plotter as a control interface
		(
		a = (0..10).scramble.normalize(300, 400).plot2;
		a.specs = \freq; a.plotMode = \points;
		a.editMode = true;
		x = { SinOsc.ar(\freq.kr(a.value)).mean * 0.1 }.play;
		a.editFunc = { |plotter, plotIndex, i, val|
			x.setn(\freq, a.value)
		};
		a.parent.onClose = { x.release };
		);
		
		(
		a = { (0..10).scramble.normalize(300, 400) }.dup.plot2;
		a.specs = \freq; a.plotMode = \levels;
		a.editMode = true;
		x = {
			var phase = SinOsc.ar(\rate.kr(a.value[1]));
			SinOsc.ar(\freq.kr(a.value[0]), phase).mean * 0.1 
		}.play;
		a.editFunc = { |plotter, plotIndex, i, val|
			x.setn(\freq, a.value[0]);
			x.setn(\rate, a.value[1]);
		};
		a.parent.onClose = { x.release };
		);


		
	
Changing global defaults

The default styles are kept (and may be overridden) in GUI.skin.at(\plot). See also GUI help.	
				

		// specify plot layout
		(
		GUI.skin.plot.gridLinePattern = FloatArray[1, 0];
		GUI.skin.plot.fontColor = Color(0.5, 1, 0);
		GUI.skin.plot.gridColorX = Color.yellow(0.5);
		GUI.skin.plot.gridColorY = Color.yellow(0.5);
		GUI.skin.plot.background = Color.black;
		GUI.skin.plot.plotColor = (10..0).normalize(0.1, 1).collect { |i| Color.rand(i) };
		GUI.skin.plot.labelX = "X";
		GUI.skin.plot.labelY = "Y";
		);
		
		(
		x = { |i| (0..60).scramble.clump(8) * (3.5 ** i) }.dup(3);
		x.plot2("ARRAY:PLOT", Rect(200, 300, 600, 500));
		)
		
		
		GUI.skin.plot.put(\plotColor, { Color.rand(0.0, 0.8) } ! 8);
		[(0..100), (20..120), (40..140)].squared.flop.bubble.plot2;


		// reset the defaults:
		Plot.initClass;



More examples



// embedding in another GUI
(
w = Window("plot panel", Rect(20, 30, 520, 250));
Slider.new(w, Rect(10, 10, 490, 20)).resize_(2).action_ { |v|
	a.value = (0..(v.value * 80).asInteger).scramble;
	w.refresh;
};
z = CompositeView(w, Rect(10, 35, 490, 200)).background_(Color.rand(0.7)).resize_(5);
a = Plotter("plot", parent: z).value_([0, 1, 2, 3, 4].scramble * 100); 
w.front;
)


(
a = Plotter("the plot", Rect(600, 30, 600, 400));
a.value = (0..100).normalize(0, 8pi).sin;
)

a.value = { |i| (0..90) % (i + 12) + ( (0..90) % (i + 2 * 1) ) }.dup(3);
a.value = (0..12).squared;
a.plotMode = \points; a.refresh;
a.plotMode = \levels; a.refresh;
a.plotMode = \plines; a.refresh;

a.domainSpecs = [[0, 115, \lin, 1]]; a.refresh;

a.parent.close; // close window
a.makeWindow;	// open it again

a.value = { (0..70).scramble }.dup(3);
a.plotMode = \linear; a.refresh;
a.value = { |i| (0..2000).normalize(0, 4pi + i).sin } ! 4; // lots of values, test efficiency
a.value = { |i| (0..10000).normalize(0, 8pi + i).sin } ! 3; // lots of values, test efficiency
a.value = { (0..140).scramble } ! 7;

a.value = { |i| (0..90).normalize(0, 8pi + (i*2pi)).sin } ! 2 * [400, 560] + 700;
a.value = { |i| (_ + 2.0.rand).dup(100).normalize(0, 8pi + i).sin } ! 2 * 400 + 700;


// multi channel expansion of single values
a.value = { |i| (_ + 2.0.rand).dup(100).normalize(0, 8pi + i).sin *.t [1, 2, 3] } ! 2 * 400 + 700;
a.value = { |i| (0..10) **.t [1, 1.2, 1.3, 1.5] * (3.5 ** i) }.dup(3);

a.parent.bounds = Rect(400, 100, 500, 700);
a.parent.bounds = Rect(600, 30, 500, 300);

a.superpose = true;
a.value = { |i| (0..20) * (3.5 ** i) }.dup(5);
a.superpose = false;

// specs

a.value = (50..90).midicps.scramble;
a.specs = \freq; a.refresh;
a.value = (1..60).scramble.neg;
a.specs = \db; a.refresh;

a.value = { |i| { exprand(1e3, (10 ** (i + 8))) }.dup(90) }.dup(3);
a.value = { { exprand(1e3, 1e9) }.dup(90) }.dup(3);
a.specs = [[1e3, 1e10, \exp], [1e3, 1e20, \exp], [1e3, 1e30, \exp]]; a.refresh;
a.domainSpecs = [[0, 5], [-8, 100], [-1, 1]]; a.refresh;


// Array:plot
(
a = (4 ** (-5..0)).postln.plot2;
a.specs = \delay; a.refresh;
a.domainSpecs = [0, 10, \lin, 0, 0, " Kg"].asSpec; a.refresh;
);

a.domainSpecs = [0.1, 10, \exponential, 0, 0, " Kg"].asSpec; a.refresh;
a.domainSpecs = [-10, 10, \lin, 0, 0, " Kg"].asSpec; a.refresh;


a = [(0..100) * 9, (200..1300) * 2, (200..1000)/ 5].plot2;
a.superpose = true;

a = [[0, 1.2, 1.5], [0, 1.3, 1.5, 1.6], [0, 1.5, 1.8, 2, 6]].midiratio.plot2;
a.plotMode = \levels; a.refresh;
a.superpose = false;



// Function:plot
a = { SinOsc.ar([700, 357]) * SinOsc.ar([400, 476]) * 0.2 }.plot2;
a = { SinOsc.ar([700, 357] *0.02) * SinOsc.ar([400, 476]) * 0.3 }.plot2(0.2, minval: -1);
a = { SinOsc.ar(440) }.plot2(1);


// Env:plot
Env.perc(0.4, 0.6).plot2;
Env.new({ 1.0.rand2 }! 8, { 1.0.rand } ! 7, \sin).plot2;

// Buffer:plot
b = Buffer.read(s, "sounds/SinedPink.aiff");
		// "sounds/SinedPink.aiff" contains SinOsc on left, PinkNoise on right
b.plot2;
b.free;






