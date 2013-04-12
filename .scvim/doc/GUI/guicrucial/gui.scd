gui			make a graphical user interface for an object

.gui is a common interface convention that creates a graphical user interface for the object 

nil.gui;
"2".gui;
2.gui;
[1,nil,"tree"].gui;


gui(parent,bounds)

parent -
	a Window,
	a FlowView
	CompositeVIew
	HLayoutView
	VLayoutView
	nil (will create a window with a FlowView) 

bounds -
	anything that responds to asRect:
		Nil - the gui will use its own default size
		Point - width @ height

	Usually the bounds are not specified.  The object's gui class first adds a container,
	lays its things inside that container and then shrinks the container to fit it.
	If you specify a bounds, the container will be set to that size and will stay that way.

Add yourself to a parent view (window)
(
	f = FlowView.new;
	nil.gui(f);
	"2".gui(f);
	2.gui(f);
)


Each class can specify an associated guiClass, which is a subclass of ObjectGui.
If none is specified then ObjectGui will create the simplest of guis.

Examples specifying guiClass:

	Object-guiClass {  ^ObjectGui }
	AbstractPlayer-guiClass { ^AbstractPlayerGui }
	Patch-guiClass { ^PatchGui }

For any class where it is appropriate, a separate gui class is implemented, usually inheriting much of its behavior from the gui class of the superclass.

see also [ObjectGui]



