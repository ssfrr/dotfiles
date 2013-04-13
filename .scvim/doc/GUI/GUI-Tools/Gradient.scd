Gradient			a linear color fade between two colors

Inherits from: Object

See also: Color, HiliteGradient

Creation / Class Methods

	*new (color1, color2, direction, steps)
	
		color1 - An instance of Color.
		color2 - An instance of Color.
		direction - \h or \v for horizontal and vertical respectively. Default value is \h.
		steps - The resolution of the gradient. Default value is 64.

Instance Methods

	at(pos)
		Retrieve the colour at position pos, typically a value between zero and one.
		at(0) is color1, and at(1) is color2.
		

Examples

// basic usage
(
w = Window.new.front;
w.view.background = Gradient(Color.yellow,Color.white);
)

// change direction and resolution
(
w = Window.new.front;
w.view.background = Gradient(Color.red,Color.white,\v, 5);
)

// almost unnoticeable variations can be pleasant
(
w = Window.new.front;
v = CompositeView(w, Rect(50,50,300,300));
c = Color.rand;
d = c.vary(0.15);
v.background = Gradient(c, d, \v);
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
	k.background = Gradient(c1, c2, \v) 
};
f.value; g.value;
k.action = g;
k.mouseUpAction = { [c1, c2].postln };
k.keyDownAction = f; // hit any key for new color
)

// an example using gradient indirectly to update window colour
(
w=Window.new.front;
g = Gradient(Color.red,Color.green);
Task{
	(0, 0.01 .. 1).do{|pos|
		w.view.background = g.at(pos);
		0.01.wait;
	};
}.play(AppClock)
)


