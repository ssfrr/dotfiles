Crossplatform

When extending SuperCollider you may need to take care of cross platform compatibility. This help file tries to make you aware of the issues you need to watch out for.

Structure of SuperCollider

SuperCollider is composed of three or four programs. There is scsynth, sclang, the editor and optionally a GUI server.

On OSX most users use the SCapp, which is an editor, including GUI facilities. However, you can also use the GUI server SwingOSC, and may choose to use another editor (such as scel, scvim, or PsyCollider).

On Windows most users use PsyCollider or JSCEclipse and use the SwingOSC GUI server. Theoretically it is also possible to run scel or scvim on Windows.

On Linux most users use scel or scvim or sced (a gedit frontend) and use the SwingOSC GUI server. But they could also use JSCEclipse or PsyCollider.


Shortcuts
Each editor has its own shortcuts, which are documented in the Shortcuts helpfile.

GUI implementation
GUI's are made cross platform compatible by using ViewRedirects, or the GUI classes. So instead of using SCWindow, you use Window or GUI.window.new.

It may be tempting to create custom GUI objects by subclassing, but this is not good for cross-platform portability. To be truly cross-platform, there should be subclasses for the SC* set of GUI widgets (for the cocoa objects used by SCapp) as well as the JSC* set implemented by SwingOSC. A SCapp user who has not installed SwingOSC cannot use subclasses of the SwingOSC objects, because the parent class is not found in the library. The reverse is true for non-Mac users confronted with subclasses of the cocoa widgets (although this is avoided by placing Mac OSX-specific subclasses into a folder named osx/).

Instead, it's recommended to use the Adapter design pattern. Write a new class that creates an instance of the GUI widget whose behavior you want to extend, and include the new behavior in this class. The new class can forward messages to the physical widget where needed, or add new logic between the user's calls and the calls ultimately made to the widget. If the widgets used in the new class are created using the cross-platform view redirect or GUI kit, then it is automatically cross-platform without requiring multiple versions for different platforms.

(As a general object-oriented programming rule, subclassing is regarded with some suspicion because the objects' information is not as cleanly encapsulated when a system is built too heavily on subclasses. This is not limited just to GUI cross-platform concerns.)

If you want to make a GUI kit specific switch (e.g. in a class), then you should use the following instead, as on non-OSX systems the class CocoaGUI is not in the class library path, and you cannot check for an undefined class:

GUI.id;	// returns the current GUI kit implementation id; this is currently either \cocoa or \swing

Extension methods added to GUI objects

At present, extension methods added to, for instance, SCButton do not automatically transfer over to JSCButton. It's necessary to provide the extension for both classes. If the compiler finds an extension for a class that doesn't exist, a warning is printed while compiling the class library, but the interpreter will still function after that. In extensions that are published (e.g. as quarks), it's considered rude to litter the startup output with non-fatal warnings unless there is no other alternative.

One approach with quarks is to create a separate quark with the Swing-specific extensions, and include a compatibility test in the quark file.

(
	name: "quarkname",
	path: "...",
	... etc...
	isCompatible:	{ 'SwingOSC'.asClass.notNil }
)

Then the extensions can't be installed on systems without SwingOSC. OSX-specific extensions can be hidden on other platforms by placing them in a folder named osx/. This is not advisable for SwingOSC extensions because these extensions may need to be used on any platform -- it is not valid to restrict them to linux/ or windows/ platform folders.

Document implementation
Document forwards to an editor dependent class (CocoaDocument for SCapp and ScelDocument for scel). Of these CocoaDocument provides the most functionality, ScelDocument provides a partial set of features. For the other editors there is no Document support yet.

The post window is yet another cup of tea. In SCapp it is a Document like any other. In scel it is a separate window which catches stdout (standard output) of sclang. This is the same for the other editors, who either catch the output in a window internal to the editor, or externally (like scvim).

Menus
Menus are also editor specific, though they can also be added to SwingOSC windows.

Help files
Help files are generally HTML format. In SCapp they are viewed inside the editor and are regular Documents that are saved as HTML files when they are resaved. In scel they are opened in emacs-w3m in an sclang-minor-mode, so code can be executed from them. For scvim the help files are stripped of their HTML, so they can be opened within scvim as plain text files. Sced opens the help files in Firefox.

HID (Human Input Device)
HID support is also slightly platform dependent (not editor dependent!). There is a cross platform accessing class called GeneralHID. The only part which is not cross platform yet in that approach is the numbering of the slots, so these cannot be depended upon across platforms.

The Windows version of SC should use a python program IxiHID for now with SC to have a partial access to HID devices (only game devices and no output).

MouseX, MouseY, MouseButton and KeyState
Should work as is on different platforms.

WiiMote
Has been implemented for both OSX and Linux and have the same interface.

Wacom
Can be accessed on OSX through a separate interface. On Linux it can be accessed as an HID interface.

unixCmd
unixCmd works across platforms, but on Windows has to be a DOS command.

What to do? Platform specific extensions
So, now that you have created a class, what to do if it is not platform independent? Well...
SC implements a scheme to ensure that classes that are only valid for one specific platform are only compiled for that platform. This works by putting a class in a folder (anywhere in the SCClassLibrary or Extensions) named after that platform (osx/windows/linux). Note that this is case sensitive.



