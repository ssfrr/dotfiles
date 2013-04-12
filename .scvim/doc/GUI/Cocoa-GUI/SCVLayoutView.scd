SCVLayoutView			a container that automatically places widgets in a column

Inherits from: Object : SCView : SCContainerView : SCLayoutView

SCVLayoutView automatically arranges its sub-views in vertical order, expanding their width to the bounds of the SCVLayoutView. Only the bounds.height of the sub-view is relevant. Its abstract superclass, SCLayoutView, provides some important formatting methods.

See also: SCHLayoutView, SCCompositeView

Some Important Issues Regarding SCVLayoutView

SCVLayoutView is designed mainly for grouping and placing widgets. While you can set it to accept key strokes, it does not itself accept mouse clicks or drags.

SCVLayoutView responds to the minHeight and maxHeight properties in its child views. This is useful when resize is set to 4, 5, or 6. See examples below.

Creation / Class Methods

	*new (parent, bounds)
	
		parent - The parent view.
		bounds - An instance of Rect, or a Point indicating width@height.

		(
		w = Window.new;
		v = VLayoutView(w, Rect(10,10,300,300) );
		Array.fill( 10, { arg i;
			Slider( v, Rect(0,0,75,20) ).value_(i / 10)
		});
		w.front
		)
	
Examples

(
q = 10;
w = Window.new;

v = VLayoutView(w,Rect(10,10,300,300));

Array.fill(q,{ arg i;
	Slider(v,Rect(0,0,75,20)).value_(i / q)
});

w.front
)

// show the area of the view.
v.background_(Color.rand) // The sliders automatically expand to the optimal width



// Stretching the layout view. Slider height is fixed.
(
q = 10;
w = Window.new;

v = VLayoutView(w,Rect(10,10,300,300));
v.background_(Color.rand);
v.resize = 5; // elastic
Array.fill(q,{ arg i;
	var s;
	s = Slider(v,Rect(0,0,55,20));// The bounds.width are irrelevant here. They expand to the optimal width
	s.value = i / q;
	s
});
StaticText(v, Rect(0,0,55,20)).background_(Color.rand).string_("Some Example Text").align_(\center);
w.front
)


// Stretching the layout view and the contents.
// If all the contents are elastic, the heights of the contents are perfectly divided up.
// in this example, the StaticText is not elastic in order to preserv its height.
(
q = 10;
w = Window.new;

v = VLayoutView(w,Rect(10,10,300,300));
v.background_(Color.rand);
v.resize = 5; // elastic
Array.fill(q,{ arg i;
	var s;
	s = Slider(v,Rect(0,0,75,20));
	s.resize = 5; // elastic
	s.value = i / q;
	s
});
StaticText(v, Rect(0,0,55,40))
	.background_(Color.rand).string_("Some Example Text")
	.align_(\center);

w.front
)


// Mixed stretching modes
(
q = 5;
w = Window.new;

v = VLayoutView(w,Rect(10,10,300,300));
v.resize = 5; // elastic
v.background_(Color.grey);
Array.fill(q,{ arg i;
	var s;
	s = Slider(v,Rect(0,0,75,20)).background_(Color.rand);
	s.value = i / 5;
	if(i < 2,{
		s.resize = 5; // some elastic
		s.setProperty(\minHeight,20);
	},{
		s.resize = 1; // some not elastic
	});
	s
});
StaticText(v, Rect(0,0,55,20)).background_(Color.rand).string_("Some Example Text").align_(\center);

w.front
)


// Set minimum heights
// beware that if the layout view height is smaller than the combined height of all the contents,
// things might disappear when you try to handle them with the mouse:
(
q = 5;
w = Window.new;

v = VLayoutView(w,Rect(10,10,300,300));
v.resize = 5; // elastic
v.background_(Color.grey);
Array.fill(q,{ arg i;
	var s;
	s = Slider(v,Rect(0,0,75,20)).background_(Color.blue.alpha_(0.2));
	
	s.value = i / 5;
	s.resize = 5;
	s.setProperty(\minHeight,20);
	s.setProperty(\maxHeight,40);
	s
});
w.front
)



// Spacing
(
q = 10;
w = Window.new;

v = VLayoutView(w,Rect(10,10,300,300));
v.setProperty(\spacing,0);

Array.fill(q,{
	Slider(v,Rect(0,0,75,20))
});

w.front
)



// Nesting
// Use VLayoutView and HLayoutView in combination
(
q = 10;
w = Window.new("nesting",Rect(30,30,400,700));

v = VLayoutView(w,Rect(10,10,300,600));

v.background = Color.rand;

Array.fill(q,{ arg i;
	Slider(v,Rect(0,0,75,20)).value_(i / q)
});

StaticText(v, Rect(0,0,55,20)).background_(Color.rand).string_("Some Example Text").align_(\center);

h = HLayoutView(v,Rect(10,10,300,300));

Array.fill(q,{ arg i;
	Slider(h,Rect(0,0,20,70)).value_(i / q)
});
h.background = Color.rand;


w.front

)



