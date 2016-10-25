SCSliderBase			an abstract superclass for various sliders	

Inherits from: Object : SCView : SCControlView

Users will not normally directly create instances of SCSliderBase, but only use it through its subclasses. It provides a few methods common to various slider views. To set the increment or decrement value of a slider, set the step .  By default, the shift, ctrl, and alt keys will modify the stepping by 100x, 10x, or 0.1x respectively, though you can customize this by setting shift_scale, ctrl_scale, or alt_scale.

See also: SCSlider, SCRangeSlider, SC2DSlider

Creation / Class Methods

Accessing Instance and Class Variables

	step
	step_ (stepSize)
	
		The step size for changing a slider value. The subclasses tend to use this in their increment an decrement methods, among other things.
		stepSize - A Number;
		

	shift_scale_(aFloat)
	shift_scale
		
		A value for increment's or decrement's zoom argument while mouse scrolling  or arrow keys, and while the shift key is pressed. 
		shift_scale defaults to 100.
		aFloat - An instance of Float.

	ctrl_scale_(aFloat)
	ctrl_scale
		
		A value for increment's or decrement's zoom argument while mouse scrolling or arrow keys, and while the ctrl key is pressed. 
		ctrl_scale defaults to 10.
		aFloat - An instance of Float.
		
	alt_scale_(aFloat)
	alt_scale
		
		A value for increment's or decrement's zoom argument while mouse scrolling or arrow keys, and while the alt key is pressed. 
		ctrl_scale defaults to 0.1.
		aFloat - An instance of Float.
		
Customizing Appearance

	knobColor
	knobColor_ (color)
	
		Set the knob Color for a slider-
		color - An instance of Color.
		

Subclassing and Internal Methods
	The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed.
		
	properties
	
		A list of properties to which this view responds. See SCView.
		Returns:
		[ \bounds, \visible, \enabled, \canFocus, \resize, \background, \minWidth, \maxWidth, \minHeight, \maxHeight, \knobColor, \step, \thumbSize ]	

Examples

See SCSlider, SCRangeSlider, SC2DSlider



