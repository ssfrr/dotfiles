Quark

see Quarks first

A Quark is a package of SC classes, helpfiles, C++ source for UGens and other SC code.

A Quark object is created from the quark file found in {Application Support}/quarks/DIRECTORY

These Quark objects are mostly used just by the Quarks class, and you usually don't need to deal with them at all.

But to publish a quark,  you do need to make the quark file.

Format of the .quark File

This quarkfile is written in sc code, and should contain a dictionary with basic information about the package.

(
// required:
	\name: 		"theName",
	\path: 		"foldername", // almost always the same as the quark name
	\summary:		"Human readable summary",
	\author: 		"My Name",

// optional:
	\version:		1.0, // must be a float
	\organization: 	"My Organization",
	\country: 		"My Country",
	\since: 		"2004",
	\helpdoc: "theName.html",
	\ext_dependancy: "Information on additional software needed to run this quark properly",
	\url:           "http://www.strangeQuark.de",

// If the quark depends on other quarks, you can specify it as a list containing:
// (1) strings (just the quark name)
	\dependencies: "nameOfDependantQuark"
// (2) key->value pairs (name->version)
//	\dependencies: [("nameOfDependantQuark" -> 1.0)]
// or (3) arrays with info in this order: [name, version, repositoryBaseUrl]
//	\dependencies: [["nameOfDependantQuark", 1.0, "https://svn.weirdserver.be/trunk/weirdquarks"]]

)

Of particular importance for the Quarks interface class is the PATH.  This is the path relative to the quark directory.  In most cases this is simply the name of the quark and also the name of the folder.  

However, you may wish to create a parent folder and then keep several quarks inside that, in which case your path would be : parentfolder/quarkname

It may even be possible to nest quarks inside of quarks (a kind of aggregate package), though a better way to do that would be to define an empty quark (the aggregate) and specify the other sub quarks as dependencies.

Please test that you don't have any syntax errors in your quark file before commiting it.
Thank you.




