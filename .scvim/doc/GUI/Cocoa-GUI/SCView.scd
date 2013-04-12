SCView			the abstract superclass for all SC GUI widgets	

Inherits from: Object

SCView is the abstract superclass for all SC GUI widgets. You cannot call SCView directly. Several key methods and variables are defined in SCView and inherited in its subclasses. This help file contains important information about many of the basic functions of all gui views, in particular defining actions, defining drag and drop, defining mouse actions, and defining key actions.

See also: SCWindow, GUI

Some Important Issues Regarding SCView

If you try to set parameters of a GUI widget from a  Routine , which uses the SystemClock by default, you must wrap it in a deferred function: { myView.value_(2) }.defer .  You do not need to use .defer, if you use the AppClock.

Creation / Class Methods

	*new (parent, bounds)
	
		parent - The parent view.
		bounds - An instance of Rect, or a Point indicating width@height.

Accessing Instance and Class Variables

	parent
		
		Returns the view's parent view, or nil if the view is a top view.
		
	bounds
	bounds_ (rect)
	
		A Rect determining the bounds of the View. Some containers, such as SCHLayoutView and SCVLayoutView, will use only the width and height of a child view's bounds.
		rect - an instance of Rect, or a Point indicating width@height.
		
	absoluteBounds
	
		Returns a Rect witht he absolute bounds of the view.
								
	refresh
	
		Refreshes the view.
		
	remove
	
		Removes the view from its parent view and closes the view.
		
	enabled
	enabled_ (bool)
	
		Gets / sets whether the view is enabled, ie. responds to key or mouse actions (see below). Defaults to false, but views which respond to user input default to true. Some views will be greyed if they are disabled.
		bool - An instance of Boolean.

	canFocus
	canFocus_ (bool)
	
		Gets / sets whether the view can be focussed. Defualts to true.
		bool - An instance of Boolean.

	hasFocus
	focus (flag)
	
		Gets / sets whether the view is focussed.
		flag - An instance of Boolean.
		
	isClosed
	notClosed
	
		Returns an instance of Boolean depending on whether the view is closed or not.
		
	onClose_(arg1)
	onClose
		
		A function to be evaluated upon closing the view.
		arg1 - A Function or FunctionList. Default value is nil.
		
Customizing Appearance

	background
	background_ (color)
	
		The background color of the view.
		color - An instance of Color.
		
	focusColor
	focusColor_ (color)
	
		The background color of the view when it is focussed.
		color - An instance of Color.

	visible
	visible_ (bool)
	
		Gets / sets whether the view is visible. Defualts to true.
		bool - An instance of Boolean.


Resize Constraints

resize takes integers 1-9 as an argument which defines how a view behaves when a window is resized.
See resize for details and examples.
		

Defining Actions

Actions are Functions which are evaluated when the primitive calls doAction in response to user input of some sort. Typically a view like SCButton, SCSlider, SCPopUpMenu, etc, use action to store the function to be performed on user input. Many views only call doAction if their value has changed.

	action
	action_(arg1)
	
		The action a view takes if doAction is called (normally by the primitive). See doAction. Many view subclasses override this methods for their own purposes.
		arg1 - An instance of Function or FunctionList. Default value is nil.
				
	addAction (func, selector)
	removeAction (func, selector)
	
		Adds/removes an action to or from the list of functions in the variable determined by selector. Adding functionality to a view by the method addAction is useful for adding things to existing frameworks that have action functions already.
		func - An instance of Function.
		selector - A Symbol. Defaults to \action. By default, addAction will add a function to the FunctionList of action, but you can also make it add a function to any other (sensible) instance or class variable in SCView by using a different selector, for example, \globalKeyDownAction or \mouseUpAction or \onClose . See the other action variables below.
		
		(
		w = Window.new("A Slider");
		a = Slider.new(w, Rect(40, 10, 300, 30));
		w.front
		);
		
		// adding and removing an action:
		f = { |sl| "--------*******-------".postln; };
		a.addAction(f);
		a.removeAction(f);

Defining Key Actions

Use the methods below to store functions to be called in response to a key event initiated by the user. If you return nil from your function, or you have no function registered, the event will bubble up to the parent view which may then respond. It will continue to bubble up unless something responds or it hits the topView of the window. You may register a function in the window's topView to respond to all unhandled events for the window.

When calling one of the key actions , the function will be passed the following arguments (in order):

		view - The receiving instance of SCView.
		
		char - The character pressed, possibly unprintable. Character sequences (for example ) get passed as two characters, the first one blank ( ), the second one is the unmodified character (e). This will also vary depending on the nationality the keyboard is set to.
		
		modifiers- An integer bit field indicating the modifier keys in effect. You can examine individual flag settings using the C bitwise AND operator. For a list of these, see modifiers.
			
		unicode - The unicode integer.
			
		keycode - The hardware dependent keycode indicating the physical key. This will vary from machine to machine, but is useful for building musical interfaces using the computer keyboard.
				
		N.B.: Function key modifier may change the keycode.
		
		For various reasons these don't make it through cocoa:
			most command modifiers
			ctl-tab
			ctl-escape
			tab and shift tab are currently trapped by SC itself for cycling the focus through the views.

	keyUpAction
	keyDownAction
	keyUpAction_(arg1)
	keyDownAction_(arg1)
	
		This is where you define your key actions. If these variables are nil (the default), defaultKeyDownAction or defaultKeyUpAction are called instead. Many subclasses define their own appropriate default key actions. See also addAction (func, selector) above.
		arg1 - An instance of Function or FunctionList. The function is passed the following argument list: view, char, modifiers, unicode, keycode.

	globalKeyDownAction	
	globalKeyDownAction_(arg1)				
	globalKeyUpAction
	globalKeyUpAction_(arg1)
	
		A class variable. Here you can define a global key action. An instance of Function or FunctionList which is globally evaluated on a key action. See also addAction (func, selector) above.
		arg1 - An instance of Function or FunctionList. The function is passed the following argument list: view, char, modifiers, unicode, keycode.


	keyModifiersChangedAction_(arg1)
	keyModifiersChangedAction
	
		This is where you set actions to be performed if the modifier changes. See also addAction (func, selector) above.
		arg1 - An instance of Function or FunctionList. The function is passed the following argument list: view, modifiers.
			
Defining Mouse Actions

Use the methods below to store functions to be called in response to a mouse action initiated by the user. A view must be enabled for the mouse actions to work. The function is passed one or more arguments from the following argument list (in order):

				view - the view
				x - the x coordinate
				y - the y coordinate
				modifiers - a modifier key number. For a list of these, see modifiers.
				buttonNumber - 0-left, 1-right, 2-middle, etc.
				clickCount - the number of clicks within the system click time limit. At least 1.
				
	mouseDownAction
	mouseDownAction_(arg1)
	
		This is where you set your mouse down actions. See also addAction (func, selector) above.
		arg1 - An instance of Function or FunctionList. The function is passed the following argument list view, x, y, modifiers, buttonNumber, clickCount.
		
	mouseUpAction
	mouseUpAction_(arg1)
	
		This is where you set your mouse up actions. See also addAction (func, selector) above.
		arg1 - An instance of Function or FunctionList. This is where you set your mouse actions. The function is passed the following argument list: view, x, y, modifiers. Default is nil.
		
	mouseMoveAction
	mouseMoveAction_(arg1)
	
		This is where you set your mouse move actions. See also addAction (func, selector) above.
		arg1 - An instance of Function or FunctionList. This is where you set your mouse actions. The function is passed the following argument list: view, x, y, modifiers. Default is nil.

	mouseOverAction
	mouseOverAction_(arg1)
	
		This is where you set your mouse over actions. For this to work, acceptsMouseOver of the parent Window must be set to true. See also addAction (func, selector) above.
		arg1 - An instance of Function or FunctionList. The function is passed the following argument list: view, x, y. Default is nil.

		(
		w=SCWindow.new.front;
		
		v=SCCompositeView.new(w,w.view.bounds.insetBy(10)).background_(Color.rand);
		v.decorator=FlowLayout(v.bounds);
		t=Array.fill(9,{arg i; var n,r,q;
			n=SCCompositeView.new(v,Rect(20,20,121,121)).background_(Color.rand);
			q=SCStaticText(n, n.bounds.moveTo(0,0).insetBy(25)).string_((70+i).asAscii).align_(\center);
			q.enabled=true;
			q.font=Font.default.copy;
			q.background_(Color.rand);
			q.mouseDownAction={
				n.background_(Color.rand);
				q.font=q.font.size_(5+q.font.size+7%60)
				};
			
			
			});
		)
		
Defining Drag and Drop Actions

Each view subclass has a default object that it exports when dragged from. For sliders its the value of the slider, for lists it is the currently selected numeric index etc. By setting the beginDragAction handler you can return a different object based on the context and your application.

The current dragged object can be found in the classvar SCView.currentDrag. Files dragged from the Finder will result in an Array of Strings representing the files' paths. Objects dragged from within SuperCollider are also in SCView.currentDragString as a compile string. Text dragged from other applications is in SCView.currentDragString and the results of attempting to compile that as sc code is in SCView.currentDrag.

Each view subclass has a defaultCanReceiveDrag method that determines if the current object being dragged is possible for this view to accept, and a defaultReceiveDrag method for actually receiving the drag. Sliders accept numbers, simple text labels do not accept drags etc. After receiving the drag, the SCView.currentDrag is set to nil. Containers typically cannot receive drags by default.

By setting the canReceiveDragHandler and receiveDragHandler you can make a view accept and receive objects based on the context and your application. (Note: currently not possible for SCStaticText)

	beginDragAction_(arg1)
	beginDragAction
		
		This is a custom handler determining the content of the drag. If this variable is nil (the default), defaultGetDrag is called instead. Many views already have their own appropriate defaultGetDrag. See also addAction (func, selector) above.
		arg1 - An instance of Function or FunctionList. The function is passed the following argument list: view, x, y.

	canReceiveDragHandler_(arg1)
	canReceiveDragHandler
	
		This is where you deterimine under which conditions a view will recieve a drag. If this variable is nil (the default), defaultCanReceiveDrag is called instead. See also addAction (func, selector) above.
		arg1 - An instance of Function or FunctionList. This function typically will examine currentDrag, an return a boolean. The function is passed the following argument list: view, x, y.

	receiveDragHandler_(arg1)
	receiveDragHandler
		
		This is where you deterimine what a view will do when it receives a drag. If this variable is nil (the default), defaultReceiveDrag is called instead. See also addAction (func, selector) above.
		arg1 - An instance of Function or FunctionList. The function is passed the following argument list: view, x, y. Typically it will then precess currentDrag in some way.
	
	dragLabel_(string)
	
		Set a string to be displayed in a label while dragging, instead of displaying the object type.
		string - An instance of String.
		
		(
		w = SCWindow.new.front;
		a = SCButton(w, Rect(10, 10, 200, 20)).states_([["Hi There!"]]);
		a.receiveDragHandler = { a.string = SCView.currentDrag.postln[0].basename};
		a.beginDragAction = { a.dragLabel ="I'm dragging: \""++ a.states[0][0]++"\""; a.states[0][0] };
		SCDragSink(w,Rect(10,40,200,20)).align_(\center).string="Cmd-drag from Button to here";
		)
				
	currentDrag
		
		A class variable. Contains the content fo the current drag. It is set by beginDrag.
				
	currentDragString
		
		A class variable. Conatains the content fo the current drag asCompileString (see Object). It is set by beginDrag.

Subclassing and Internal Methods

The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed. For a Tutorial on how to subclass and SCUserView to make your own custom GUI Widgets, see SCUserView-Subclassing. The tutorial is a good template for any View subclass, and clearly explains the most important method overrides.
	
If you want to subclass a GUI class, then it is important to understand the viewClass mechanism (see below). You must set the viewCass if you want to use the primitive of the parent class.

	*viewClass
	
		Returns the current GUI class. This class method provides a mechanism to subclass existing GUI objects while still calling their primitives. It is used by many extensions and Quarks. E.g., if I subclass SCNumberBox with SCMySubClass, but want to continue to use SCNumberbox's primitive, then I have to define tha class method, viewClass, making it return SCNumberBox instead of SCMySubClass, like this:
		
		SCMySubClass : SCNumberBox {
		
			*viewClass{^SCNumberBox} // this ensures that SCNumberBox' primitive is called
			
			// my other methods ......
			
		}
		
		This is because view init methods typically contain this:
		
		this.prInit(parent.asView, argBounds.asRect,this.class.viewClass)
		
	*paletteExample (parent, bounds)
	
		Normally not used directly. Used by the SCInterfaceBuilder and determines if and how this class is implemented when dragged to the construction view. You can use cmd-shift-N to evoke the interface builder. All views on the Pallette override this with their own appropriate method. Override this to determine how your subclass is displayed in the interface builder.

	init (argParent, argBounds)
		
		Creates the view and adds it to its parent.
		argParent - An SCView or SCWindow SCTopView
		argBounds - an instance of Rect, or a Point indicating width@height.

	asView
	
		Simply returns the view. Used for comptabliltiy with SCWindow.asView. If you want to guarantee that a view's parent will recieve a view, then write, e.g.:
		
		{arg w;
			SCSlider(w.asView,Rect(10,10,150,20)
		}

	getParents
	
		Returns and Array containting all the parents and grandparents, etc., of the view.

	id
	id_ (id)
	findByID (id)
		Internal methods.

Subclassing and Internal Methods: Actions

The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed.

	doAction
	
		Evaluates the action. Typically called by the primitive of a view subclass in response to some kind of user input, with the mouse, keys, etc. Many view subclasses override this methods for their own purposes.

Subclassing and Internal Methods: Properties

The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed. In particular, there are a number of views that return property keys, which are not implemented (yet). Typically, a sub class will implement instance methods which call getPropertyor setProperty whith the name of the method as the key. For example, the method knobColor_(color) might call setProperty(\knobColor, color).

	properties

		A list of properties to which this view responds. Most subclasses override or supplement this, getting their property list from their primitives.

		returns:
		[ \bounds, \visible, \enabled, \canFocus, \resize, \background, \minWidth, \maxWidth, \minHeight, \maxHeight, \knobColor, \step, \thumbSize, \focusColor]

	getProperty (key, value)
	setProperty (key, value)
		
		Sets the property at key to the value.
		key - An instance of Symbol.
		value - A value appropriate to the key.
		
	setPropertyWithAction (symbol, obj)
	
		Sets the property and calls doAction.
		symbol - The property key. An instance of Symbol.
		obj - a value appropriate to the key.
		
	getPropertyList
	
		Returns an array of property keys and their values, of the form [ [\key1, value1] , [\key2, value2] ...].
		
	setPropertyList (list)
	
		Sets a list of properties to associated values. Typically called by methods that need to set more than one property.
		list - An Array of the form [ [\key1, value1] , [\key2, value2] ...].

Subclassing and Internal Methods: Key Actions

The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed.

	defaultKeyUpAction
	defaultKeyDownAction
	
		These are the methods to override to define defualt key actions in a subclass. The action function evaluated by default on a key action. Many views override these methods, defining their own appropreate default action. Setting the keyDownAction or keyUpAction will bypass these defaults.	

	keyTyped_(arg1)
	keyTyped
		
		Contains the key just typed.

	keyDown (char, modifiers, unicode, keycode)	
	keyUp (char, modifiers, unicode, keycode)
	
		Called by a primitive. Evaluates the globalKeyDownAction (globalKeyUpAction) and calls the handleKeyDownBubbling (handleKeyUpBubbling) method.
					
	handleKeyDownBubbling (view, char, modifiers, unicode, keycode)
	handleKeyUpBubbling (view, char, modifiers, unicode, keycode)
	
		Called by keyDown or keyUp, and either evaluated the key actions, or bubbles up to the parent view, which may then respond.

	keyModifiersChanged (modifiers)
	
		Evaluates the keyModifiersChangedAction and calls the handleKeyModifiersChangedBubbling method.

	handleKeyModifiersChangedBubbling (view, modifiers)
	
		Called by keyModifiersChanged, and either evaluated the keyModifiersChangedAction, or bubbles up to the parent view, which may then respond.
		
Subclassing and Internal Methods: Mouse Actions

The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed.

	mouseDown (x, y, modifiers, buttonNumber, clickCount)		
	mouseUp (x, y, modifiers)
	mouseMove (x, y, modifiers)
	mouseOver (x, y)
	
		These are the methods to override in your subclass. If you override these, remember to call mouseDownAction, mouseUpAction, mousMoveAction, or mouseOverAction in your method so that users can still set addidtional custom mouse actions. These are called by the primitive.
		
Subclassing and Internal Methods: Drag and Drop Actions

The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed.

The next three methods are the ones you will most likely override in your custom View subclass

	defaultGetDrag
	
		Override this in your subclass. The default method for determining the content of a drag. Many subclases override this for their specific behaviors. called by beginDrag.

	defaultCanReceiveDrag
	
		Override this in your subclass. The default method for determining under which condidtions a view will recieve a drag. Many subclases override this for their specific behaviors. Called by canReceiveDrag.
		
	defaultReceiveDrag
	
		Override this in your subclass. The default method for determining what to do with a recieved . Many subclases override this for their specific behaviors. Called by receiveDrag.


	*importDrag
	
		Called when an NSString is the drag object from outside of the SC app.
		Override this in your subclass.
		
	beginDrag
	
		Called by the primitive. Calls beginDragAction or defaultGetDrag, depending on whether beginDragAction is nil.

	canReceiveDrag
	
		Called by the primitive. Calls beginDragAction or defaultGetDrag, depending on whether beginDragAction is nil.
		
	receiveDrag (x, y)
	
		Called by the primitive. Calls canReceiveDragHandler.

	



