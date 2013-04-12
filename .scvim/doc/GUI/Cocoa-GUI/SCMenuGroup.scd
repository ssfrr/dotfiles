SCMenuGroup			represents a named submenu	

Inherits from: Object : CocoaMenuItem

SCMenuGroup and its siblings allow users to create custom menus. Many methods are defined in its superclass.

See also: CocoaMenuItem, SCMenuItem, SCMenuSeparator

Creation

	*new (parent, name, index)
	
		Create a new sub-menu.
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


