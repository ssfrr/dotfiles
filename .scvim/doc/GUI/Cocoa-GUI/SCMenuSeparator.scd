SCMenuSeparator			represents a separator in a menu	

Inherits from: Object : CocoaMenuItem

SCMenuSeparator allows users to add separators (a horizontal line) to custom menus.

See also: CocoaMenuItem, SCMenuItem, SCMenuGroup

Creation

	*new (parent, index)
	
		Create a new menu separator.
		parent - The menu or submenu in which to add this separator. This should be an instance of SCMenuGroup.
		index - The index at which to insert this item in its parent.
		
Examples

// Simple example
g = SCMenuGroup(nil, "stuff", 10);
i = SCMenuItem(g, "foo");
j = SCMenuItem(g, "bar");
j.action = {"bar!!".postln};
k = SCMenuSeparator(g, 1); // add a separator
i.enabled = false;
j.state = true;
j.setShortCut("$", true, true); // Cmd-ctrl-alt-$

CocoaMenuItem.clearCustomItems;


