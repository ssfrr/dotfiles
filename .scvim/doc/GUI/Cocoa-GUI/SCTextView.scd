SCTextView			a view in which to display and edit text or code	

Inherits from: Object : SCView

See also: SCStaticText, SCTextField

Some Important Issues Regarding SCTextView

While SCTextView allows you to load and display formatted text, and while it understands rtf or html markup, you cannot save formatted text currently. You only have acces to the text-content of the view as a String.

By default, SCTextView will receive drags containing any Object, and insert them into the text asString. If you drag a file from the finder onto an SCTextView, it will display the file path in quotation marks.

Creation / Class Methods

	*new (parent, bounds)
	
		parent - The parent view.
		bounds - An instance of Rect, or a Point indicating width@height.
		
		(
		w = Window.new.front;
		t = TextView(w.asView,Rect(10,10, 380,200))
			.focus(true);
		)
		
Accessing Instance and Class Variables

	string
	string_ (str)
	
		The displayed content of the SCView, as a string. For more precise control of the string, see setString below.
		str - An instance of String.
		
	open (path)
	
		Opens a file from path. This will interpret rtf and html for display, but you cannot save formatting currently.
		path - An instance of String.
		
	selectedString
	
		Returns the text currently selected with the cursor as a String.

	selectionStart
	
		Returns the start of the current selection as an integer.
		
	selectionSize
	
		Returns the size of the current selection as an integer.
	
	usesTabToFocusNextView_(bool)
	
		Default is true. If false, then hitting tab will write a tab in the text view, rathern than jumping to the next view.
		bool - An instance of Boolean.

	enterInterpretsSelection
	enterInterpretsSelection_ (bool)
	
		Determines if a selection can be interpreted with the cmd-enter or ctrl-c . Default is true.
		bool - An instance of Boolean.

	enabled_ (bool) same as editable_(bool)
	editable			
	editable_ (bool)
	
		Without setting editable, it returns nil, though the content will be editable. However, you can explicitly set editable to true or false, and it will make the view editable or otherwise.
		bool - An instance of Boolean.
		
Customizing Appearance and Changing Content

	font
	font_ (argFont)
	
		Sets the font variable of the text view, and changes the Font of the entire text in the view. Default value is nil. If you loaded a text with open, then the font will still be nil. Changing the font of the content using OSX's cmd-T text formatter will not change the font variable. For more precise control of the font, see setFont below.
		argFont - An instance of Font.
				
	stringColor
	stringColor_ (color)
	
		Sets the stringColor variable of the text view, and changes the stringColor of the entire text in the view. Default value is nil. If you loaded a text with open, then the stringColor will be nil. Changing the stringColor of the content using OSX's cmd-T text formatter will not change the font variable. For more precise control of the string color, see setStringColor below.
		color - An Instance of Color.

	autohidesScrollers_ (bool)
	
		Overrides hasHorizontalScroller_ and hasVerticalScroller_ . Default is false.
		bool - An instance of Boolean.

	hasHorizontalScroller_ (bool)
	
		Is overriden by autohidesScrollers_. Default is false.
		bool - An instance of Boolean.

	hasVerticalScroller_ (bool)
	
		Is overriden by autohidesScrollers_. Default is false.
		bool - An instance of Boolean.
	
	setStringColor (color, rangeStart, rangeSize)
	
		color - An instance of Color.
		rangeStart - The beginning of a range of text in which to change the color.
		rangeSize - The length of a range of text in which to change the color.

	setFont (font, rangestart, rangesize)
	
		font - An instance of Font.
		rangeStart - The beginning of a range of text in which to change the font.
		rangeSize - The length of a range of text in which to change the font.

	setString (string, rangestart, rangesize)
	
		string - An instance of String.
		rangeStart - The beginning of a range of text in which to change the content.
		rangeSize - The length of a range of text in which to change the content.
		
	syntaxColorize
		
		Runs the default syntax colorizer over the contents of the TextView.
		
Subclassing and Internal Methods
	The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed.
	
	mouseUp (x, y, modifiers, buttonNumber, clickCount, clickPos)
	
		Normally not called directly. Used by the primitive.
		
	selectedString_ (str)
	
		Normally not called directly.


Examples

(
w = Window.new("Text View Example",Rect(100,Window.screenBounds.height-400, 520,300)).front;
t = TextView(w.asView,Rect(10,10, 500,200))
	.focus(true);
)

// Using the Window you just created, try these in succession, and test how the text view responds
t.mouseUpAction_{|it, x, y, modifiers, buttonNumber, clickCount, pos| [pos].postln};
t.hasVerticalScroller_(true);
t.hasHorizontalScroller_(true);
t.autohidesScrollers_(true);

t.open("Help/GUI/Main-GUI/Button.html"); // load an html file

// selective editing and formatting
t.setStringColor (Color.red, 5, 220);
t.setFont (Font("Courier",12), 5, 120);
t.setString ("\nA replacement String\n", 12, 120);

// compare with these methods, which change everything
t.font_(Font("Courier",14));
t.stringColor_(Color.blue);



