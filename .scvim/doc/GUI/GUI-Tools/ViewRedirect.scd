ViewRedirect			an abstract super class for gui redirection classes	

Inherits from: Object

See also: GUI, GUI-Classes, GUI-Overview

For a current list of subclasses see GUI-Classes

You will never call this class directly, but will only call its subclasses.
ViewRedirect is the abstract superclass of all gui redirect classes. These subclasses in turn use the GUI.myView mechanism to redirect to the currently active gui kit. ViewRedirect's subclasses provide a simple syntax for creating gui views and widgets, while transparently making the code work with different gui kits.

Each subclass uses a *key class method to return a key appropriate to the desired GUI redirect method:

MyGUIClass : ViewRedirect { *key { ^\myGUIClass }}

Accessing Instance and Class Variables
	
	*redirectQueries_(bool)
	*redirectQueries
		
		bool is a Boolean indicating whether or not openClassFile queries will redirect to the active implementation class (Cocoa or Swing). The default is false.





