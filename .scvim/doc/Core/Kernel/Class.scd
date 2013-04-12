Class

superclass: Object

A Class describes the structure and implementation of a set objects which are its instances.


Utilities

browse

Open a graphical browser for this Class. (OSX only). Shows methods, arguments, variables, subclasses, and has buttons for navigating to the superclass, source, helpfile, cvs, etc.

findMethod(methodName)

Find the Method referred to by name. If not found, return nil.

findRespondingMethodFor(methodName)

As above, but climb the class tree to see if the method is inherited from a superclass. If not found, return nil.

dumpAllMethods

Post all instance methods which instances of this class responde too, including inherited ones. this.class.dumpAllMethods will post all class methods which this class responds to.

dumpByteCodes(methodName)

Dump the byte codes of the named method.

dumpClassSubtree

Post the tree of all Classes that inherit from this class.

dumpInterface

Post all the methods defined by this Class and their arguments.

dumpFullInterface

Post all the class and instance methods that this class responds to (i.e. those defined in this class and those inherited by it).

openHelpFile

Opens the help file for this Class if it exists.

helpFilePath

Returns the path of this Class's helpfile as a String.

helpFileForMethod(methodSymbol)

Opens the helpfile for the class in which the responding method is implemented.

Array.helpFileForMethod('select'); // This will open the Collection helpfile

Conversion

asClass

Return this.

asString

Return the name of the class as a String.


Accessing

name

A Symbol that is the name of the class.

nextclass

The next class in a linked list of all classes.

superclass

The Class from which this class directly inherits.

superclasses

An Array of this class's superclasses, going back to Object.

subclasses

An Array of the direct subclasses of this.

allSubclasses

An Array of all subclasses of this.

methods

An Array of the methods of this class.

instVarNames

An Array of the names of the instance variables for this class.

classVarNames

An Array of the names of the class variables for this class.

iprototype

An Array of the initial values of instance variables.

cprototype

An Array of the initial values of class variables.

filenameSymbol

A Symbol which is a path to the file which defines the Class.



