HiliteGradient			a linear color fade between an outside and an inside color	

Inherits from: Object

See also: Color, Gradient

Creation / Class Methods

	*new (color1, color2, direction, steps)
	
		color1 - An instance of Color.
		color2 - An instance of Color.
		direction - \h or \v for horizontal and vertical respectively. Default value is \v.
		steps - The resolution of the gradient. Default value is 64.
		frac - The center of the gradient. Default value is 0.33, i.e. off center toward the top on a vertical gradient.

Examples

// basic usage
(
w=Window.new.front;
v=CompositeView(w, Rect(50,50,200,50));
v.background=HiliteGradient(Color.gray,Color.white);
)

// change direction and resolution
(
w=Window.new.front;
w.view.background=HiliteGradient(Color.red,Color.white,\h, 12, 0.5);
)

// almost unnoticeable variations can be pleasant
(
w = Window.new.front;
v = CompositeView(w, Rect(50,50,300,300));
c = Color.rand;
d = c.vary(0.15);
v.background = HiliteGradient(c, d, \v);
[c, d].postln
)

(
var w, k, c, d, e, c1, c2, f, g;
w = Window.new.front;
k = Slider2D(w, Rect(50,50,300,300));
f = {
	c = Color.rand;
	d = c.vary(0.5);
	e = d.vary(0.5);
};
g = { 
	c1 = d.hueBlend(e, k.y).round(0.01); 
	c2 = c.hueBlend(e, k.x).round(0.01); 
	k.background = HiliteGradient(c1, c2, \v) 
};
f.value; g.value;
k.action = g;
k.mouseUpAction = { [c1, c2].postln };
k.keyDownAction = f; // hit any key for new color
)


