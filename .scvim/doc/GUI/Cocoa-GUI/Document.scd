Document			an abstract class for editor-specific text document editing classes	

Inherits from: Object

The Document class represents a text document within the context of your text editing environment. You can use the class to programmatically create, modify, and query these documents. While it is an abstract class, you still use it to create a new Document. It simply passes on new to the appropriate document implementation, e.g. CocoaDocument.

See also: CocoaDocument

Some Important Issues Regarding Document

Different text-editing environments can be used with SuperCollider. Therefore Document is an abstract class, meaning it doesn't provide all the functionality itself, but relies on subclasses to complete the functionality. Calls to Document.new or Document.open are actually passed down to the relevant class for the editor you're using, such as CocoaDocument (for most Mac users) or ScelDocument (containing an EmacsDocument).

Setting the Environment

By defualt envir it is set to the current Environment. However, you can make it use its own Environment also. Thus, e.g., if you were to set the Environment variable ~myVar=12 in the current Environment, you can create a new Document window in which that Environment variable is not set.

Creation / Class Methods

	*new (title, string, makeListener, envir)
	
		title - An instance of String or Symbol. Default value is "Untitled".
		string - An instance of String . Default value is "". The contents of the document.
		makeListener - Makes this document the lisenter, i.e. the place where SC-lang posts messages. Default value is false. .
		envir - An instance of Environment. The Environment to be used by the interpreter of the document window. By defualt, it is set to the current Environment.
		
		Document.new("this is the title", "this is the text");
		
	*open (path, selectionStart, selectionLength, envir)
	
		Open a document from a path.
		path - The file system path to the document. An instance of String.
		selectionStart -The beginning of the cursor seleciton of the file content. Default value is 0.
		selectionLength - The length of the cursor seleciton of the file content. Default value is 0.
		envir - An instance of Environment. The Environment to be used by the interpreter of the document window. By defualt, it is set to the current Environment.
		
		Document.open("README", 292,253); // notice the selected text in the open document


	*openDocuments
	
		Returns an Array of all open documents.
		
		d=Document.openDocuments.do{|doc| doc.name.postln};

	*hasEditedDocuments
	
		Returns true if there are edited Documents.
		
	*closeAll (leavePostWindowOpen)
	
		CAUTION Closes all open Documents, whether edited or not.
		leavePostWindowOpen - An instance of Boolean. Default is true.
		
	*closeAllUnedited (leavePostWindowOpen)
	
		Closes all unedtited Documents.
		leavePostWindowOpen - An instance of Boolean. Default is true.

	*current
	*current_(arg1)
	
		Gets/sets the current Document.
		
		Document.current.name.postln; // Prints "Document.html"

	*listener
	
		Returns the current Document which is the listener, i.e. the Document where interpreter messages are posted.

	*storePostWin (path)
	
		Stores the conteng of Document.listener.
		path - The file system path. An instance of String.
		
	*allDocuments
		
		A class variable. Returns all documents
		Default value is defaultValue.
				
	*globalKeyDownAction
	*globalKeyDownAction_(arg1)
	
		A class variable. Get/set A global action to be performed when a key is pressed.
		arg1 - An instance of Function or FunctionList.

	*globalKeyUpAction
	*globalKeyUpAction_(arg1)
		
		A class variable. Get/set A global action to be performed when a key is released.
		arg1 - An instance of Function or FunctionList.
				
	*initAction
	*initAction_(arg1)
		A class variable. Get/set A an action to be performed up openning or creating a Document.
		arg1 - An instance of Function or FunctionList.
				
	*autoRun
	*autoRun_
	
		A class variable. If a document begins with the String, "/*RUN*/", then the code following it int he file will be executed on opening the file, if autorun is set to true.
		arg1 - An instance of Boolean. Default value is true.
				
	*wikiBrowse
	*wikiBrowse_(arg1)
		
		A class variable. If set to true, underlining text will create a wiki link.
		arg1 - An instance of Boolean. Default value is true.
				
	*implementationClass
	*implementationClass_(arg1)
		
		A class variable. The editor implementation specific class which will handle Documents.
		arg1 - A class for implementing Document, e.g. CocoaDocument
		
	*setTheme(arg1)
		
		Sets the theme for syntax colorization. The Document class has a preset theme called 'default',
		which is set as follows (default SC colors):
			
			themes = (
				default: (
					classColor: Color(0, 0, 0.75, 1),
					textColor: Color(0, 0, 0, 1),
					stringColor: Color(0.375, 0.375, 0.375, 1),
					commentColor: Color(0.75, 0, 0, 1),
					symbolColor: Color(0, 0.45, 0, 1),
					numberColor: Color(0, 0, 0, 1)
					)
			);
			
		If you want to have your own themes for syntax colorization, you need to put your color set into
		Document.themes first (preferably in startup.rtf file) and call setTheme by giving it the name of
		the theme you've added to "themes" earlier:
		
			//putting a custom color theme into Document.themes
			Document.themes.put
			(\myTheme, 
				(
					classColor: Color.new255(53, 74, 187),
					textColor: Color.new255(0, 0, 0),
					stringColor: Color.new255(96, 129, 158),
					commentColor: Color.new255(206, 27, 28),
					symbolColor: Color.new255(57, 154, 20),
					numberColor: Color.new255(157, 80, 65)
				)
			);
			
			//and then calling setTheme with the name:
			Document.setTheme('myTheme');
			//to see the current theme:
			Document.theme;
			
		You can switch to the default theme anytime by calling:
		
			Document.setTheme('default');
			
		Next time you invoke syntaxColorize, the color theme set by setTheme will be used for syntax
		colorization. If you want to change the background color for the document window and selected
		text, in order to make them fit with your syntax colorization theme, see the help for the "background" and "selectedBackground" methods for Document.
		
		arg1 - A Symbol, defining the name of the theme that you've put into Document.themes.

Path Utilites
	Utilities and settings for dealing with documents such as super collider code files. By default the document directory is SuperCollider's application directory.

	*dir
	*dir_ (path)
	
		Get/set the default document directory. The default is dependent on Document.implementationClass.
		path - The file system path to the directory. An instance of String.
		
		In Main-startUp you can set this to a more practical directory:
		
		Document.dir = "~/Documents/SuperCollider";
		
	*wikiDir
	*wikiDir_ (path)
	
		Get/set the default wiki directory. The default is dependent on Document.implementationClass.
		path - The file system path to the directory. An instance of String.
		

	*standardizePath (p)
	
		If it is a relative path, expand it to an absolute path relative to your document directory.	Expand tildes in path (your home directory), resolve symbolic links (but not aliases). Also converts from OS9 macintosh path format. See PathName for more complex needs.
		path - The file system path to the directory. An instance of String.
		
		Document.standardizePath("~/");//This will print your home directory	
		
		Document.standardizePath(":Patches:newfoots:fastRuckAndTuck")
		
		// Returns: /Volumes/Macintosh HD/Users/cruxxial/Documents/SC3docs/Patches/newfoots/fastRuckAndTuck
	
		Document.standardizePath("~/Documents/SC3docs/Patches/newfoots/fastRuckAndTuck")
		
		// Returns: Patches/newfoots/fastRuckAndTuck
		
		Document.standardizePath("Patches/newfoots/fastRuckAndTuck")
		
		// Returns: Patches/newfoots/fastRuckAndTuck


	*abrevPath (path)
	
		Returns a path relative to Document.dir, if the path is inside Document.dir.
		path - The file system path to the directory. An instance of String.

General Document Properties

	bounds
	bounds_ (argBounds)
	
		Get/set the bounds of the document.
		argBounds - an instance of Rect.

	path
	path_ (apath)
	
		Get / set the the Document's path.
		apath - An instance of String. A files system path.
		
		Document.current.path.postln;
		
	dir
		Returns the directory of a Document.
		
		Document.current.dir.postln;
		
	== (doc)
	
		A binary operator.
		doc - An instance of Document.
		
		Document.current == Document.listener; //presumaably returns false
		
	editable
	editable_(abool)
	
		Get / set the the document is editable.
		arg1 - An instance of Boolean.

	name
	name_ (aname)
	title
	title_ (argName)
	
		Get / set the title.
		aname/argName - An instance of String.
		
		Document.current.name.postln
		
	background
	background_ (color)
	
		Get / set the the Document's background color.
		color - An instance of Color;
		
		(
		a = Document("background", "'hardly see anything");
		a.background_(Color.blue(alpha:0.8)); // notice that alpha controlls th window transparency
		)
		
	postColor
	postColor_ (color)
	
		Get / set the listeners pen color.
		color - An instance of Color;
		
		Document.postColor; //returns current post color
		Document.postColor_(Color.red);
		Document.postColor_(Color.green);
		Document.postColor_(Color.blue);
		Document.postColor_(Color.black);
		(
		r = Routine({ 
			10.do({
				Document.postColor_(Color.rand);
				"There is no blue without yellow and without orange.".postln;
				0.5.rand.yield;
			});
			Document.postColor_(Color.black);
		});
		)
		
		r.play;
		r.stop;

	alwaysOnTop
	alwaysOnTop_ (boolean)
	
		Get/set whether a document is always on top.
		boolean - An instance of Boolean.

	promptToSave
	promptToSave_ (bool)
	
		Get/set whether a document is prompts to save if it has been changed. Use this with caution.
		bool - An instance of Boolean.

	closed
	
		Returns true if the document has been closed
		
	isEdited
	
		Returns true if the document has been edited.
		
		Document.current.isEdited.postln;

	isFront
	
		Returns true if the document is in front.
		
	isListener
	
		Returns if the document is the listener.
		
	didBecomeKey
	
		Saves the current Environment, makes the document current, and performs its toFrontAction.

	didResignKey
	
		Performs the Document's endFrontAction and restores the current Environment.

Controlling Document

	close
	
		Close a document.
		
		(
		Task({
			var doc;
			doc = Document("background", "closing in 2 seconds");
			doc.stringColor_(Color.blue);
			1.wait;
			doc.background_(Color.blue(alpha:0.8));
			1.wait;
			doc.close;
			}).play(AppClock);
		)

	front
	
		Bring a document to the front.

		Document.listener.front


	unfocusedFront
	
		Bring a document to the forn without focusing it.
		
		Document.listener.unfocusedFront

	onClose
	onClose_(arg1)
		
		Get / set the action to be performed on closing the document.
		arg1 - An instance of Function or FunctionList .
				
	endFrontAction
	endFrontAction_(arg1)
		
		Get / set the action to be performed when the document becomes no longer the front document.
		arg1 - An instance of Function or FunctionList .
				
	toFrontAction
	toFrontAction_(arg1)
		
		Get / set the action to be performed when the document become the front document.
		arg1 - An instance of Function or FunctionList .
		
	mouseDownAction
	mouseDownAction_(arg1)
	mouseUpAction
	mouseUpAction_(arg1)
	
		Get / set the action to be performed on mouseDown or mouseUp.
		Note: The Mac OSX built-in editor supports only mouseUpAction. A mouseDownAction that you supply will be ignored.
		
		arg1 - An instance of Function or FunctionList The arguments passed to the function are.
		
			x, y, modifiers, buttonNumber, clickCount, clickPos

			(
			
			//add a mouse action to this document:
			//example: easy button:
			//when you click in front of a 17 a SinOsc will start up;
			s.waitForBoot({	
				Document.current.mouseUpAction_({arg doc;
					var char;
					char = doc.rangeText(doc.selectionStart, 2);
					if(char == "17",{
						{EnvGen.kr(Env.perc, doneAction:2) * SinOsc.ar([600,720,300].choose, 0, 0.5)}.play;
					});
					if(char == "23",{
						{EnvGen.kr(Env.perc, doneAction:2) * PinkNoise.ar(0.2)}.play;
					});
				})
			});
			)
			test here and click in front of the number:
					17
					23
			Document.current.mouseUpAction=nil; //clear mouseUpActiont
		
	keyDownAction
	keyDownAction_(arg1)
	keyUpAction
	keyUpAction_(arg1)
	
		Get / set the action to be performed on keyDown or keyUp.
		arg1 - An instance of Function or FunctionList The arguments passed to the function are		
		char, modifiers, unicode,keycode

		Document.current.keyDownAction={arg ...args; args.postln};
		// now type some text
		Document.current.keyDownAction=nil;
		
	makeWikiPage (wikiWord, extension, directory)
	
		Creates a wiki page .
		wikiWord - An instance of String. The name of the document.
		extension - An instance of String. The file extension. Default value is ".rtf".
		directory - An instance of String. The directory in which to save the page.
		
		Document.current.makeWikiPage("test1");


	openWikiPage
	
		Opens/creates a wiki page out of the currently selected text.
		
Editing Content

	selectLine (line)
	
		Select a line of the document by number.
		line - An Integer.
		
		Document.current.selectLine(390);
		
	selectRange (start, length)
	
		Select a text range in the string of the document
		start -The start index.
		length - The length of the seleciton.
		
		(
		Document.current.selectRange(Document.current.selectedRangeLocation+3,
			150);
		)
		
	balanceParens (level)
	
		Starting from the current selection, increase the selection 
		until matching parentheses are selected.
		level - do this as many times to find ever wider brackets. Set to inf for outmost.
		
		((((
		Document.current.balanceParens(1);
		Document.current.balanceParens(3);
		Document.current.balanceParens(inf);
		))))

	selectionStart
	
		Returns the start of a current selection.
		
		Document.current.selectionStart.postln;

	selectionSize
	
		Returns the size of a current selection.
		
		(
		var doc;
		doc = Document.current;
		doc.selectRange(doc.selectionStart-40, 10);
		doc.selectionSize.postln;
		)	

	selectedString_ (txt)
	selectedString
	
		Gets/sets the selected string.
		txt - An instance of String.
		
		(
		var doc;
		doc = Document.current;
		doc.selectRange(doc.selectionStart-40, 10);
		doc.selectedString.postln;
		)	
			
	currentLine
	
		Returns the current line as a String.
		
		(
		var doc;
		doc = Document.current;
		doc.selectRange(doc.selectionStart-40, 10);
		doc.currentLine.postln;
		)
		
	getSelectedLines(rangestart, rangesize)
	
		Returns all full lines from before rangestart to after rangestart + rangesize as a String.
		
		(
		var doc;
		doc = Document.current;
		doc.selectRange(doc.selectionStart-40, 10);
		doc.getSelectedLines(doc.selectionStart-40, 130).postln;
		)

	string (rangestart, rangesize)
	string_ (string, rangestart, rangesize)

		Gets/sets the string within a certain range.
		string - Explanation of string. Default value is nil. Other information.
		rangestart - An integer. Default value is nil.
		rangesize - An integer. Default value is 1.
		
		// Select the following code in parentheses and execute it
		(
		Document.current.string_(": test test test test test ",
			Document.current.selectedRangeLocation+12,
			18);
		)
		// Watch me change content
	
	font_ (font, rangestart, rangesize)
	
		Gets/sets the font within a certain range.
		font - An instance of Font.
		rangestart - An integer. Default value is -1. If rangestart = -1, the whole document is selected.
		rangesize - An integer. Default value is 0.
		
		// Select the following code in parentheses and execute it
		(
		Document.current.font_(Font("Impact",14),
			Document.current.selectedRangeLocation+12,
			18);
		)
		// Watch me change font
		
	stringColor
	
		Gets the last color set with stringColor_.

	stringColor_ (color, rangeStart, rangeSize)
	
		Sets the string color of a specific range of already printed text. Default is the whole document.
		To set the listener text color for posting, see: postColor
		color - An instance of Color.
		rangeStart - An Integer. Default is -1.
		rangeSize - An Integer. Default value is 0
		
		// Select the following code in parentheses and execute it
		(
		Document.current.stringColor_(Color.rand(0.2,0.8),
			Document.current.selectedRangeLocation+13,
			16);
		)
		// Watch me change color
	
	selectedBackground
	
		Gets the document's background color for selected text.

	selectedBackground_ (color)
	
		Sets the document's background color for selected text.
		Applies to the whole document instance.
		color - An instance of Color.
		
		Document.current.selectedBackground; //returns default color
		(
		w = Document.new("Test", "Here is a selected text...");
		w.selectedBackground_(Color.new255(120, 180, 110));
		w.selectRange(10, 13);
		)

	syntaxColorize
	
		Syntax colorize a document.
		
	underlineSelection
	
		Underlines the current selection of a Document.		
			
Auto-Completion
	OSX version only, currently. See DocumentAutoCompletion

	*allowAutoComp
	*autoCompAll
	*autoComplete
	*autoCompleteKeyAction
	*openFileAutoComplete (path)
	*openAutoComplete
	autoComplete
	
	
Subclassing and Internal Methods
	The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed.
	
	*startup
	*numberOfOpen
	mouseUp (x, y, modifiers, buttonNumber, clickCount, clickPos)
	keyDown (character, modifiers, unicode, keycode)
	keyUp (character, modifiers, unicode, keycode)
	getIdentifierCoordFromEnd (endPos)
	dataptr
	
	Private. Used only internally:
	*newFromIndex (idx)
	*prnumberOfOpen
	*prGetLast
	*prGetIndexOfListener
	*prBasicNew
	prAdd
	prGetLastIndex
	setFont (font, rangeStart, rangeSize)
	setTextColor (color, rangeStart, rangeSize)	
	propen (path, selectionStart, selectionLength)
	rangeText (rangestart, rangesize)
	insertTextRange (string, rangestart, rangesize)
	prinitByString (title, str, makeListener)
	prSetBackgroundColor (color)
	prGetBackgroundColor (color)
	prSelectLine (line)
	prIsEditable_ (editable)
	prSetTitle (argName)
	prGetTitle
	prGetFileName
	prSetFileName (apath)
	prGetBounds (argBounds)
	prSetBounds (argBounds)
	prclose
	prinsertText (dataPtr, txt)
	prinitByIndex (idx)
	envir
	envir_ (ev)
	text
	removeUndo 
	selectedText
	selectUnderlinedText (clickPos)
	linkAtClickPos (clickPos)
	selectedRangeLocation
	selectedRangeSize
	restoreCurrentEnvironment
	saveCurrentEnvironment
	initByIndex (idx)
	initLast
	initFromPath (path, selectionStart, selectionLength)
	initByString (argTitle, str, makeListener)

Examples

//unfocusedFront_
(
Document.allDocuments.at(0).unfocusedFront
)


(

var doc;
doc = Document("", "||");
doc.background_(Color.blue(alpha: 1.0.rand));
Task({
	1000.do({
		doc.setFont(rangeSize: [7,8,9,24].choose);
		0.08.wait;
	})
}).play(AppClock);
Task({
	100.do({
		1.01.wait;
		doc.stringColor_([Color.red(alpha: 1.0.rand), Color.green(alpha: 1.0.rand)].choose);
	})
}).play(AppClock);
Task({
	100.do({
		1.01.wait;
		doc.selectedString_(["\"\n#","||","-", "--"].choose);
	})
}).play(AppClock);
Task({
	var co, mul;
	co = 0.1;
	mul = 1.02;
	100.do({
		0.16.wait;
		co = co * mul;
		if(co > 0.99, { co = 0.1 });
		doc.background_(Color.blue(alpha: co));
		});
	doc.close;
}).play(AppClock)

)



// a simple implementation of TBT (time based text)
// http://tbt.dyne.org/?info=download

// record: type some text
(
var time = Main.elapsedTime;
a = List.new;
r = Routine { |char|
loop {
a = a.add([char, Main.elapsedTime - time]);
char = 0.yield;
}
};

Document.new("type some text")
	.bounds_(Rect(100,SCWindow.screenBounds.height-250,400,200))
	.keyDownAction = { |doc, key| r.value(key) ; time=Main.elapsedTime};
)

// play back text in time
(
d=Document.new("type some text")
	.bounds_(Rect(550,SCWindow.screenBounds.height-250,400,200));
fork({
a.do { |pair|
d.string = d.string ++ pair[0];
pair[1].wait;
}
}, AppClock)
)



