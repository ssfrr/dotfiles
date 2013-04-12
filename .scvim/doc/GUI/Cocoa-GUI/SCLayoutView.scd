SCLayoutView			an abstract class for layout containter views	

Inherits from: Object : SCView : SCContainerView

Users will not normally directly create instances of SCLayoutView, but only use it through its subclasses.

See also: SCHLayoutView SCVLayoutView

Customizing Appearance

	spacing
	spacing_ (distance)
	
		distance - pixels.
		
Subclassing and Internal Methods
The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed.

	properties
	
		A list of properties to which this view responds. See SCView.
		
		returns:
		[ \bounds, \visible, \enabled, \canFocus, \resize, \background, \minWidth, \maxWidth, \minHeight, \maxHeight, \spacing ]

	setProperty (key, value)
	
		Set a property. See properties below. Normally you can also set properties by using methods with the same names as the keys.
		key - An instance of Symobol
		value - A value appropriate to the key.


