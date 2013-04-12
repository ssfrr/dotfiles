SuperCollider autocompletion

The autocompletion feature described in this document is available in the OSX version only. It uses the keyDownAction feature of CocoaDocument to intercept keystrokes and open the autocompletion interface when specific characters are typed. That feature is not available in all platforms.

The SCEL interface in Linux has its own autocompletion function, accessed by typing <ESC> <TAB>.

Autocompletion is not available in the Windows version as of this writing.

Another way to get information about classes and methods is the class browser, accessed by calling ".browse" on a class, e.g. Object.browse. The browser is available in the OSX version, as well as any platform where SwingOSC (http://www.sciss.de/swingOSC) is installed.

Usage:

To open a text window with the auto-complete feature enabled, execute the following in SuperCollider:

Document.autoComplete

(ac is a shortcut for Auto-complete, to make it easier to type.)

To open a file by pathname:

Document.openFileAutoComplete("myPath.rtf");
Document.openFileAutoComplete("*.sc");	// wildcards are supported

To bring up an open-file dialog:

Document.openAutoComplete

Autocompletion will be integrated more tightly into the code editor.

Summary:

While editing code in an auto-complete code window, the following keystrokes initiate special actions:

( -- attempt to match the preceding identifier to method names containing that string, and display a list of methods with their defining classes. Making a selection will insert a method template into your document.

( will also match classnames, with the .new method: Rect( will show you a method template for Rect-*new.

. -- attempt to match the preceding identifier to an exact class name, and present a list of class methods (not instance methods). Your selection will insert a method template into the document.

ctrl-. -- attempt to match the preceding identifier to class names containing the identifier, and present a list of those class names. Your selection will open a class browser. You can navigate through the class tree to find the method you want, and press enter in the method list to insert a method template.

Shortcut in the class browser: type ^ in the method list to go to the superclass. This allows speedier location of methods inherited from superclasses.

Special behavior for ctrl-. -- when you choose a method in a class browser, its class will be compared to the class you chose in the opening list. If the initial class responds to the method, the initial class will be put into the document; otherwise, the class from the class browser.

Feature description:

When you type a dot, SuperCollider will to check the previous text to see if it refers to a valid class. If so, a window will be presented with all the class methods (not instance methods) of the class.

So, for example, if you type:

SinOsc.

the window will display the options:

ar(freq, phase, mul, add)
buildSynthDef()
buildSynthDef_()
....

If you type the first few letters into the text box, the list will reduce itself to the matching entries. If you type 'a', then the list will contain only:

ar(freq, phase, mul, add)

Press enter or return, and the method name with all its arguments will be added to your document, leaving the text:

SinOsc.ar(freq, phase, mul, add)

You can also click on the item you want in the list (or move through the list with the up and down arrow keys), and then press return.

Pressing escape or closing the window will cancel the auto-complete. Text typed into the text box prior to canceling will be added to the document--so, if you keep typing while the box comes up and you want to ignore it, your text will not be lost.

Similar behavior for method names: when you type an open parenthesis '(', SuperCollider will display a list of all classes that define this method. Type the first few letters of the class name (don't forget to capitalize) to choose the right one.

This treatment is necessary because variables in SuperCollider are not typed. If you enter 'func.value(', the text editor has no way to know what kind of object will be contained in func at the time of execution. So, it presents you with all possible options and allows you to choose.

New: The autocompleter now supports partial string matching for methods (triggered by typing open-paren) and classes (not by typing dot, but by typing ctrl-dot). In the case of classes, you will be given a list of classes matching the string typed. After you choose from the list, a full class browser will be opened. When you select a method and press enter, a method template will be dropped into the current document.

Because the class browser does not show methods defined by superclasses, you may press ^ to go to the superclass.

Further configuration:

Use the startup file (see Using-the-Startup-File) to define class names and method names to be excluded from the browsers. I like to exclude the most common flow of control mechanisms (while, do, if, etc.).

AutoCompMethodBrowser.exclude([\if, \do, \while, \loop, \collect, \select, \reject, \detect, \add, \put, \at]);

AutoCompClassBrowser.exclude([... list of classes ...]);

Quirks and caveats:

The auto complete features will be lost from all documents when recompiling the class library.

The method browser does not handle inheritance. If you're browsing a method like 'add', you won't find Array in the list (but you will find its superclass ArrayedCollection).


