SCUserView Subclassing Tutorial
by Jost Muxfeldt		

See also: GUI-Overview, SCUserView, SCView, Writing Classes

The following is a short tutorial on how to make a custom gui widget by subclassing SCUserView. It is assumed that you know how to write classes in SuperCollider. See Writing Classes.

You also need to open the template class file, SCUserViewTutorial.sc , first to follow this tutorial.

You can use the contents of SCUserViewTutorial.sc as a template for writing your own subclass. Simply copy the file to your SC extensions folder and rename the file and class, MyWidget, to whatever you want to call your class. Then adjust the class methods to fit your design.

The following narrates the code in SCUserViewTutorial.sc:

	1. Setup instance vars appropriate to your widget
	
		You inherit all of the instance variables from SCUserView and SCView, of course, but many gui widgets need their own variables. In particular, you need to overide value, to return whatever you want your view to return. The instance variable, step, is also often used to allow value to be quantized. thumbSize is used for both width and height of a slider thumb, while thumbWidth or thumbHeight are typically used for only one dimension. x and y are used for mouse clicks. Take a look at a similar SC widget to see what the standard instance variables are.
		
	2. Define the viewClass to SCUserView
	
		This is mandatory. You must do this so that your class calls the primitive of SCUserView on init.

	3. Set up your view
	
		You will want to override init to customize your sub class.Here you will set the defaults of some of your instant variables and anything else you want to do on creating the view.
		
		Finally, you should set this.drawFunc (SCUserView's drawing function) to the method this.draw, which you will define below.
		
	4. Define a drawing function for SCPen
	
		This is where you will define how the view appears. As of SC3.31, drawing should use relative coordinates. How you draw will  typically will be dependent on instance variables which you defined such as value, states (for buttons), x and y (for mouse clicks), or anything else you might need for your design. See SCPen for drwaing methods.

	5. Define typical widget methods
	
		Here you define various methods according to your own design. You should look at similar gui objects to see what they have. The setter, valueAction_ is defined by practically any gui widget, for example. It sets the value and performs the action (already defined in SCView).

	6. Override mouseActions
	
		SCView defines mouseDown, mouseMove and mouseUp, as methods, and the corresponding user definable methods, mouseDownAction, mouseMoveAction and mouseUpAction. You should overrider mouseDown, mouseMove or mouseUp as needed, and make sure your method calls the corresponding action as well, so your user can later add user actions, just like in the template. Also see the SCView help file.
		
	7. Define default key actions
	
		Here you define your default key responses in defaultKeyDownAction or defaultKeyUpAction. Differently than with mouse actions, you do not call the keyAction in your method, since this mechanism is handled by SCView. If the user defines a keyDownAction, or keyUpAction, SCView makes it override your default action. See the template, and see the SCView help file.

	8. Define default drag and drop actions
	
		Here you define your drag responses in defaultGetDrag, defaultCanReceiveDrag, and , defaultReceiveDrag. Differently than with mouse actions, you do not call the dragAction in your method, since this mechanism is handled by SCView. If your user defines a beginDragAction, canReceiveDragHandler, or receiveDragHandler, SCView makes it override your default action. See the template, and see the SCView help file.
		
		
That's it. Now recompile, only to find your first syntax errors. ;-)

Happy subclassing.

//try this after you have added the class to the class library
(	
	GUI.cocoa;
	w=Window.new.front;
	v=MyWidget(w, Rect(10,20,200,20)).valueAction_(0.5);
	
	q=MyWidget(w, Rect(10,60,200,20)).valueAction_(0.3);
)

		
		


