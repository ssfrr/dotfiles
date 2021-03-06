SCDragSink			a gui object for receiving drag and drop		

Inherits from: Object : SCView : SCStaticTextBase : SCDragView

See SCDragView for description and examples, and SCView for a general description of the drag and drop mechanism.

Creation / Class Methods

	*new (parent, bounds)
	
		parent - the parent view.
		bounds - an instance of Rect, or a Point indicating width@height.

Subclassing and Internal Methods
	The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed.
					
	defaultCanReceiveDrag
	
		The method called by default when attempting to drop a drag in this object. By default, SCDragSink will respond to any drag.
						
	defaultReceiveDrag

		The default method called when a drag has been recieved.
		By default, this sets the object to the currentDrag and performs the action.
		
Examples

(
s.waitForBoot({	//only needed if you are using sound
	w=Window.new.front;
	
	// store various kinds of objects in the drag source
	
	// a string source
	a=DragSource(w,Rect(10,10,150,20)).align_(\center);
	a.object="I am a string source";
	
	// a Float source
	b=DragSource(w,Rect(10,40,150,20)).align_(\center);
	b.object=2.234;
	
	// a Point source
	c=DragSource(w,Rect(10,70,150,20)).align_(\center);
	c.object=Point(20,30);
	
	// A sound function source
	// dragLabel_() is used for the label while dragging
	d=DragSource(w,Rect(10,100,150,20)).align_(\center);
	d.object={Synth(\default)};
	d.dragLabel=" I am a sound function.\n My dragLabel_() is set \n to inform you about that ";
	
	// A sound function source
	//here the string label is independent of the content type (Function)
	// dragLabel_() is used for the label while dragging
	f=DragSource(w,Rect(10,130,150,20)).align_(\center).setBoth_(false);
	f.object={{SinOsc.ar(440,0,0.4)}.play};
	f.string="My label is independent";
	f.dragLabel=" My dragLabel_() says \n I am dragging a sound function ";
	
	// receive anthing
	g=DragSink(w,Rect(170,10,200,20)).align_(\center);
	g.string="recieve anything, do nothing";
	
	// receive only floats
	g=DragSink(w,Rect(170,40,200,20)).align_(\center);
	g.string="I only like floats";
	g.canReceiveDragHandler = { View.currentDrag.isFloat };
	
	// receive only numbers and points, and convert them to rects
	h=DragSink(w,Rect(170,70,200,20)).align_(\center);
	h.string="I convert to Rect";
	h.canReceiveDragHandler = {View.currentDrag.isKindOf(Number)||View.currentDrag.isKindOf(Point)};
	h.receiveDragHandler={arg v; h.object=View.currentDrag.asRect};
	
	// receive only functions, and try to play them
	i=DragSink(w,Rect(170,100,200,20)).align_(\center);
	i.string="I evaluate a (sound) function";
	i.canReceiveDragHandler = {View.currentDrag.isKindOf(Function)};
	i.receiveDragHandler={arg v;
		i.object=View.currentDrag.value;
		i.string="click here for silence";
		i.background_(Color.red)};
	i.mouseDownAction_({i.object.free;i.string="I evaluate a (sound) function";i.background_(Color.clear)});
	
	StaticText(w,Rect(10,200,380,50))
		.stringColor_(Color.white)
		.string_("Try dragging any item on the left -----> to any item on the right");
		
});
)




