SCTopView			the top view in an SCWindow	

Inherits from: Object : SCView : SCContainerView : SCCompositeView

Normally, you do not create this view manually. SCTopView is automatically placed into an SCWindow as its top view, unless scroll is set to true upon SCWindow creation, in which case a SCScrollTopView is used. SCTopView is different from other container views, in that it can accept drags. This is mainly to support the interface builder GUI (hit Cmd-shift-N).

See also: SCWindow, SCScrollTopView

Accessing Instance and Class Variables	
				
	findWindow
	
		Returns the parent window of the SCTopView.
		
Subclassing and Internal Methods

	handleKeyModifiersChangedBubbling (view, modifiers)
	
		Called by keyModifiersChanged, and either evaluated the keyModifiersChangedAction, or bubbles up to the parent view, which may then respond.

	handleKeyDownBubbling (view, char, modifiers, unicode, keycode)
	handleKeyUpBubbling (view, char, modifiers, unicode, keycode)
	
		Called by keyDown or keyUp, and either evaluated the key actions, or bubbles up to the parent view, which may then respond.

	canReceiveDrag
	
		Called by the primitive. Calls beginDragAction or defaultGetDrag, depending on whether beginDragAction is nil.
		
	defaultReceiveDrag (x, y)

Interface Builder Methods

	constructionGrid_ (point)

	constructionGrid

	enableConstructionGrid_ (flag)

	enableConstructionGrid



