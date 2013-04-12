AutoClassHelper			autogeneration of help files from source code markup	

Inherits from: Object

AutoClassHelper generates an help file following the help template by analyzing the source code of the passed class (e.g. like Doxygen). This is possible by using a special markup syntax in the source code. It works only for classes. In fact, UGens require a much simpler help file and the mechanism does not make sense for Topics: in those cases you can simply use Helper.

See also: Helper

Some Important Issues Regarding AutoClassHelper

AutoHelper is still experimental and you should use it following strictly the syntax examples and explanations provided in the source code of the fake test class AutoClassHelperTest. In order to understand what follows you should open its class definition. You see that the markup tag is a special multiline comment: 

/*@
infos here
@*/

Each class can receive a class description (after its name) where all the infos required by class help template can be filled in by a specific tag (e.g. shortDesc) followed by :. In the class field you also describe var and classvars. one for each line (e.g. classtestvar)  followed by :.

// After class name you can write
/*@
shortDesc: description of the method
longDesc: longer one
seeAlso: refs
issues: other aspects
testvar: a name of a instance var
classtestvar: a name of a class var
instDesc: the name of the instance methods section
longInstDesc: a comment related to the instance methods section
@*/
//

Then each method can be marked up with a description of functionality, followed by a description of each argument. Then, multiline examples can be inserted. 

// After each method you can write
/*@
desc: a description of the method
argName: for each arg. Default value is added automatically
ex: multiline example
@*/

See AutoClassHelperTest source.
Note that more typically you simply pass the item to the makeAutoHelp method of Help class (see Examples below).

Creation / Class Methods

	*new (undocumentedClass, path)
	
		The only method implemented by AutoClassHelper, it generates an help file.
		undocumentedClass - the class to be documented. Default value is nil. 
		path -  the path where to write the help file. Default value is nil: in that case you are prompted to select a path by a dialog. After creation SC tries to reopen the file by calling undocumentedClass.openHelpFile, so the path should be searchable by SC. The file is written even if opening fails.  See Helper.
		
		// testing the fake class: evaluate this
		AutoClassHelper(AutoClassHelperTest) // prompts for a path 
		// in order to reopen the file choose a recognized path for help files
		// e.g. simply "Help" in the SC folder


Examples

// the same using Help.makeAutoHelp 
Help.makeAutoHelp(AutoClassHelperTest) // prompts for a path


