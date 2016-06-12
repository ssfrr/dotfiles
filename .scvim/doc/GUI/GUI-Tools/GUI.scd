GUI			Factory abstraction for all GUI related core classes	

Inherits from: Object

See also: GUI-Classes, GUI-Overview, ViewRedirect

The GUI class provides a means of writing cross platform gui code. GUI provides Factory abstraction for all gui related core classes. Each gui kit is described by a gui scheme which maps class names to actual classes. These schemes are in turn used by ViewRedirect to provide a simple cross-platform gui syntax. It also provide utilities for switching kits and other cross platform tasks. You can get your available schemes (depending on what you installed) with:

GUI.schemes;

For a complete list of gui classes and redirects, see GUI-Classes.

Switching and Referring to GUI Kits

As of this writing, two GUI kits are available through the GUI class: CocoaGUI (Mac OS X native) and SwingGUI (Java) . Note that SwingOSC is not part of every SuperCollider distribution, so you may have to install it separately.

You can switch the GUI kit by calling one of the following class methods:

GUI.cocoa;	// use cocoa in subsequent GUI creation procedures
GUI.swing;	// use swing in subsequent GUI creation procedures
			// NOTE: If you do not have SwingOSC installed, you get
			// a warning only, and do not switch; so you cannot
			// accidentally disable your (mac) gui system.
	
These methods return the new GUI kit implementation. The current implementation can be queried by calling

GUI.current;	// returns the current GUI kit implementation

If you want to make a GUI kit specific switch (e.g. in a class), then you should use the following instead, as on non-OSX systems the class CocoaGUI is not in the class library path, and you cannot check for an undefined class:

GUI.id;	// returns the current GUI kit implementation id; this is currently either \cocoa or \swing

For persistency, you can store the identifier of the kit implementation and recall the kit through the class method fromID:

x = GUI.cocoa;
y = x.id;				// store the identifier of a kit implementation
y.postln;				// ; the id could be stored in a preferences file for example
GUI.swing;
// now switch back to the kit implementation with identifier y
GUI.fromID( y );
GUI.current.id.postln;	// --> cocoa

The *use and *useID methods allow you to temporarily switch the kit, so as to use it only for a dedicated block of statements:

GUI.cocoa;
GUI.useID( \swing, {Array.rand( 1000, 0.0, 1.0 ).plot });
GUI.current.id.postln;	// --> still cocoa

You can get a particular kit using the *get method. You can switch to a particular kit using the *set method:

x = GUI.get( \swing );	// note: unlike *swing and *cocoa, this does not _switch_ the current kit!
GUI.current.id.postln;	// --> still cocoa
GUI.set( x );			// now we make SwingOSC the current kit
GUI.window.viewPalette;

Extending GUI Kits

GUI Kits can be extended with custom classes by using their respective .put methods:

GUI.get( \cocoa ).put( \myText, SCStaticText );
GUI.get( \swing ).put( \myText, JSCStaticText );

GUI.cocoa;
GUI.swing;
(
	w = GUI.window.new;
	GUI.myText.new( w, w.view.bounds.insetBy( 20, 20 )).string_( "schoko" ).background_( Color.red );
	w.front;
)

If you intend to add extensions from within your own classes upon class library initialization time, the preferred way is to do this in the startup process:

MyGUIExtension {
	*initClass {
		StartUp.add({
			var scheme;
			
			scheme = GUI.get( \cocoa );
			if( scheme.notNil, {scheme.put( \myText, SCStaticText )});
			scheme = GUI.get( \swing );
			if( scheme.notNil, {scheme.put( \myText, JSCStaticText )});
		});
	}
}

Methods and Variables for GUI

	*new (key)

	*makeGUI (key, args, properties)


	*initClass
	
		Sets the skin to default values on Compile.				
				fontSpecs: 	["Helvetica", 10],
				fontColor: 	Color.black,
				background: 	Color(0.8, 0.85, 0.7, 0.5),
				foreground:	Color.grey(0.95),
				onColor:		Color(0.5, 1, 0.5),
				offColor:		Color.clear,
				gap:			0 @ 0,
				margin: 		2@2,
				buttonHeight:	16

	*cocoa
	
		Makes Cocoa (Mac OS X GUI) the current scheme and returns it. Subsequent GUI object calls to GUI are delegated to cocoa. Returns the current (cocoa) scheme.
		

	*swing
	
		Makes Swing (Java GUI) the current scheme and returns it. Subsequent GUI object calls to GUI are delegated to swing. Returns the current (swing) scheme.
		
	*fromID (id)
	
		Changes the current scheme and returns the new scheme.
		id - (Symbol) the identifier of the scheme touse

	*current
	
		Returns the current scheme. This is useful for objects that, upon instantiation, wish to store the then-current scheme, so as to be able to consistently use the same scheme in future method calls.
		
		Note: the caller shouldn't make any assumptions about the nature (the class) of the returned object, so that the actual implementation (an Event) may change in the future.

	*get (id)
	
		Returns the scheme for a given identifier. Does not switch the current scheme.
		id - (Symbol) the identifier of the scheme to retrieve, such as returned by calling aScheme.id
		
	*set (aScheme)
	
		Changes the current scheme.
		aScheme - An instance of Symbol. The scheme to use as current scheme
		
	*use (aScheme, func)
	
		Executes a function body, temporarily setting the current GUI scheme. This is useful inside view's action functions in order to make this function use the GUI scheme that was originally used for the view of the action, even if the scheme has been switched meanwhile.
		aScheme - The scheme to use during the function execution.
		func - An Instance of Function.

	*useID (id, func)
	
		Same as 'use' but using a scheme's id as first argument.
		id - The id of the scheme to use during the function execution.
		func - A body to execute.
		
	*add (aScheme)
	
		Registers a new scheme. This is typically called by external libraries in their startup procedure. If a scheme with the same identifier (scheme.id) exists, it is overwritten.
		aScheme - The scheme to add.
		
	*doesNotUnderstand (selector, args)
	
		All method calls are mapped to the current scheme, so that for example GUI.button can be used and is delegated to the button association of the current scheme.
		
	*setSkin (skinName)
	
	
	*scheme
		
		A class variable. Returns the current scheme.
				
	*schemes
		
		A class variable. Returns an IdentityDictionary of registered schemes.
				
	*skin
		
		A class variable. Returns the current skin.
				
	*skins
		
		A class variable. Returns an IdentityDictionary of registered skins.
				


