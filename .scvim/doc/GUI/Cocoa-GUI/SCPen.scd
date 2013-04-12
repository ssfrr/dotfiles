SCPen				draw on a SCWindow

Inherits from: Object

A class which allows you to draw on a SCWindow. It has no instance methods.

The following methods must be called within an SCWindow-drawHook or a SCUserView-drawFunc function, and will only be visible once the window or the view is refreshed. Each call to SCWindow-refresh SCUserView-refresh will 'overwrite' all previous drawing by executing the currently defined function.

SCPen is returned by Pen when CocoaGUI is in use. The examples below use the ViewRedirect subclass, Pen.

See also: SCWindow, SCUserView, Color, and String

Drawing Methods

The following methods define paths. You will need to call *stroke or *fill to actually draw them.

	*moveTo (point)
		Move the Pen to point. point is an instance of Point.
		
	*lineTo (point)
		Draw a line (define a path) from the current position to point. point is an instance of Point.
 
	*line (p1, p2)
		Draw a line (define a path) from p1 to p2. Current position will be p2. p1 and p2 are instances of Point.

	*curveTo(point, cpoint1, cpoint2)
		draws a cubic bezier curve from the current position to point. 
		cpoint1, cpoint2 are control points determining the curve's curvature.
		point, cpoint1 and cpoint2 are instances of Point.

	*quadCurveTo(point, cpoint1)
		draws a quad bezier curve from the current position to point. 
		cpoint1 is a control point determining the curve's curvature.
		point, cpoint1 are instances of Point.

	*arcTo(point1, point2, radius)
		draws an arc of a circle using a radius and tangent points.
		point1 is the end point of the first tangent line. Its start point is the current position.
		point2 is the end point of the second tangent line. Its start point is point1.
		radius is the radius of the arc.
		point1, point2 are instances of Point.
		
		(
		var w = Window("arcTo", Rect(100, 200, 300, 300)).front;
		var r= 15;
		w.drawHook = { |v|	
			Pen.fillColor = Color.blue;
			Pen.strokeColor = Color.red;
			Pen.moveTo(150@150);
			Pen.arcTo(200@150, 200@225, r);
			Pen.arcTo(200@225, 100@225, r);
			Pen.arcTo(100@225, 100@150, r);
			Pen.arcTo(100@150, 150@150, r);
			Pen.lineTo(150@150);
			Pen.fillStroke;
		};
		)

	*addArc(center, radius, startAngle, arcAngle)
		Draw an arc around the [Point] center, at radius number of pixels. startAngle and arcAngle refer to the starting angle and the extent of the arc, and are in radians [0..2pi].
		(
		w = Window.new.front;
		w.view.background_(Color.white);
		w.drawHook = {
			Pen.translate(100, 100);
			10.do{
				// set the Color
				Pen.color = Color.red(rrand(0.0, 1), rrand(0.0, 0.5));
				Pen.addArc((100.rand)@(100.rand), rrand(10, 100), 2pi.rand, pi);
				Pen.perform([\stroke, \fill].choose);
			}
		};
		w.refresh;
		)

	*addWedge(center, radius, startAngle, arcAngle)
		Draw a wedge around the [Point] center, at radius number of pixels. startAngle and arcAngle refer to the starting angle and the extent of the arc, and are in radians [0..2pi].
		
		(
		w = Window.new.front;
		w.view.background_(Color.white);
		w.drawHook = {
			Pen.translate(100, 100);
			10.do{
				// set the Color
				Pen.color = Color.blue(rrand(0.0, 1), rrand(0.0, 0.5));
				Pen.addWedge((100.rand)@(100.rand), rrand(10, 100), 2pi.rand, 2pi.rand);
				Pen.perform([\stroke, \fill].choose);
			}
		};
		w.refresh;
		)

	*addAnnularWedge (center, innerRadius, outerRadius, startAngle, arcAngle)
		Draw an annular wedge around the [Point] center, from innerRadius to outerRadius in pixels. startAngle and arcAngle refer to the starting angle and the extent of the arc, and are in radians [0..2pi].
		
		(
		w = Window.new.front;
		w.view.background_(Color.white);
		w.drawHook = {
			Pen.translate(100, 100);
			1000.do{
				// set the Color
				Pen.color = Color.green(rrand(0.0, 1), rrand(0.0, 0.5));
				Pen.addAnnularWedge(
					(100.rand)@(100.rand), 
					rrand(10, 50), 
					rrand(51, 100), 	
					2pi.rand, 
					2pi.rand
				);
				Pen.perform([\stroke, \fill].choose);
			}
		};
		w.refresh;
		)

	*addRect(rect)
		adds a rectangle to the drawing; 
		
		(
		w = Window.new.front;
		w.dump;
		w.view.background_(Color.white);
		w.drawHook = {
			80.do{
				// set the Color
				Pen.color = Color.green(rrand(0.0, 1), rrand(0.0, 0.5));
				Pen.addRect(
					Rect(20, 20, (w.bounds.width-40).rand, (w.bounds.height-40).rand)
				);
				Pen.perform([\stroke, \fill].choose);
			}
		};
		w.refresh;
		)

	*stroke
		outline the previous defined path.
		
		(
		w = Window.new.front;
		w.view.background_(Color.white);
		w.drawHook = {
			// set the Color
			Pen.strokeColor = Color.red;
			Pen.moveTo(200@100);
			
			Pen.lineTo(250@200);
			Pen.lineTo(300@200);
			Pen.lineTo(200@250);
			Pen.lineTo(100@200);
			Pen.lineTo(150@200);
			Pen.lineTo(200@100);

			Pen.stroke
		};
		w.refresh;
		)
		
	*fill
		fill the previous defined path. 
		
		(
		w = Window.new.front;
		w.view.background_(Color.white);
		w.drawHook = {
			// set the Color
			Pen.fillColor = Color.red;
			Pen.moveTo(200@100);

			Pen.lineTo(250@200);
			Pen.lineTo(300@200);
			Pen.lineTo(200@250);
			Pen.lineTo(100@200);
			Pen.lineTo(150@200);
			Pen.lineTo(200@100);

			Pen.fill
		};
		w.refresh;
		)
	*draw(option)
		draw the previous defined path using any of the following options:
		0 = fill
		1 = fill using even-odd rule
		2 = stroke
		3 = fill and stroke the current path		 
		4 = fill and stroke using even-odd rule
		
		(
		w = Window.new.front;
		w.view.background_(Color.white);
		w.drawHook = {
			// set the Color
			Pen.fillColor = Color.red;
			Pen.moveTo(200@100);

			Pen.lineTo(250@200);
			Pen.lineTo(300@200);
			Pen.lineTo(200@250);
			Pen.lineTo(100@200);
			Pen.lineTo(150@200);
			Pen.lineTo(200@100);

			Pen.draw(4); // fill and then stroke
		};
		w.refresh;
		)
	*fillStroke
		fill and stroke the current path	(shortcut to the draw(3) method)
		(
		w = Window.new.front;
		w.view.background_(Color.white);
		w.drawHook = {
			// set the Color
			Pen.fillColor = Color.red;
			Pen.moveTo(200@100);

			Pen.lineTo(250@200);
			Pen.lineTo(300@200);
			Pen.lineTo(200@250);
			Pen.lineTo(100@200);
			Pen.lineTo(150@200);
			Pen.lineTo(200@100);

			Pen.fillStroke;
		};
		w.refresh;
		)
		
These methods do require separate calls to *stroke or *fill.
		
	*strokeRect(rect)
		Strokes a rectangle into the window. rect is an instance of Rect.
		(
		w = Window("strokeRect", Rect(128, 64, 360, 360));
		w.drawHook = {
			var r;
			r = Rect(100, 100, 160, 80);
			Pen.strokeColor = Color.black.alpha_(0.8);
			Pen.strokeRect(r);
		};
		w.front;
		)

	*fillRect(rect)
		Draws a filled rectangle into the window. rect is an instance of Rect.
	
	*addOval(rect)
		Adds an Oval shape to the current path. rect is an instance of Rect.
		
	*strokeOval(rect)
		Strokes an oval into the window. rect is an instance of Rect.
		(
		w = Window("strokeOval", Rect(128, 64, 360, 360));
		w.drawHook = {
			var r;
			r = Rect(100, 100, 160, 80);
			Pen.strokeColor = Color.black.alpha_(0.8);
			Pen.strokeOval(r);
		};
		w.front;
		)

	*fillOval(rect)
		Draws a filled oval into the window. rect is an instance of Rect.
	
	*fillAxialGradient(startPoint, endPoint, startColor, endColor)
		Draws an Axial gradient.
		(
		w = Window.new.front;
		w.drawHook = {
			// fill the gradient
			Pen.addRect(w.view.bounds.insetBy(30));
			Pen.fillAxialGradient(w.view.bounds.leftTop, w.view.bounds.rightBottom, Color.rand, Color.rand);
		};
		w.refresh;
		)
		
	*fillRadialGradient(innerCircleCenter, outerCircleCenter, startRadius, endRadius, startColor, endColor)
		Draws a Radial gradient.
	
		(
		w = Window.new.front;
		w.drawHook = {
			// fill the gradient
			Pen.addOval(w.view.bounds.insetBy(30));
			Pen.fillRadialGradient(w.view.bounds.center, 
				w.view.bounds.center, 0, w.bounds.width, Color.rand, Color.rand);
		};
		w.refresh;
		)
		
//	*drawAquaButton(rect, type=0, down=false, on=false)

Graphics State Methods

The following commands transform the graphics state, i.e. they effect all subsequent drawing commands. These transformations are cumulative, i.e. each command applies to the previous graphics state, not the original one.

	*translate(x=0, y=0)
		translate the coordinate system to have its origin moved by x,y
		(
		w = Window.new.front;
		w.view.background_(Color.white);
		w.drawHook = {
			// set the Color
			Pen.strokeColor = Color.blue;
			Pen.translate(200,100);
			
			// 0@0 is now 200@100
			Pen.moveTo(0@0);

			Pen.lineTo(50@100);
			Pen.lineTo(100@100);
			Pen.lineTo(0@150);
			Pen.lineTo(-100@100);
			Pen.lineTo(-50@100);
			Pen.lineTo(0@0);

			Pen.stroke
		};
		w.refresh;
		)
		
		// cumulative translations		
		(
		w = Window.new.front;
		w.view.background_(Color.clear);
		w.drawHook = {
			// set the Color
			Pen.strokeColor = Color.black;
			// draw 35 lines
			35.do {
				Pen.moveTo(0@0);
				Pen.lineTo(50@350);
				// shift 10 to the right every time
				Pen.translate(10, 0);
				Pen.stroke
			}
		};
		w.refresh;
		)

	*scale (x=0, y=0)
		Scales subsequent drawing. x and y are scaling factors (i.e. 1 is normal, 2 is double size, etc.).
		(
		w = Window.new.front;
		w.view.background_(Color.white);
		w.drawHook = {
			// set the Color
			Pen.strokeColor = Color.green;
			Pen.translate(200,100);
			Pen.scale(0.5, 2);
			// you have to set a starting point...
			Pen.moveTo(0@0);

			Pen.lineTo(50@100);
			Pen.lineTo(100@100);
			Pen.lineTo(0@150);
			Pen.lineTo(-100@100);
			Pen.lineTo(-50@100);
			Pen.lineTo(0@0);

			Pen.stroke
		};
		w.refresh;
		)

	*skew (x=0, y=0)
		Skews subsequent drawing. x and y are skewing factors (i.e. 1 is normal).
		(
		w = Window.new.front;
		w.view.background_(Color.white);
		w.drawHook = {
			// set the Color
			Pen.fillColor = Color.green(0.5, 0.8);
			Pen.translate(200,100);
			Pen.skew(0.5, 0.2);
			// you have to set a starting point...
			Pen.moveTo(0@0);

			Pen.lineTo(50@100);
			Pen.lineTo(100@100);
			Pen.lineTo(0@150);
			Pen.lineTo(-100@100);
			Pen.lineTo(-50@100);
			Pen.lineTo(0@0);

			Pen.fill
		};
		w.refresh;
		)

	*rotate (angle=0, x=0, y=0)
		Rotates subsequent drawing around the Point x@y by the amount angle in radians [0..2pi].
		(
		w = Window.new.front;
		w.view.background_(Color.white);
		c = 0;
		w.drawHook = {
			Pen.translate(220, 200);
			
			10.do({
				Pen.translate(0,10);
				// set the Color for all "real" drawing
				Pen.fillColor = Color.hsv(c.fold(0, 1), 1, 1, 0.5);
				
				// you have to set a starting point...
				Pen.moveTo(0@0);
	
				Pen.lineTo(50@100);
				Pen.lineTo(100@100);
				Pen.lineTo(0@150);
				Pen.lineTo(-100@100);
				Pen.lineTo(-50@100);
				Pen.lineTo(0@0);
	
				Pen.fill;
				Pen.rotate(0.2pi);
				
				c = c + 0.1;
			});
		};
		w.refresh;
		)

	*matrix_ (array)
		transforms coordinate system.
		array = [a, b, c, d, x, y]
			a	zoomX
			b	shearingY
			c	shearingX
			d	zoomY
			x	translateX
			y	translateY
		(
		var controlWindow, w;
		var r, a, b, c, d, matrix = [1, 0, 0, 1, 10, 10];
		var sliders, spex, name;
	
		w = Window.new.front;
		w.view.background_(Color.white);
		
		// create a controller-window 
		controlWindow = Window("matrix controls", Rect(400,200,350,120));
		controlWindow.front;
	
		// determine the rectangle to be drawn
		r = Rect.fromPoints(a = 0 @ 0, c = 180 @ 180);
		b = r.leftBottom;
		d = r.rightTop;
	
		// the drawHook
		w.drawHook = {
			Pen.strokeColor = Color.red;
		    	Pen.matrix = matrix;
		    	Pen.width = 5;
		    	Pen.strokeRect(r);
		    	Pen.strokeOval(r);
			Pen.color = Color.blue;
		    	Pen.width = 0.1;
		    	Pen.line(a, c);
		    	Pen.line(b, d);
		    	Pen.stroke;
		   
		    Pen.font = Font( "Helvetica-Bold", 12 );
		    Pen.stringAtPoint( "A", a - 6 );
		    Pen.stringAtPoint( "B", b - 6 );
		    Pen.stringAtPoint( "C", c - (0@6) );
		    Pen.stringAtPoint( "D", d - (0@6) );
		   
		    Pen.font = Font( "Helvetica", 10 );
		    Pen.stringInRect( "a matrix test", r.moveBy( 50, 50 ));
		};
	
		controlWindow.view.decorator = sliders = FlowLayout(controlWindow.view.bounds);
		spex = [
			[0, 2.0].asSpec,
			[0, 2.0].asSpec,
			[0, 2.0].asSpec,
			[0, 2.0].asSpec,
			[0, 200.0].asSpec,
			[0, 200.0].asSpec
		];
		name = #[zoomX, shearingY, shearingX, zoomY, translateX, translateY];
		6.do { |i|
		    EZSlider(controlWindow, 300 @ 14, name[i], spex[i], { |ez| var val;
		            val = ez.value;
		            [i, val.round(10e-4)].postln;
		            matrix.put(i, val);
		            w.refresh; // reevaluate drawHook function
		  	}, matrix[i]);
		  	sliders.nextLine;
		};
		w.refresh;
	)


	*width_(width=1)
		sets the width of the Pen for the whole stroke
		(
		w = Window.new.front;
		w.view.background_(Color.white);
		w.drawHook = {
			// set the Color
			Pen.strokeColor = Color.blue(0.5, 0.5);
			Pen.translate(200,100);
			Pen.width = 10;
			// you have to set a starting point...
			Pen.moveTo(0@0);

			Pen.lineTo(50@100);
			Pen.lineTo(100@100);
			Pen.lineTo(0@150);
			Pen.lineTo(-100@100);
			Pen.lineTo(-50@100);
			Pen.lineTo(0@0);

			Pen.stroke
		};
		w.refresh;
		)

	*use (function)
		Draw function, and then revert to the previous graphics state. This allows you to make complex transformations of the graphics state without having to explicitly revert to get back to 'normal'.
		(
		// modified by an example of Stefan Wittwer
		w = Window.new.front;
		w.view.background_(Color.white);
		w.drawHook = {
			//paint origin
			Pen.fillColor = Color.gray(0, 0.5);
			Pen.addArc(0@0, 20, 0, 2pi);
			Pen.fill;
			Pen.width = 10;

			Pen.use { // draw something complex...
				Pen.width = 0.5;
				Pen.translate(100,100);
				Pen.fillColor = Color.blue;
				Pen.addArc(0@0, 10, 0, 2pi);
				Pen.fill;
				20.do{
					Pen.moveTo(0@0);
					Pen.lineTo(100@0);
					Pen.strokeColor = Color.red(0.8, rrand(0.7, 1));
					Pen.stroke;
					Pen.skew(0, 0.1);
				};
			};
			
			// now go on with all params as before
			// translation, skewing, width, and color modifications do not apply
			Pen.line(10@120, 300@120);
			Pen.stroke;
		};
		w.refresh
		)

	*path(function)
		make a path, consisting of the drawing made in function.
		Unfortunately not working for now... 
		(there's no Meta_SCPen-endPath which currently is used in this method)
		
	*beginPath
		Discard any previous path.
		
		// incomplete arrow
		(
		w = Window.new.front;
		w.view.background_(Color.white);
		w.drawHook = {
			// set the Color
			Pen.strokeColor = Color.blue;
			Pen.translate(200,100);
			Pen.moveTo(0@0);

			Pen.lineTo(50@100);
			Pen.lineTo(100@100);
			
			// forget what we just drew
			Pen.beginPath;
			Pen.moveTo(100@100);
			Pen.lineTo(0@150);
			Pen.lineTo(-100@100);
			Pen.lineTo(-50@100);
			Pen.lineTo(0@0);

			Pen.stroke
		};
		w.refresh;
		)
	
	*beginTransparencyLayer
		Begins a new transparency layer. Transparency layers are useful when you want to apply an effect to a group of objects or create a composite graphic.
		
		(
		w = Window.new("Transparency Layer test", Rect(400,400,430,450)).front;
		w.drawHook = {
			
			Color.blue.setStroke;
			
			Pen.use {
			Pen.setShadow(2@2, 10, Color.black);
			Pen.beginTransparencyLayer;
			
			Color.red.setFill;
			Pen.addOval(Rect(20,40,100,100));
			Pen.fill;
			
			Color.green.setFill;
			Pen.addOval(Rect(30,70,100,100));
			Pen.fill;
			
			Color.blue.setFill;
			Pen.addOval(Rect(60,40,100,100));
			Pen.fill;
			
			"With Transparency Layer".drawCenteredIn(Rect(30, 40, 100, 100), Font.default, Color.white);
			Pen.endTransparencyLayer;
			};
			
			Pen.use {
			Pen.translate(200, 0);
			Pen.setShadow(2@2, 10, Color.black);
			
			
			Color.red.setFill;
			Pen.addOval(Rect(20,40,100,100));
			Pen.fill;
			
			Color.green.setFill;
			Pen.addOval(Rect(30,70,100,100));
			Pen.fill;
			
			Color.blue.setFill;
			Pen.addOval(Rect(60,40,100,100));
			Pen.fill;
			
			"Without Transparency Layer".drawCenteredIn(Rect(30, 40, 100, 100), Font.default, Color.white);
			};
			
			Pen.use {
				Pen.translate(0, 200);
				Pen.setShadow(2@2, 10, Color.black);
				Pen.beginTransparencyLayer;
				
				Pen.push;
				Pen.addOval(Rect(20,40,170,170));
				Pen.fillAxialGradient(w.view.bounds.leftTop, w.view.bounds.rightBottom, Color.rand, Color.rand);
				Pen.pop;
				
				"With Transparency Layer".drawCenteredIn(Rect(20,40,170,170), Font.default, Color.white);
				
				Pen.endTransparencyLayer;
			};
			
			Pen.use {
				Pen.translate(200, 200);
				Pen.setShadow(2@2, 10, Color.black);
				Pen.addOval(Rect(20,40,170,170));
				Pen.fillAxialGradient(w.view.bounds.leftTop, w.view.bounds.rightBottom, Color.rand, Color.rand);
				
				"Without Transparency Layer".drawCenteredIn(Rect(20,40,170,170), Font.default, Color.white);
			};
			
		};
		w.refresh;
		)
	
	*endTransparencyLayer
		Ends the current transparency layer.
		
	*clip
		Use the previously defined path as a clipping path.
		(
		w = Window.new.front;
		w.view.background_(Color.white);
		w.drawHook = {
	      	// outline the clipping path
			Pen.moveTo(110@110);
			Pen.lineTo(290@110);
			Pen.lineTo(290@240);
			Pen.lineTo(110@240);
			Pen.lineTo(110@110);
			// now clip
			Pen.clip;
			
			// everything else we draw is now clipped
			Pen.fillColor = Color.yellow;
			Pen.fillRect(Rect(0,0,400,400));
			Pen.fillColor = Color.red;
			Pen.moveTo(200@100);
			
			Pen.lineTo(250@200);
			Pen.lineTo(300@200);
			Pen.lineTo(200@250);
			Pen.lineTo(100@200);
			Pen.lineTo(150@200);
			
			Pen.fill;
		};
		w.refresh;
		)
		
	*smoothing_(flag)
		turns on/off anti-aliasing.
		
		(
		var w = Window("smoothing", Rect(100, 200, 500, 300)).front;
		w.view.background_(Color.white);
		w.drawHook = { |v|
			Pen.strokeColor = Color.grey(0.25);
			Pen.smoothing_(false);		//no anti-aliasing
			50.do{|i|
				Pen.moveTo(50@50.rrand(250));
				Pen.lineTo(250@50.rrand(250));
			};
			Pen.stroke;
			Pen.smoothing_(true);		//anti-aliasing (default)
			50.do{|i|
				Pen.moveTo(250@50.rrand(250));
				Pen.lineTo(450@50.rrand(250));
			};
			Pen.stroke;
		};
		)
		
	*setShadow(offsetPoint, blur, color)
		will fill the current path with a shadow.
		you should use this option between Pen.push / Pen.pop (or Pen.use)
		
	*joinStyle_(option)
		set the lines joining style according to the defined options:
		0 = miter
		1 = round
		2 = bevel
		
	*capStyle_(option)
		set the lines joining style according to the defined options:
		0 = butt
		1 = round
		2 = square
		
		(
		w = Window.new.front;
		w.view.background_(Color.white);
		SCStaticText(w, Rect(0,0,180,20))
		.string_(" Change Line Cap & Join Styles: ");
		y = SCPopUpMenu(w, Rect(180,0,130,20))
		.items_(["Butt - Miter", "Round - Round", "Square - Bevel"])
		.action_({w.refresh});
		w.drawHook = {
		// set the Color
		Pen.strokeColor = Color.red;
		Pen.width_(8.0);
		Pen.capStyle_(y.value);
		Pen.joinStyle_(y.value);
		
		
		Pen.moveTo(200@100);
		
		Pen.lineTo(250@200);
		Pen.lineTo(300@200);
		Pen.lineTo(200@250);
		Pen.lineTo(100@200);
		Pen.lineTo(150@200);
		Pen.lineTo(200@100);
		
		
		Pen.stroke;
		};
		w.refresh;
		)

	*alpha_(alphaValue)
		set the opacity level.
	
	*blendMode_(mode)
		set the blending mode to use.
	/*
	different blend modes:
	OS X 10.4 and > Only
	--------------------
	0 - Normal
	1 - Multiply
	2 - Screen
	3 - Overlay
	4 - Darken
	5 - Lighten
	6 - ColorDodge
	7 - ColorBurn
	8 - SoftLight
	9 - HardLight
	10 - Difference
	11 - Exclusion
	12 - Hue
	13 - Saturation
	14 - Color
	15 - Luminosity
	
	OS 10.5 and > Only
	--------------------
	16 - Clear
	17 - Copy
	18 - SourceIn
	19 - SourceOut
	20 - SourceATop
	21 - DestinationOver
	22 - DestinationIn
	23 - DestinationATop
	24 - XOR
	25 - PlusDarker
	26 - PlusLighter
	*/
	
	(
		var blendMode=0, blendString="Normal";
		w = Window.new.front;
		m = SCPopUpMenu(w, Rect(10, w.view.bounds.height - 30, 150, 20));
		m.items = [
			"0 - Normal",
			"1 - Multiply",
			"2 - Screen",
			"3 - Overlay",
			"4 - Darken",
			"5 - Lighten",
			"6 - ColorDodge",
			"7 - ColorBurn",
			"8 - SoftLight",
			"9 - HardLight",
			"10 - Difference",
			"11 - Exclusion",
			"12 - Hue",
			"13 - Saturation",
			"14 - Color",
			"15 - Luminosity"
		];
		
		m.action_({|view|
			blendMode = view.value;
			blendString = view.items.at(blendMode);
			w.refresh;
		});
		w.drawHook = {
			80.do{|i|
				Pen.use {
				Pen.blendMode_(blendMode);
				Pen.color = Color.green(0.6, 0.10);
				Pen.addRect(
					Rect(20, 20, 20 + (i*4), 20 + (i*4));
				);
				Pen.fill;
				};
			}
		};
		w.refresh;
	)
		
		
	*lineDash_(pattern)
		set the line dash pattern. 
		pattern should be a FloatArray of values that specify the lengths of the 
		painted segments and not painted segments.
		(
		var w;
		w = Window.new("Radial Gradient + line dash + cubic bezier curve example", Rect(640,630,300,300)).front;
		u = SCUserView.new(w, w.view.bounds).resize_(5);
		
		u.drawFunc = {
		
			Pen.fillRadialGradient(
				u.bounds.center,
				u.bounds.center,
				0, u.bounds.width.max(u.bounds.height),
				Color.new255(105, 130, 150, 255),
				Color.new255(57, 73, 88, 255)
			);
			Color.white.alpha_(0.2).setFill;
			Color.white.setStroke;
			Pen.lineDash_(FloatArray[3,3]);
			Pen.moveTo(u.bounds.left@(u.bounds.top + (u.bounds.height*0.5)));
			Pen.curveTo(
				u.bounds.right@(u.bounds.top + (u.bounds.height*0.5)),
				(u.bounds.left + 40)@(u.bounds.top),
				(u.bounds.right - 40)@(u.bounds.bottom)
			);
			Pen.fillStroke;
		};
		
		)

		
		
Examples

(
// simple rotating and scaling
	w = Window("Pen Rotation and Scaling", Rect(128, 64, 360, 360));
	w.drawHook = {
		Pen.use {
			// use the same rect for everything, just scale and rotate
			var r = Rect(0,0,200,80);
			Pen.fillColor = Color.black;
			// offset all subsequent co-ordinates
			Pen.translate(80,20);
			Pen.fillRect(r);
			Pen.fillColor = Color.red;
			// scale all subsequent co-ordinates
			Pen.scale(0.8, 0.8);
			Pen.translate(8,10);
			// rotate all subsequent co-ordinates
			Pen.rotate(0.1pi);
			Pen.fillRect(r);
			Pen.strokeColor = Color.blue;
			// lather, rinse, repeat
			Pen.scale(0.8, 0.8);
			Pen.rotate(0.1pi);
			Pen.width = 3;
			Pen.strokeRect(r);
			Pen.fillColor = Color.yellow(1,0.5);
			Pen.scale(0.8, 0.8);
			Pen.rotate(0.1pi);
			Pen.translate(20,-20);
			Pen.fillOval(r);
		}
	};

	w.front;
)

// redraw at random interval
// different every time
(
var w, run = true;
w = Window("my name is... panel", Rect(128, 64, 800, 800));
w.view.background = Color.white;
w.onClose = { run = false; };
w.front;
w.drawHook = {
	Pen.use {
		Pen.width = 0.2;
		400.do {
			Pen.beginPath;
			Pen.moveTo(Point(10.rand * 80 + 40, 10.rand * 80 + 40));
			Pen.lineTo(Point(10.rand * 80 + 40, 10.rand * 80 + 40));
			Pen.stroke;
		};
	};
};

{ while { run } { w.refresh; 1.0.rand.wait } }.fork(AppClock)

)

(
var w, run = true;
w = Window("my name is... panel", Rect(128, 64, 800, 500));
w.view.background = Color.white;
w.onClose = { run = false; };
w.front;
w.drawHook = {
	Pen.use {
		Pen.width = 2;
		80.do {
			Pen.width = rrand(0,4) + 0.5;
			Pen.beginPath;
			Pen.moveTo(Point(800.rand, 500.rand));
			Pen.lineTo(Point(800.rand, 500.rand));
			Pen.stroke;
		};
	};
};

{ while { run } { w.refresh; 1.0.rand.wait } }.fork(AppClock)

)

// Animation

// Uses random seed to 'store' data
// By reseting the seed each time the same random values and shapes are generated for each 'frame'
// These can then be subjected to cumulative rotation, etc., by simply incrementing the phase var.
(
// By James McCartney
var w, h = 700, v = 700, seed, run = true, phase = 0;
w = Window("wedge", Rect(40, 40, h, v), false);
w.view.background = Color.rand(0,0.3);
w.onClose = { run = false }; // stop the thread on close
w.front;
// store an initial seed value for the random generator
seed = Date.seed;
w.drawHook = {
	Pen.width = 2;
	Pen.use {
		// reset this thread's seed for a moment
		thisThread.randSeed = Date.seed;
		// now a slight chance of a new seed or background color
		if (0.006.coin) { seed = Date.seed; };
		if (0.02.coin) { w.view.background = Color.rand(0,0.3); };
		// either revert to the stored seed or set the new one
		thisThread.randSeed = seed;
		// the random values below will be the same each time if the seed has not changed
		// only the phase value has advanced
		Pen.translate(h/2, v/2);
		// rotate the whole image
		// negative random values rotate one direction, positive the other
		Pen.rotate(phase * 1.0.rand2);
		// scale the rotated y axis in a sine pattern
		Pen.scale(1, 0.3 * sin(phase * 1.0.rand2 + 2pi.rand) + 0.5 );
		// create a random number of annular wedges
		rrand(6,24).do {
			Pen.color = Color.rand(0.0,1.0).alpha_(rrand(0.1,0.7));
			Pen.beginPath;
			Pen.addAnnularWedge(Point(0,0), a = rrand(60,300), a + 50.rand2, 2pi.rand 
				+ (phase * 2.0.rand2), 2pi.rand);
			if (0.5.coin) {Pen.stroke}{Pen.fill};
		};
	};
};

// fork a thread to update 20 times a second, and advance the phase each time
{ while { run } { w.refresh; 0.05.wait; phase = phase + 0.01pi;} }.fork(AppClock)

)

(
var w, phase = 0, seed = Date.seed, run = true;
w = Window("my name is... panel", Rect(128, 64, 800, 800));
w.view.background = Color.blue(0.4);
w.onClose = { run = false; };
w.front;
w.drawHook = {
	Pen.use {
		if (0.02.coin) { seed = Date.seed; };
		thisThread.randSeed = seed;
		Pen.strokeColor = Color.white;
		200.do {
			var a = 4.rand;
			var b = 24.rand;
			var r1 = 230 + (50 * a);
			var a1 = 2pi / 24 * b + phase;
			var r2 = 230 + (50 * (a + 1.rand2).fold(0,3));
			var a2 = 2pi / 24 * (b + (3.rand2)).wrap(0,23) + phase;
			Pen.width = 0.2 + 1.0.linrand;
			Pen.beginPath;
			Pen.moveTo(Polar(r1, a1).asPoint + Point(400,400));
			Pen.lineTo(Polar(r2, a2).asPoint + Point(400,400));
			Pen.stroke;
		};
		thisThread.randSeed = Date.seed;
		40.do {
			var a = 4.rand;
			var b = 24.rand;
			var r1 = 230 + (50 * a);
			var a1 = 2pi / 24 * b + phase;
			var r2 = 230 + (50 * (a + 1.rand2).fold(0,3));
			var a2 = 2pi / 24 * (b + (3.rand2)).wrap(0,23) + phase;
			Pen.width = 0.2 + 1.5.linrand;
			Pen.beginPath;
			Pen.moveTo(Polar(r1, a1).asPoint + Point(400,400));
			Pen.lineTo(Polar(r2, a2).asPoint + Point(400,400));
			Pen.stroke;
		};
	};
};

{ while { run } { w.refresh; 0.1.wait; phase = phase + (2pi/(20*24)) } }.fork(AppClock)

)


(
var w, h = 800, v = 600, seed = Date.seed, phase = 0, zoom = 0.7, zoomf = 1, run = true;
w = Window("affines", Rect(40, 40, h, v));
w.view.background = Color.blue(0.4);
w.onClose = { run = false };
w.front;
w.drawHook = {
	thisThread.randSeed = Date.seed;
	if (0.0125.coin) { seed = Date.seed; phase = 0; zoom = 0.7; zoomf = exprand(1/1.01, 1.01); }
	{ phase = phase + (2pi/80); zoom = zoom * zoomf; };
	thisThread.randSeed = seed;
	Pen.use {
		var p1 = Point(20.rand2 + (h/2), 20.rand2 + (v/2));
		var p2 = Point(20.rand2 + (h/2), 20.rand2 + (v/2));
		var xscales = { exprand(2** -0.1, 2**0.1) } ! 2;
		var yscales = { exprand(2** -0.1, 2**0.1) } ! 2;
		var xlates = { 8.rand2 } ! 2;
		var ylates = { 8.rand2 } ! 2;
		var rots = { 2pi.rand + phase } ! 2;
		var xform;
		xscales = (xscales ++ (1/xscales)) * 1;
		yscales = (yscales ++ (1/yscales)) * 1;
		xlates = xlates ++ xlates.neg;
		ylates = ylates ++ xlates.neg;
		rots = rots ++ rots.neg;
		xform = {|i| [xlates[i], ylates[i], rots[i], xscales[i], yscales[i]] } ! 4;
		Pen.strokeColor = Color.grey(1,0.5);
		Pen.width = 8.linrand + 1;
		Pen.translate(400, 400);
		Pen.scale(zoom, zoom);
		Pen.translate(-400, -400);
		1200.do {
			var p, rot, xlate, ylate, xscale, yscale;
			Pen.width = 8.linrand + 1;
			Pen.beginPath;
			#rot, xlate, ylate, xscale, yscale = xform.choose;
			Pen.translate(xlate, ylate);
			Pen.rotate(rot, h/2, v/2);
			Pen.scale(xscale, yscale);
				Pen.moveTo(p1);
				Pen.lineTo(p2);
			Pen.stroke;
		};
	};
};

{ while { run } { w.refresh; 0.05.wait; } }.fork(AppClock)

)



