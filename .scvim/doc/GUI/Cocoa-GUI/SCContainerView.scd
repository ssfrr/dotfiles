SCContainerView			an abstract superclass for container views	

Inherits from: Object : SCView

Users will not normally directly create instances of SCContainerView, but only use it through its subclasses. It provides the basic mechanisms for container views of various kinds, which are used for placing and grouping widgets in a window.

See also: SCTopView, SCCompositeView, SCHLayoutView, SCVLayoutView, SCScrollView SCScrollTopView

Some Important Issues Regarding SCContainerView

Container views are meant for placing and grouping child views and widgets. While they accept key actions, many do not accept mouse cklicks or drags. The exception is SCTopView and its subclasses.

Accessing Instance and Class Variables
	
	decorator_(arg1)
	decorator
		
		An automatic layout management for a container. Currently the only one existing is FlowLayout.
		(note: Crucial Library also has a useful layout tool called GridLayout.)

	addFlowLayout(margin, gap)
		
		A convenience utility which sets decorator to FlowLayout and returns the decorator. See FlowLayout for examples.
		margin - An instance of Point
		gap - An instance of Point
		
	children
		
		An array containing all the views (children) contained in the the container.
		
		
Adding and Removing Subviews
						
	add (child)
	
		Adds a view to children. The placement of the child view will depend on the the decorator, and the child's bounds. Nomally you don't need to call this directly, since subviews call it automatically when you create them.

	removeAll
	
		Removes all children from the view

Subclassing and Internal Methods
	The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed.

	init (argParent, argBounds)
	
	prRemoveChild (child) private method
	prClose private method
	



