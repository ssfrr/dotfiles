SCDragBoth			a gui object source and receiver for drag and drop

Inherits from: Object : SCView : SCStaticTextBase : SCDragView : SCDragSink

See SCDragView for description and examples.

Creation / Class Methods

	*new (parent, bounds)
	
		parent - the parent view.
		bounds - an instance of Rect, or a Point indicating width@height.

Subclassing and Internal Methods
	The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed.
	
	defaultGetDrag
	
		The method called by default when initiating a drag. Returns the content of object when dragging from an SCDragBoth.

Examples

(
	w=Window.new.front;
	w.addFlowLayout;
	// store various kinds of objects in the drag source
	
	// a string source
	a=DragBoth(w,Rect(10,10,150,20)).align_(\center).background_(Color.rand);
	a.object="drag us around";
	
	
	a=DragBoth(w,Rect(10,10,150,20)).align_(\center).background_(Color.rand);
	a.object="SUPERCOLLIDER";
	
	8.do{
	a=DragBoth(w,Rect(10,10,150,20)).align_(\center).background_(Color.rand);
	a.receiveDragHandler={arg obj; obj.object = View.currentDrag.scramble}
	}
	
			
)





