EZGui			an abstract superclass for EZ widget wrappers	

Inherits from: Object

Users will not normally directly create instances of EZGui, but only use it through its subclasses. It provides the basic mechanisms for various EZ widget wrappers. It also provides a standard for EZ GUI Classes, and new EZ Classes should subclass EZGUI to help keep a consistent user interface .

See also: EZListView, EZPopUpMenu, EZSlider, EZNumber, EZRanger, EZKnob

Accessing Instance and Class Variables
				
	view
	
		Returns the enclosing CompositeView.
		
	bounds
	
		Returns the bounds of the enclosing CompositeView.
				
	label
	label_(string)
	
		Sets/gets it the label. Will add the label view if none was initially created.
		string - An Instance of String.
		
	window
		Returns the window if you used the popUp window function.

Accessing GUI options

	alwaysOnTop_(bool)
	alwaysOnTop
		
		Makes the popup window always on top, if there is one
		bool - An Instance of Boolean. Default is false;

	visible
	visible_(bool)
	
		Sets/gets it the component views are visible.
		bool - An Instance of Boolean. Default is true;
		
	enabled
	enabled_(bool)
	
		Sets/gets if the list is enabled.
		bool - An Instance of Boolean. Default is true;	
		
	onClose
	onClose_(func)
	
		Sets/gets the onClose function of either view or window, depending on whether the EZ view used a popup window.
		func - An Instance of Function or FunctionList.
		
	font_(font)
	
		font - An Instance of Font;	
		
Subclassing

EZGui provides a standard and basic tools for most EZ classes. If you make a new EZ class, then subclass EZGui, and override the necessary methods. If your class only has a label and a widget, chances are, you need to overide nothing, but only need to write the  new and init class methods. See existing subclasses of EZGui for examples of this. You may also want to override the following:

	widget
		returns the active widget.
		subclasses will typically refer to it or ignor it, e.g.:
		
		MyEZClass{
			myOtherMethods{}
			....
			listView{^widget}
		}

	action
	action_(func)
	
		Gets/sets the action of the EZclass instance.
		fund - An Instance of Function or FunctionList.
								
	value
	value_ (val)
	
		Gets/sets the value of the widget. Does not perform the action.
		val - An integer.

	valueAction_ (val)
	
		Gets/sets thevalue of the widget. Performs do action
		val - An integer.
		
	doAction
	
		Performs this.action.value(this) .

Internal Utilities

	prSubViewBounds(rect, hasLabel)
		This calculates the bounds of the subviews and the gaps. It returns an array of Rects, which depends on how many subview there are. Subclasses override this if they have more than one widget.
	
	prMakeView(parentView,bounds);
			Called by init . Returns s  [view,bounds]. The container is either the enclosing Container,  or a popUpWindow with a container.
			
	prSetViewParams
		Only defined by some subclassses. Sets the resize  and align of all the views, according to the state of layout 
		
	prMakeMarginGap(parentView, argMargin, argGap)
		Called in the  init method of all subclasses.  Sets the margin and gap of  view. By default, it tries to get its parent's gap, otherwise it defaults to 2@2. Setting argGap  overrides these.



