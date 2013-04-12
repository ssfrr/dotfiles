SCStaticTextBase			An abstract superclass for classes that store and display objects as strings	

Inherits from: Object : SCView

See also: SCNumberBox , SCTextField, SCStaticText, SCDragView

Users will not normally directly create instances of SCStaticTextBase, but only use it through its subclasses. It provides methods for the storage of objects, and their display as a text string or number. Its subclasses include editable and non-editable displays, such as static text, numbers boxes, or drag and drop objects.

Accessing Instance and Class Variables

	string
	string_ (argString)
	
		The displayed String of the static text. If the string needs to represent a type other than String, e.g. a Float, then you need to use the object method to set the content.
		argString - An instance of String.
		
	object
	object_ (obj)
	
		Allows you to store an object, which is displayed as a string. If setBoth==true (the default), then setting object will automatically set the string as well, using obj.asString(80). Subclasses, e.g. SCNumberBox or SCDragBoth, us this to display their value as a string.
		obj - Any Object. Most likely one which makes sense to display as a string, such as a Float.
		
	setBoth
	setBoth_(arg1)
	
		arg1 - An instance of Boolean. Default is true. See the method description for object above.
		
Customizing Appearance
		
	font
	font_ (argFont)
	
		Sets the Font of the static text. Default value is the default font: Font.default .
		argFont - An instance of Font.
	
	align_ (align)
	
		Sets the alignment of the string.
		align - An instance of Symbol. \centered, \left, or \right.
		
	stringColor
	stringColor_ (color)
	
		Sets the color of the displayed String.
		color - An instance of Color.
		
Subclassing and Internal Methods

	The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed. SCStaticTextBase functions by storing any instance of Object in the instance variable, object, and then representing it visually using string. This string can either be directly related to the object or not, depending on the flag, setBoth. By default, object is represented in string using the top level instance method, asString(80). Subclasses can override this.

	properties
	
		A list of properties to which this view responds. See SCView.
		
		returns:
		[ \bounds, \visible, \enabled, \canFocus, \resize, \background, \minWidth, \maxWidth, \minHeight, \maxHeight, \value, \font, \items, \stringColor ]

Examples
See the help files for subclasses such as SCStaticText or SCNumberBox.



