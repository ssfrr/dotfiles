Writing SuperCollider Classes 

For a basic tutorial on how standard object-orientated classes are composed, look elsewhere 
http://www.google.com/search?q=oop+class+tutorial

Note: Class definitions are statically compiled when you launch supercollider or "recompile the library." This means that class definitions must be saved into a file with the extension .sc, in a disk location where supercollider looks for classes. Saving into the main class library (SCClassLibrary) is generally not recommended. It's preferable to use either the user or system extension directories.

Platform.userExtensionDir;   // Extensions available only to your user account
Platform.systemExtensionDir;   // Extensions available to all users on the machine

It is not possible to enter a class definition into an interpreter window and execute it.


Inheriting 

	NewClass : SomeSuperclass { 

	}


Without specifying a superclass, Object is assumed as the default superclass. 

	NewClass { // : Object is implied

	}


Methods 

class methods are specified with the asterix

	*classMethod { arg argument; 
	
	}

	within the class method, the keyword 
	
	this 

	refers to the class.   

	A class in smalltalk is itself an object.  It is an instance of Class.


instance methods are specified :

	instanceMethod { arg argument; 
	
	}

	within the instance method, the keyword 
	
	this 

	refers to the instance. 



to return from the method use ^ (caret)


	someMethod { 
		^returnObject 
	}


multiple exit points also possible : 


	someMethod { arg aBoolean; 
		if(aBoolean,{ 
			^someObject 
		},{ 
			^someOtherObject 
		}) 
	}


	if no ^ is specified, the method will return the instance. 
	(and in the case of Class methods, will return the class) 

	There is no such thing as returning void in Smalltalk.



New Instance creation 

Object.new will return to you a new object. 
when overriding the class method .new you must call the superclass, which in turn calls its superclass, up until Object.new is called and an object is actually created and its memory allocated.

	// this example adds no new functionality 
	*new { 
		^super.new 
	}

	// this is a normal constructor method
	*new { arg arga,argb,argc; 
		^super.new.init(arga,argb,argc) 
	}
	init { arg arga,argb,argc;
	    // do initiation here
	}

In this case note that super.new called the method new on the superclass and returned a new object. subsequently we are calling the .init method on that object, which is an instance method. 

Warning: if the superclass also happened to call super.new.init it will have expected to call the .init method defined in that class (the superclass), but instead the message .init will find the implementation of the class that the object actually is, which is our new subclass.   So you should use a unique method name like myclassinit if this is likely to be a problem.

One easy way to copy the arguments passed to the instance variables when creating a class  is to use  newCopyArgs.   This method will copy the arguments to the instance variables in the order that the variables were defined in the class, starting the parent classes and working it's way down to the current class. 

	MyClass{
		var <a,b,c;
		
		*new { arg a,b,c; 
			^super.newCopyArgs(a,b,c) 
		}
	
	}
	
	MyChildClass : MyClass{
		var <d;
		
		*new { arg a,b,c,d; 
			^super.newCopyArgs(a,b,c,d) 
		}
	
	}

Over reliance on inheritance is usually a design flaw.  Explore "object composition" rather than trying to obtain all your powers through inheritance. Is your "subclass" really some kind of "superclass" or are you just trying to swipe all of daddy's methods ? Do a websearch for  Design Patterns.

Class variables are accessible within class methods and in any instance methods. 

	classvar myClassvar;

	var myInstanceVar; 


For class initialization check initClass.

Overriding Methods (Overloading)

in order to change the behaviour of the superclass, often methods are overridden.
note that an object looks always for the method it has defined first and then looks in the superclass.
here NewClass.value(2) will return 6, not 4: 

	Superclass { 
	
		calculate { arg in; in * 2 }
		value { arg in; ^this.calculate(in) }
	}
	
	NewClass : Superclass { 
	
		calculate { arg in; in * 3 }
	}


 
if the method of the superclass is needed, it can be called by super.

	Superclass { 
		var x;
		
		init {
			x = 5;
		}
	}
	
	NewClass : Superclass { 
		var y;
		init { 
			super.init;
			y = 6; 
		}
	}




Getter Setter 

Classic Smalltalk demands that variables are not accessible outside of the class or instance.  A method must be added to explicitly give access: 

	
	NewClass : Superclass { 
	
		var myVariable;
	
		variable { 
			^myVariable 
		}
	
		variable_ { arg newValue; 
			myVariable = newValue; 
		}
	}

These are referred to as getter and setter methods. 

SC allows these methods to be easily added by adding < or > 

	var <getMe, >setMe, <>getMeOrSetMe; 


you now have the methods: 

	someObject.getMe;

	someObject.setMe_(value);
	
this also allows us to say:

	someObject.setMe = value;

	someObject.getMeOrSetMe_(5);
	someObject.getMeOrSetMe.postln; 



a getter or setter method created in this fashion may  be overridden in a subclass by manually writing the method 
setter methods should take only one argument to support both ways of expression consistently.
eg. 	
	variable_ { arg newValue;  
		variable = newValue.clip(minval,maxval); 
	} 

A setter method should always return the receiver. This is standard OOP practice (outside of SC as well). Do not return the new value from your setter.

		variable_ { arg newValue; 
			myVariable = newValue;
			^newValue		// DO NOT DO THIS
		}


External Method Files

Methods may be added to Classes in separate files.  This is equivalent to Protocols in Objective-C.  By convention, the file name starts with a lower case letter: the name of the method or feature that the methods are supporting.

Syntax:

	+ Class {
		newMethod {
		
		}
		*newClassMethod {
		
		}
	}


Slotted classes

Classes defined with [slot]  can use the syntax myClass[i] which will call  myClass.at(i). This is useful when defining classes that inherit from a Collection type class.

Syntax:

	MyClass[slot] {
		
		*new{ ^super.new }
		
		}
		
		at{ |i|
			("Index "++i).postln 
		} 

		
		
	}
	
	
	a = MyClass();
	a[3];
	
Defining a custom array of Points:

	MyPointArray[slot] : RawArray {
		
		center { ^Point(*this.asArray.flop.collect{ |item| item.sum / item.size } ) }
		
		asArray{ ^this.collect{ |elem| elem.asArray } }
		
		
	}

	
	
Printing custom messages to post window

By default when postln is called on an class instance the name of the class is printed in a post window.  When postln  or asString is called on a class instance, the class then calls printOn which can be overridden to obtain more useful information.

Syntax:

	MyTestPoint {
		var <x, <y;
		
		*new{ |x,y| ^super.newCopyArgs(x,y) }
		
		printOn { arg stream;
			stream << "MyTestPoint( " << x << ", " << y << " )";
		}		
		
	}
	
	
	a = MyTestPoint(2,3);
	
Defining custom asCompileString behaviour

A call to asCompileString should return a string which when evaluated creates the exact same instance of the class. To define a custom behaviour one should either override storeOn or storeArgs. 
	The method storeOn should return the string that evaluated creates the instance of the current object.
	The method storeArgs should return an array with the arguments to be passed to TheClass.new. In most cases this method can be used instead of storeOn.

Syntax:

either

	MyTestPoint { 
		var <x, <y;
		
		*new{ |x,y| ^super.newCopyArgs(x,y) }
		
		storeOn { arg stream;
			stream << "MyTestPoint.new(" << x << ", " << y << ")";
		}		
		
	}	
	
	MyTestPoint(2,3).asCompileString;
	
or

	MyTestPoint { 
		var <x, <y;
		
		*new{ |x,y| ^super.newCopyArgs(x,y) }
		
		storeArgs { arg stream;
			^[x,y]
		}		
		
	}	
	
	MyTestPoint(2,3).asCompileString;	
	

Tricks and Traps 

"Superclass not found..."

In one given code file, you can only put classes that inherit from each Object, each other, and one external class.   In other words, you can't inherit from two separate classes that are defined in separate files.

If you should happen to declare a variable in a subclass and use the same name as a variable declared in a superclass, you will find that both variables exist, but only the one in the object's actual class is accessible.  You should not do that. This will at some point become an error worthy of compilation failure.

Catching methods that are not explicitly defined

It is possible to catch calls to methods that are not explicitly defined in a Class by overriding  doesNotUnderstand. 

	MyClass {
	
		*new{ ^super.new }
		
		doesNotUnderstand{ arg selector...args;
			(this.class++" does not understand method "++selector);
			
			If(UGen.findRespondingMethodFor(selector).notNil){
				"But UGen understands this method".postln
			};
			
		}
	}
	
	a = MyClass();
	a.someMethodThatDoesNotExist
	


