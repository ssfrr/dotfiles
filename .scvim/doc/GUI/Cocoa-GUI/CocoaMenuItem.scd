CocoaMenuItem			abstract superclass of OSX Menu Items	

Inherits from: Object

CocoaMenuItem represents a menu item or sub menu in the application menu. This is an abstract class. Generally you will deal with the subclasses SCMenuItem, SCMenuGroup, and SCMenuSeparator, but the convenience method *add (see below) allows one to easily add items to a default 'Library' menu.

See also: SCMenuItem, SCMenuGroup, SCMenuSeparator

Class Methods

	*clearCustomItems
	
		Clear all custom menu items.
		
	*default
	
		Returns the 'Library' menu, creating it if necessary.
		
		
	*add (names, action)
	
		Add an item to the Library menu. The Library menu will be created automatically if needed.
		names - An Array of Strings indicating the menu path to this item.
		action - A Function that will be evaluated when this item is selected.


Instance Methods
	
	action_(actionFunc)
	action
		
		Get or set this item's action. This is a Function that will be evaluated when this item is selected.
				
				
	state_ (bool)
	state
		
		Get or set this item's state. If bool is true a check mark is displayed next to the item.
				
				
	remove
	
		Remove the receiver and its children (if any).


	enabled_ (bool)
	
		Enable or disable this menu item.
		bool - A Boolean indicating whether this item should be enabled or disabled.


	setShortCut (string, alt, ctrl)
	
		Set the keyboard shortcut for this item. The Cmd key is assumed.
		string - A String indicating the character for this shortcut.
		alt - A Boolean indicating whether the alt key is included in this shortcut. Default value is false.
		ctrl - A Boolean indicating whether the ctrl key is included in this shortcut. Default value is false.


	doAction
	
		Evaluate the receiver's action function.



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

// using *add	
CocoaMenuItem.add(["hallo", "world"], { "hallo menu".postln });
CocoaMenuItem.add(["hallo", "world", "here"], { "hallo here".postln }); // fails correctly
CocoaMenuItem.add(["mellow", "world", "here"], { "mellow here".postln }); // works.
CocoaMenuItem.add(["hallo", "thought"], { "hallo world".scramble.postln });

CocoaMenuItem.clearCustomItems;
	


		


