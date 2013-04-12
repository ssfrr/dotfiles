SCLevelIndicator			a level indicator GUI widget	

Inherits from: Object : SCView

A level indicator view, suitable for use as a level or peak meter, etc.

See also: SCRangeSlider

Creation / Class Methods

	*new (parent, bounds)
	
		parent - The parent view.
		bounds - An instance of Rect, or a Point indicating width@height.
		
		(
		w = Window.new.front;
		a = SCLevelIndicator(w, Rect(10, 10, 20, 160));
		)


Accessing Instance and Class Variables
	
	value
	
		Gets the current level of the view.


	value_ (val)
	
		Sets the current level of the view
		val - A Float between 0 and 1.


	valueAction_ (val)
	
		As value but calls the action function. Currently not used.
		val - A Float between 0 and 1.


	warning_ (val)
	
		Styles 0 and 2 (see below) implement a warning display. If critical is > warning the view will turn yellow if value is >= to val. If critical is <= warning the view will turn yellow if value is <= to val. If drawsPeak is true warning will be displayed based on peakLevel rather than value.
		val - A Float between 0 and 1.
		
		(
		w = Window.new.front;
		a = SCLevelIndicator(w, Rect(10, 10, 20, 160));
		a.value = 0.5;
		)
		a.warning = 0.6; a.critical = 0.9;
		a.value = 0.7;


	critical_ (val)
	
		Styles 0 and 2 (see below) implement a critical display. If critical is > warning the view will turn red if value is >= to val. If critical is <= warning the view will turn yellow if value is <= to val. If drawsPeak is true critical will be displayed based on peakLevel rather than value.
		val - A Float between 0 and 1.
		
		(
		w = Window.new.front;
		a = SCLevelIndicator(w, Rect(10, 10, 20, 160));
		a.style = 2;
		a.numSteps = 10;
		a.value = 0.5;
		)
		a.warning = 0.6; a.critical = 0.9;
		a.value = 1;


	style_ (val)
	
		Sets the style of the view
		val - An Integer from 0 to 3. 0 = colored bar; 1 = graduated black lines; 2 = LED style (see numSteps_); 3 = LED style with custom image (see image_).
		
		(
		w = Window.new.front;
		w.addFlowLayout;
		4.do({|i|
			a = SCLevelIndicator(w, Rect(0, 0, 20, 200));
			a.style = i;
			a.numSteps = 10;
			a.value = 0.5;
		});
		)


	numSteps_ (val)
	
		The number of steps used in styles 2 and 3. (See style_)
		val - A positive Integer.
		
		(
		w = Window.new.front;
		a = SCLevelIndicator(w, Rect(10, 10, 200, 20));
		a.style = 2;
		a.value = 1;
		)
		a.numSteps = 10;
		a.numSteps = 20;


	image_ (image)
	
		Sets the image used in style 3. See below for an example.
		image - An SCImage. The default image is the SC cube.


	numTicks_ (ticks)
	
		The number of ticks to display in the view's scale.
		ticks - An Integer >= 0.
		
		(
		w = Window.new.front;
		w.view.background = Color.black;
		a = SCLevelIndicator(w, Rect(10, 10, 300, 30));
		a.numTicks = 11;
		a.value = 0.5;
		)


	numMajorTicks_ (ticks)
	
		The number of ticks in the view's scale which will be larger.
		ticks - An Integer >= 0.
		
		(
		w = Window.new.front;
		w.view.background = Color.black;
		a = SCLevelIndicator(w, Rect(10, 10, 300, 30));
		a.numTicks = 11;
		a.numMajorTicks = 3;
		a.value = 0.5;
		)


	drawsPeak_ (bool)
	
		Determines whether the view draws a separate peak display. This can be useful for displaying both peak and RMS values. If drawsPeak is true warning and critical (see above) will be displayed based on peakLevel rather than value in styles 0 and 2.
		bool - A Boolean. The default is false.
		
		(
		w = Window.new.front;
		a = SCLevelIndicator(w, Rect(10, 10, 300, 30));
		a.drawsPeak = true;
		a.style = 1;
		a.value = 0.5;
		a.peakLevel = 0.6;
		)


	peakLevel_ (val)
	
		Sets the level of the peak display. (See drawsPeak_)
		val - A Float between 0 and 1.
		
		(
		w = Window.new.front;
		a = SCLevelIndicator(w, Rect(10, 10, 20, 160));
		a.drawsPeak = true;
		a.peakLevel = 0.6)
		)


Examples


s.boot;

// something to meter
(
b = Buffer.read(s, "sounds/a11wlk01.wav");	
x = { var colum, noise, imp, delimp, mul = 1;
	imp = Impulse.kr(10);
	delimp = Delay1.kr(imp);
	colum = PlayBuf.ar(1, b, BufRateScale.kr(b), loop: 1) * mul;
	// measure rms and Peak
	SendReply.kr(imp, '/levels', [Amplitude.kr(colum), K2A.ar(Peak.ar(colum, delimp).lag(0, 3))]);
	colum;
}.play;
)

// a window and responder
// default style is coloured / solid
(
w = Window.new.front;
a = SCLevelIndicator(w, Rect(10, 10, 20, 160));
o = OSCresponder(s.addr, '/levels', {arg time, resp, msg;
	{
		a.value = msg[3].ampdb.linlin(-40, 0, 0, 1);
		a.peakLevel = msg[4].ampdb.linlin(-40, 0, 0, 1);
	}.defer;
}).add;
w.onClose = {o.remove; x.free};
)

// styles 0 and 2 support warning and critical levels
(
a.warning = -6.dbamp;
a.critical = -3.dbamp;
)

// optionally show peak level
(
a.warning = 0;
a.critical = 0;
a.drawsPeak = true;
)

// style 1 is black bars
a.style = 1

// looks good with a background
a.background = Gradient(Color.red, Color.green, \v);

// all styles can have ticks
(
a.background = Color.clear;
a.numTicks = 11; // includes 0;
a.numMajorTicks = 3;	
)

// style 2 is LED
(
a.drawsPeak = false;
a.style = 2;
a.numSteps = 10;
a.numTicks = 0;
)

// style 3 is as 2, but with images
a.style = 3; // use default image

// make a custom image
(
j = SCImage.new(20,20);
j.draw({ arg image;
var lozenge;
lozenge = Rect(3, 3, 16, 16);
Pen.addOval(lozenge);
Pen.fillAxialGradient(1@1, 19@19, Color.new255(255, 165, 0), Color.new255(238, 232, 170));
Pen.width = 1;
Pen.strokeColor = Color.blue;
Pen.strokeOval(lozenge);
});
a.image = j;
)

// be inspired
j = SCImage.openURL("http://tinyurl.com/7lj55f");

(
a.bounds = Rect(10, 10, 380, 80);
a.numSteps = 5;
a.image = j;
)



