SCMenuItem			represents an item in a menu	

Inherits from: Object : CocoaMenuItem

SCMenuItem and its siblings allow users to create custom menus. Many methods are defined in its superclass.

See also: CocoaMenuItem, SCMenuGroup, SCMenuSeparator


Creation

	*new (parent, name, index)
	
		Create a new menu item.
		parent - The parent menu. The default value is nil, which indicates the application menu.
		name - A String indicating the label for this menu item.
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


