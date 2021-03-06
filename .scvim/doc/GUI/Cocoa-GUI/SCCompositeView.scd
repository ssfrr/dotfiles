SCCompositeView			A view that contains other views	

Inherits from: Object : SCView : SCContainerView

A container for grouping other views and widgets. SCCompositeView inherits all of its methods from SCContainerView.

See also: FlowView, FlowLayout

Some Important Issues Regarding SCCompositeView

SCCompositeView is used for grouping widgets in a window. While it accepts key actions, it does not accept mouse clicks or drags.

Creation / Class Methods

	*new (parent, bounds)
	
		parent - The parent view.
		bounds - An instance of Rect, or a Point indicating width@height.
		
		(
		w = Window.new;
		
		c = CompositeView(w, Rect(0,0,300,300) );
		
		a = Slider2D(c, Rect(10,10,100,100) );	
		b = Slider2D(c, Rect(110,110,100,100) );
		
		w.front;
		)
			

Coordinate System

Containers use relative coordinates, i.e.  views are placed relative to the upper left corner of the container.
	
	(
	w = Window.new;
	
	c = CompositeView(w,Rect(50,0,300,300));
	a = Slider2D(c,Rect(0,0,100,100));	// actually displays at (50, 0)
	b = Slider2D(c,Rect(100,100,100,100));
	
	c.background = Color.rand;
	
	w.front;
	)
	
	c.bounds_(Rect(100,0,300,300)); // contents adust since coords are relative
	c.resize_(6); // contents adust since coords are relative

Keydown Bubbling

Key actions "bubble up" to the parent view if a view does not define one itself. In the following example, a and b do not have keyDown actions themselves, so the key event is passed to c, the parent, which defines the key down action. d's parent is the SCTopView, which has no key down action. See also SCView.

	( //Click on the different views and hit keys on the keyboard.

	w = Window.new;
	
	c = CompositeView(w,Rect(0,0,200,200)).background_(Color.grey.alpha_(0.3));
	
	a = Slider2D(c,Rect(0,0,100,100)).background_(Color.rand);	
	b = Slider2D(c,Rect(100,100,100,100)).background_(Color.rand);
	
	w.front;
	
	c.keyDownAction = {
		"keydown bubbled up to c".postln;
	};
	
	//d is on window w, not on composite view c
	d = Slider2D(w,Rect(200,200,100,100));
	d.background = Color.black;
	)
	

Decorators

A 'decorator' object can be set to handle layout management. All views added to the CompositeView will now be placed by the decorator. Currently the only one existing is FlowLayout. You can use the addFlowLayout method as a short cut to assigning FlowLayout to decorator.

	(
	a = Window.new;
	
	b = CompositeView(a,Rect(0,0,500,500));
	b.decorator = FlowLayout(b.bounds);
	// b.addFlowLayout; // you can also write this for convenience
	
	// adding views to b automatically use the decorator
	// no need to use parent.decorator.place
	c = Slider2D(b,Rect(0,0,100,100));	// size matters
	d = Slider2D(b,Rect(0,0,100,100)); // origin doesn't
	
	a.front;
	)

You can also use an empty composite view nicely as a spacer in VLayoutView, HLayoutView, or views that have a FlowLayout as their decorator.

	(
	a = Window.new;
	
	b = CompositeView(a,Rect(0,0,500,500));
	b.decorator = FlowLayout(Rect(0, 0, 500, 500));
	Slider2D(b,Rect(0,0,100,100)).background_(Color.rand);	
	CompositeView(b,Rect(0,0,70,100));				//just used for spacing
	Slider2D(b,Rect(0,0,100,100)).background_(Color.rand);
	Slider2D(b,Rect(0,0,100,100)).background_(Color.rand);
	b.decorator.nextLine;
	Slider2D(b,Rect(0,0,100,100)).background_(Color.rand);
	Slider2D(b,Rect(0,0,100,100)).background_(Color.rand);	
	CompositeView(b,Rect(0,0,70,100))				;//just used for spacing
	Slider2D(b,Rect(0,0,100,100)).background_(Color.rand);
	
	a.front;
	)


Hiding / Swapping

You can stack CompositeViews on top of each other and use a button show only one of them

	(
	var colors = [Color.blue,Color.red, Color.green];
	a = Window.new;
	q = 3;
	
	b = Button(a,Rect(0,0,160,20));
	
	b.states = Array.fill(q,{ arg i;
		[i.asString,Color.white,colors.wrapAt(i)]
	});
	
	b.action = { arg butt;
		p.visible = false;
		p = c.at(butt.value);
		p.visible = true;
	};
	
	c = Array.fill(q,{ arg i;
		b = CompositeView(a,Rect(0,25,300,300));
		b.background=colors[i].alpha_(0.2);
		b.visible=false;
		b;
	});
	
	5.do{arg i;c[0].add(Slider(c[0],Rect(10,i*30+10,150,25)).value_(1.0.rand))};
	5.do{arg i;c[1].add(Slider(c[1],Rect(i*30+10,10,25,150)).value_(1.0.rand))};
	c[2].add(Slider2D(c[2],Rect(10,10,155,150)).x_(1.0.rand).y_(1.0.rand));
	
	p = c.at(0); // previous
	p.visible = true; // show first one
	
	a.front;
	
	)
	
Nested Example

In this example, the StaticText accepts mouse clicks, since container views can't:

	(
	w=Window.new.front;
	
	v=CompositeView.new(w,w.view.bounds.insetBy(10)).background_(Color.rand);
	v.decorator=FlowLayout(v.bounds);
	l="SUPERCOLLIDER".scramble;
	t=Array.fill(9,{arg i; var n,r,q;
		n=CompositeView.new(v,Rect(20,20,121,121)).background_(Color.rand);
		q=StaticText(n, n.bounds.moveTo(0,0).insetBy(25)).string_(l[i]).align_(\center);
		q.enabled=true;
//		q.font=Font("Geneva",10);
		q.font=Font( "Geneva", 10 );
		q.background_(Color.rand);
		q.mouseDownAction={
			n.background_(Color.rand);
			q.font=q.font.size_(5+q.font.size+7%60)
			};
		
		
		});
	)




