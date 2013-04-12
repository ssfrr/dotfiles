Helper			documentation template autogeneration	

Inherits from: Object

Helper allows to autogenerate a documentation template for classes, ugens, topics.
The resulting file strictly follows the provided templates styles, so that you have to worry only about content and not about formatting. 
Note that for consistency you should always use this class while creating help files. 

See also: Documentation Style Guide

Helper structure

Helper class works by inspecting the argument passed to the constructor. It then calls three other  classes specialized for classes, ugens and topics (ClassHelper, UGenHelper, TopicHelper).  TopicHelper is selected if you pass a string (i.e. the topic you want to discuss).
Each of them is given a makeHelp method which generates the help file template. In case of classes, this is done by analysing the source code and retrieving vars, methods, arguments, default values. If you have "private" methods, or other things you think that should not be documented, you have to delete their description from the help file.
Note that not only you do not have to deal with this structure but more typically you simply pass the item to the makeHelp method of Help class (see Examples below).

Please note that: 
- if you want to overwrite an existing help file you have to delete it or rename it before using Helper; 
- in order to reopen automatically the created file for editing, the path must be in one of the SC recognized paths.
- in order to reopen automatically the created file for editing, the name must be the one of the class to be documented.
Please note also that in all the previous cases  the requested file is created.

Creation / Class Methods

	*new (undocumentedObject, path)
	
		Write the helpfile by selecting the specialized class. Then it tries to reopen the generated help file
		undocumentedObject - the item you want to document. Default value is nil. The method select the opportune specialized Class, and sends to its instance the makeHelp message.
		 path - the path where to write the help file. Default value is nil: in that case you are prompted to select a path by a dialog. After creation SC tries to reopen the file by calling undocumentedObject.openHelpFile. See Examples for requirements.
		
		// of course we can document better this class
		h = Helper.new(Helper); 

Examples

//////////
// CLASSES
//////////

Helper(TestClass2, "/Users/andreavalle/Library/Application\ Support/SuperCollider/Extensions/Help/mine/TestClass2.html")
// TestClass2: a test class
Helper(TestClass2)
// prompts for path (must be complete).

Helper(TestClass2, "/test/TestClass2.html")
// this works but then it can't open the resulting help file
// in order to reopen it automatically, the provided path
// must be one of the recognized ones

//////////
// UGENS
//////////

Helper(SinOsc, "/Users/andreavalle/Library/Application\ Support/SuperCollider/Extensions/Help/mine/SinOsc.html")
Helper(SinOsc)
// In this case SinOsc has already a help file, so Helper opens that one 
// as it calls SinOsc.openHelpFile

//////////
// TOPICS
//////////

Helper("On_Helper", "/Users/andreavalle/Library/Application\ Support/SuperCollider/Extensions/Help/mine/On_Helper.html")
Helper("On_Helper")
// it's a bit boring to repeat the class or the topic name with html as a path
// but I don't see a way to propose to GUI save dialog a fileName, so in that case you would have
// to specify it the same. 
// Document was indeed more flexible

// instead of direct instantiantion 
// you may typically use makeHelp  method on the Help class:
// Help.makeHelp wraps the Helper class for you

// TYPICAL USAGE with Help extension
// The same as before
// an undocumented class
Help.makeHelp(ClassHelper); 
// an undocumented topic
Help.makeHelp("On the Helper class"); 
// an undocumented UGen
Help.makeHelp(HilbertFIR); 




