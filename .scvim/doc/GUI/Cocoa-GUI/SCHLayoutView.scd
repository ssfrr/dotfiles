SCHLayoutView			a container that automatically places widgets in rows

Inherits from: Object : SCView : SCContainerView : SCLayoutView

SCHLayoutView automatically arranges its sub-views in horizontal order, expanding their height to the bounds of the SCHLayoutView. Only the bounds.width of the sub-view is relevant. Its abstract superclass, SCLayoutView, provides some important formatting methods.

See also: SCVLayoutView, SCCompositeView

Some Important Issues Regarding SCHLayoutView

SCHLayoutView is designed mainly for grouping and placing widgets. While you can set it to accept key strokes, it does not itself accept mouse clicks or drags.

SCHLayoutView responds to the minWidth and maxWidth properties in its child views. This is useful when resize is set to 2, 5, or 8. See examples below.

Creation / Class Methods

	*new (parent, bounds)
	
		parent - The parent view.
		bounds - An instance of Rect, or a Point indicating width@height.

		(
		w = Window.new;
		v = HLayoutView(w, Rect(10,10,300,300) );
		Array.fill( 10, { arg i;
			Slider( v, Rect(0,0,20,75) ).value_(i / 10)
		});
		w.front;
		)
			
Examples

// Childview height fills the View automatically

(
q = 10;
w = Window.new;

h = HLayoutView(w,Rect(0,0,300,300));

Array.fill(q,{ arg i;
	Slider(h,Rect(0,0,20,75)).value_(i / q)
});
h.background_(Color.rand);

w.front
)



// Stretching the layout view. Slider height fills the View automatically.

(
q = 8;
w = Window.new;

h = HLayoutView(w,Rect(0,0,300,300));
h.background = Color.rand;
h.resize = 5; // elastic

Array.fill(q,{ arg i;
	var s;
	s = Slider(h,Rect(0,0,20,75)).background_(Color.grey.alpha_(0.4));
	s.value = i / q;
	s
});
StaticText(h, Rect(0,0,105,20)).background_(Color.rand).string_(" Some Example\n Text");
w.front
)

// Stretching the layout view and the contents.
// If all the contents are elastic, the widths of the contents are perfectly divided up:
// in this example, the StaticText is not elastic in order to preserv its width.

(
q = 10;
w = Window.new;

h = HLayoutView(w,Rect(0,0,300,300));
h.resize = 5; // elastic
h.background = Color.rand;

Array.fill(q,{ arg i;
	var s;
	s = Slider(h,Rect(0,0,20,75));
	s.resize = 5; // elastic
	s.value = i / q;
	s
});
StaticText(h, Rect(0,0,105,20)).background_(Color.rand).string_(" Some Example\n Text");

w.front
)


// set minWidth on contents
// beware that if the layout view width is smaller than the combined width of all the contents,
// things might disappear when you try to handle them with the mouse.

(
q = 5;
w = Window.new;

h = HLayoutView(w,Rect(0,0,300,300));
h.background = Color.rand;
h.resize = 5; // elastic

Array.fill(q,{ arg i;
	var s;
	s = Slider(h,Rect(0,0,20,75));
	s.value = i / 5;
	if(i < 2,{
		s.resize = 5; // some elastic
		s.setProperty(\minWidth,20);
	},{
		s.resize = 1; // some not elastic
	});
	s
});
StaticText(h, Rect(0,0,105,20)).background_(Color.rand).string_(" Some Example\n Text");

w.front
)

(
q = 5;
w = Window.new;

h = HLayoutView(w,Rect(0,0,300,300));
h.resize = 5; // elastic
h.background = Color.rand;
Array.fill(q,{ arg i;
	var s;
	s = Slider(h,Rect(0,0,20,75));
	
	s.value = i / 5;
	s.resize = 5;
	s.setProperty(\minWidth,20);
	s.setProperty(\maxWidth,40);
	s
});

w.front
)


// Text flows

(
q = 5;
w = Window.new;

h = HLayoutView(w,Rect(0,0,300,300));
h.resize = 5; // elastic

Array.fill(q,{ arg i;
	var s;
	s = 	StaticText(h,120@20).string_("Some short text which wraps around");

	s.resize = 5;
	s.setProperty(\minWidth,10);
	s.setProperty(\maxWidth,120);

	// not working
	s.setProperty(\maxHeight,10);
	s.setProperty(\minHeight,10);

	s.background = Color.white;
	s
});

w.front
)


// Spacing

(
q = 10;
w = Window.new;

h = HLayoutView(w,Rect(0,0,300,300));
h.setProperty(\spacing,0);

Array.fill(q,{
	Slider(h,Rect(0,0,20,75))
});

w.front
)



