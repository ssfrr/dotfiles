Snooping around SuperCollider

You can inspect much of the internal structure of the class library and other data structures.
This can often be useful for research and debugging purposes.

Class Definitions, Implementations, and References

Selecting the name of any Class (e.g. Object) and typing cmd-j will open its class definition file.

** Note: Any keypresses that open files identify the files using SuperCollider strings, which may contain only ASCII characters up to code point 127. If any part of the path to your SuperCollider installation contains character codes greater than 127 (such as the old Mac convention of identifying program folders with option-F), automatic file opening will fail.

Selecting the name of any method (e.g. play) and typing cmd-y will open a window showing all implementations of that method and their arguments. Selecting one of those classes and methods (e.g. Sample:play) and typing cmd-j will open the class definition at that method. (Note that cmd-y only shows implementations, and does not indicate inheritance).

Selecting any text (e.g. SCWindow or asStream) and typing shift-cmd-y will open a window showing all references to the selected text, i.e. each place it is used within the class library. (This will not find methods calls compiled with special byte codes like 'value'.)

SC has a graphical Class browser which will show all methods, arguments, subclasses, instance variables and class variables. Using the browser's buttons you can easily navigate to the class' superclass, subclasses, class source, method source, helpfile (if there is one), check references or implementation of methods, or even open a web browser to view the corresponding entry in the online SVN repository.

SequenceableCollection.browse;

Snooping in Classes

The Class help file documents some of these snooping methods.
Even though you may access these data structures, if you store things into them, you may break something.

Collection.dumpInterface;	// print all instance methods defined for this class

Collection.class.dumpInterface;	// print all class methods defined for this class


// The following three include inherited methods

Collection.methods.collect(_.name);	
						// print all instance methods that instances of this class respond to

Collection.class.methods.collect(_.name); 
						// print all class methods that this class responds to

Collection.dumpFullInterface;	// print all instance and class methods that this class responds to

Collection.dumpMethodList;	// print instance methods of this class and superclasses, in alpha order
						// also shows from which class the method is inherited
						// does not include Object or Class methods
						// for class methods, do Meta_Collection.dumpMethodList

Collection.dumpClassSubtree;	// dump all subclasses of this class

Collection.dumpSubclassList;	// dump all subclasses, in alphabetical order

SCWindow.instVarNames.dump;	// dump all instance variable names of this class

SCWindow.classVarNames.dump;	// dump all class variable names of this class

SCWindow.filenameSymbol.postln;	// the path to the file that defined this class

(
// print all classes whose names start with 'F'
Class.allClasses.do({ arg class;
	if (class.name.asString.at(0) == $F, { class.name.postln; });
})
)

(
// find and print all class variable names defined in the system
Class.allClasses.do({ arg class;
    if (class.classVarNames.notNil, {
		// classVarNames is an Array of Symbols
        class.classVarNames.do({ arg varname;
            (class.name.asString ++ " " ++ varname.asString).postln;
        })
    });
});
)

(
// find and print all methods that contain "ascii"
Class.allClasses.do({ arg class;
   	class.methods.do({ arg sel;
   			if(sel.name.asString.find("ascii").notNil) {
            		(class.name.asString + "-" + sel.name).postln;
            }
      });
}); ""
)

Snooping in Methods

Same thing goes here, if you store things into Methods, you may break something.

Collection.findMethod('select'); // does it have this method?

Array.findMethod('select'); // this class doesn't

Array.findRespondingMethodFor('select'); // climb the class tree to find the method

Collection.findMethod('select').dump; // find a method object

Collection.findMethod('select').argNames.dump; // dump its argument names

Collection.findMethod('select').varNames.dump; // dump its local variable names

// dump its code. mostly for debugging the compiler.
Collection.findMethod('select').dumpByteCodes;	

Collection.dumpByteCodes('select');	// a shorter version of the above

{ 1 + 2 }.dump; // this is a Function

{ 1 + 2 }.def.dump;	// get its FunctionDef

{ 1 + 2 }.def.dumpByteCodes;	// dump its code.


Snooping in Windows

(
// create some windows to snoop in
5.do({ arg i;
	var w, b;
	w = Window.new("snoop " ++ i.asString, 
		Rect.new( 200 + 400.rand, 69 + 300.rand, 172, 90 ));
	w.front;
	b = Button.new( w, Rect.new( 23, 28, 127, 25 ));
	b.states = [["BLAM-O", Color.red]];
}))

Window.allWindows.dump;	// dump a list of all open SCWindows

// a little more helpful, dump their names
Window.allWindows.collect({ arg w; w.name }).postln;	

(
// change background colors of all open windows
Window.allWindows.do({ arg window;
	window.view.background = Color.new(0.5 + 0.5.rand, 0.5 + 0.5.rand, 0.5 + 0.5.rand);
}))

Window.closeAll; // close all the windows (This will close the server windows)

Snooping in SynthDefs

// First execute this:
(
f = SynthDef("Help-SnoopSynthDef", 
	{ arg out=0;
		Out.ar(out, PinkNoise.ar(0.1))
	});
)

f.dumpUGens;	// get the ugens, listed in order of execution, with rate, index and
				// inputs

Snooping in the Interpreter

When evaluating text in the interpreter, the variable 'this' always refers to the interpreter.

this.dump;	// display the values of all the interpreter variables a-z

this.clearAll;	// set all variables a-z to nil

g = this.compile("(1 + 2).postln");	// compile some text into a Function

g.postln;		// see, g is a Function

g.value;	// evaluate g

this.interpret("(1 + 2).postln");	// interpret some text

this.interpretPrint("1 + 2");	// interpret some text and print the result





