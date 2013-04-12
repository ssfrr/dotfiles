More on Getting Help

	Note: This help file uses the key commands for OS X; on other systems, please substitute the Shortcuts as necessary 

Listed below are a few techniques for tracking down documentation and functionality. Note: If some of the terms used below (e.g. class, method, inheritance, etc.) are unclear to you, you may wish to read the Language helpfiles which are listed in the main help window for detail on some of these concepts. Reading a general tutorial on Object Oriented Programming at some point could also be useful, as could reading a FAQ, etc. about Smalltalk. Smalltalk is the general purpose OOP language upon which the the design of the SuperCollider language is based. Its syntax is different than SC's, but conceptually it has much in common.

NB: Be sure to check out the Further Info section at the bottom of this page.

Basics 				

As you've probably already learned selecting any text and pressing Cmd-d will open the corresponding helpfile. Usually helpfiles are either concept related, or document particular classes. In the SC language classes begin with capital letters. Try Cmd-d on the following (double click on the first word; the stuff after the two slashes is a comment):

Class // this is a class

A few methods also have helpfiles. Methods begin with lower-case letters, as do many other things in the language.

play // Cmd-d on this will open a helpfile detailing different implementations of this method

In addition there are a many helpfiles which explain important concepts. Most of these are listed in the main help window (Help.html, which will open if you press Cmd-d with no text selected), or in the overviews listed there. The file called Tutorial is one example.

Much documentation contains hypertext links to other helpfiles. Click the link to open the corresponding helpfile.

Note that many helpful methods print information to the 'post window'. Unless you have explicitly changed it (see the Window menu) this is the window which opened when you launched. Pressing Cmd-\ will bring the current post window to the front.

Tracking Down Information

Executing the following

Help.gui;

will open a "help browser" which lists all helpfiles in thematic categories. (Equivalently, press Shift-Cmd-D)

The helpfile Undocumented-Classes contains a (possibly out of date) list of all classes which have no helpfiles. This can be a good place to start looking for functionality which may already be implemented.

Looking in class definitions (select any class and press Cmd-j to open its class definition file) can help you to figure out what undocumented methods do.

Array // Try Cmd-j on this

Since many methods use other classes, you may need to continue your search in other class definitions or helpfiles.

Executing the method dumpInterface on any class will list its class and instance methods and their arguments (if any).

Array.dumpInterface; // Look at the post window (the one that opened when you started SC)

Note that since the SuperCollider language is object-oriented many classes inherit methods from farther up the class hierarchy. (The many subclasses of Collection are a good example of this. See the Collections overview for more detail.) It would be impractical and redundant to document every inherited method that a class responds to, so it is important to be able to track down documentation and method definitions.  

The method dumpFullInterface applied to any Class will list all class and instance methods that a class responds to, sorted by the class in which they are implemented. This will include inherited methods. Methods overidden in a subclass are listed under the subclass.

Array.dumpFullInterface;

This can be a lot of information, so dumpAllMethods or class.dumpAllMethods will show only instance and class methods respectively.

Array.class.dumpAllMethods; // Only class methods that this responds to (including inherited ones)
Array.dumpAllMethods; 		// Only instance methods (including inherited ones)

There is also a graphical Class browser which will show all methods, arguments, subclasses, instance variables and class variables. Using the browser's buttons you can easily navigate to the class' superclass, subclasses, class source, method source, helpfile (if there is one), check references or implementation of methods, or even open a web browser to view the corresponding entry in the online SVN repository. (Note that the web repository is a backup often a day or two behind the status of what is available to developers.)

SequenceableCollection.browse;

Selecting any method and pressing Cmd-y will open a window with a list of all the classes that implement that method. (See the Polymorphism helpfile for detail on why different classes might implement methods with the same name.)

select // try it on this method

Similarly, selecting any text and typing shift-cmd-y will open a window showing all references to the selected text, i.e. each place it is used within the class library. (This will not find methods calls compiled with special byte codes like 'value'.)

// try it on these
asStream 
SCWindow

In the resulting window selecting any class and method and pressing Cmd-j will take you to that method definition in that class definition. For example try selecting Pattern-select in the window resulting from the previous example. Note that SC supports defining methods in separate files, so a class' methods may be defined in more than one place. If you try Cmd-j on the following you will see that it will open a file called dumpFullInterface.sc rather than one called Class.sc (its main class definition file). The + Class {.... syntax indicates that these are additional methods.

Class-dumpFullInterface

If you know that a class responds to a particular message, you can use findRespondingMethod to find out which class it inherits the corresponding method from.

Array.findRespondingMethodFor('select'); // you can Cmd-j on the result in the post window

Similarly, helpFileForMethod will open the helpfile of the class in which the responding method is defined (if the helpfile exists). Note that this does not guarantee that the method is documented therein. As noted above, some documentation is incomplete, and some methods are 'private' or not intended for general use.

Array.helpFileForMethod('select'); // this will open the Collection helpfile; scroll down for select

In general poking around can be a good way to learn about how things work. See Internal-Snooping for more advanced information about how to look 'under the hood.'

For Further Info

http://supercollider.sourceforge.net/

A good starting place for figuring out how to do something are the numerous files in the Examples folder. The SuperCollider swiki is another good source of tips, examples, and information:

http://swiki.hfbk-hamburg.de:8888/MusicTechnology/6

To edit or add pages on the swiki use: 	username: sc 	password: sc

Further help can be obtained by subscribing and sending questions to the sc-users mailing list:

http://www.beast.bham.ac.uk/research/sc_mailing_lists.shtml

An archive of the list can be searched from this page:

http://www.listarc.bham.ac.uk/lists/sc-users/search/

Requests for documentation of undocumented methods or classes, as well as reports of errata, omissions, etc. in helpfiles can be sent to the user's list above. Bugs or Feature Requests can be filed here:

https://sourceforge.net/tracker2/?group_id=54622


