SCTextField			a text field for entering text	

Inherits from: Object : SCView : SCStaticTextBase : SCNumberBox

See also: SCStaticText, SCTextView

Some Important Issues Regarding SCTextField

Does not allow copying and pasting. Does not handle composed character sequences ( etc. ). Use SCTextView for these features. Hit delete before typing to clear the text field. Drag and drop accepts a any Object and recieves it asString. Inherits formatting methods from SCStaticTextBase. If you drag a file from the finder onto an SCTextView, it will display the file path.

Creation / Class Methods
	*new (parent, bounds)
	
		parent - The parent view.
		bounds - An instance of Rect, or a Point indicating width@height.
		
		(
		w = Window.new.front;
		a = TextField(w, Rect(10, 10, 150, 20));
		a.string = "some default text";
		a.action = {arg field; field.value.postln; };
		)

Accessing Instance and Class Variables
	
	string_ (s)
	
		Sets the String of the text field.
		s - An instance of String.

Subclassing and Internal Methods

	The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed.
	
	*viewClass
		
		Sets the view class thus determining which primitive is called.
	
	defaultKeyDownAction (char, modifiers, unicode)
	
		The default keydown actions are:
		
		key				action									comment
		\r 				valueAction on the string
		\n, 				valueAction on the string	
		3.asAscii,			valueAction on the string						(enter key or cmd-C on Mac OSX )
		127.asAscii		clears the keyString (See SCNumberBox)		(delete key)
						if no text has been typed yet. Otherwise
						deletes the last typed character.
		all others			adds character to the keyString (See SCNumberBox)
		
	defaultGetDrag
	
		The method called by default when initiating a drag from an SCTextView. Returns string.
			
	defaultCanReceiveDrag
	
		The method called by default when attempting to place a drag in this object. By default, SCTextView will respond only to drags containing objects that respond to the method, asString (basically, all objects, since Object does).

	defaultReceiveDrag
	
		The default method called when a drag has been recieved. Performs valueAction_() using currentDrag as an argument.

Examples

(
w = Window.new.front;
a = TextField(w, Rect(10, 10, 150, 20));
a.string = "hi there";
a.action = {arg field; field.value.postln; };
)

// does not do the action
a.value = "yo";
a.string = "oy";

a.valueAction_("this is not a pipe"); //does the action, if the value has changed
a.doAction; //evaluates the action with the content of the text field as an argument

a.background_(Color.grey);
a.stringColor_(Color.white);
a.align_(\center);



