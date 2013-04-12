Object			abstract superclass of all objects	

Object is the root class of all other classes. All objects are indirect instances of class Object. 
We call "receiver" the object the message is sent to: receiver.method(argument).

Superclass: nil (Not the Nil class, but the nil instance).

See also: Class, Intro-to-Objects, Classes

Class Membership

	class
	
		Answer the class of the receiver.

		5.class;

	respondsTo(selector)
	
		Answer a Boolean whether the receiver understands the message selector. selector must be a Symbol.
		
		5.respondsTo('+');
		
	isKindOf(aClass)
	
		Answer a Boolean indicationg whether the receiver is a direct or indirect instance of aClass. Use of this message in code must be questioned, because it often indicates a missed opportunity to exploit object polymorphism.
		
		5.isKindOf(Magnitude);
		
	isMemberOf(aClass)
	
		Answer a Boolean whether the receiver is a direct instance of aClass. Use of this message in code is almost always a design mistake.
		
		5.isMemberOf(Magnitude);
		
Accessing

	size
	
		Different classes interpret this message differently.  Object always returns 0.

		

Copying

	copy
	
		Make a copy of the receiver. The implementation of this message depends on the object's class.  In class Object, copy calls shallowCopy.

	shallowCopy
	
		Makes a copy of the object. The copy's named and indexed instance variables refer to the same objects as the receiver.
		
	deepCopy
	
		Recursively copies the object and all of the objects contained in the instance variables, and so on down the structure. This method works with cyclic graphs.
	
	copyImmutable
	
		If object is immutable then return a shallow copy, else return receiver.
		


Conversion

 To convert an object of a certain Class into a similar, Object provides a number of methods.

	as(class)
	
		Returns a similar new Object of a different class.
		
		[1, 2, 3].as(Set);
		Pwhite(0.0, 1.0, 10).as(Set);
		
	asArray
	
		Returns an Array with the receiver, unless it is an Array already.		
		
		[1, 2, 3].asArray;	
		5.asArray;
	
	asCompileString
	
		Returns a String that can be interpreted to reconstruct a copy of the receiver.
		For the complementary method, see String interpret	.
		
		a = { 10.do { 10.postln } };
		a.asCompileString.postcs;
		a.postcs;
		
	cs
		shortcut for asCompileString
		{ 10.do { 10.postln } }.cs;


Archiving

Object implements methods for writing and retrieving objects from disk. Note that you cannot archive instances of Thread and its subclasses (i.e. Routine), or open Functions (i.e. a Function which refers to variables from outside its own scope).

	writeArchive(pathname)
	
		Write an object to disk as a text archive. pathname is a String containing the resulting file's path.

	*readArchive(pathname)
	
		Read in an object from a text archive. pathname is a String containing the archive file's path.
		
		a = Array.fill(100, { 100.0.rand });
		a.writeArchive(PathName.tmp ++ "myArray");
		b = Object.readArchive(PathName.tmp ++ "myArray");
		a == b // true
		
		/////////
		
		// closed Function
		(
		f = { 1 + 2 };
		f.writeArchive(PathName.tmp ++ "myFunc"); // succeeds
		)
		// open Function
		(
		var num;
		num = 2;
		f = { num + 2 };
		f.writeArchive(PathName.tmp ++ "myFunc"); // fails
		)
 
Equality and Identity

	== anotherObject
	
		equality: Answer whether the receiver equals anotherObject. The definition of equality depends on the class of the receiver. The default implementation in Object is to answer if the two objects are identical (see below).
		Note: Whenever == is overridden in a class, hash should be overridden as well.
		
		5.0 == 5; // true
		5.0 === 5; // false
		a = [1, 2, 3]; b = [1, 2, 3];
		a == b; // equal
		a === b; // not identical
		"worth trying" == "worth trying"; // equal
		

	=== anotherObject
	
		identity: Answer whether the receiver is the exact same object as anotherObject.
		
		5.0 === 5; // false
		"worth trying" === "worth trying"; // not identical
		'worth trying' === 'worth trying'; // identical (symbols are unique)

		
	!= anotherObject
	
		non-equality: Answer whether the receiver does not equal anotherObject. The default implementation in Object is to answer if the two objects are not identical (see below).
		
	fuzzyEqual(that, precision)
	
		Retruns the degree of equality (in the range from 0 to 1) between two objects with regard to a given precision. Objects to compare must support max, substraction and division.
		
		5.0.fuzzyEqual(5.0, 0.5); // 1 - full equality
		5.25.fuzzyEqual(5.0, 0.5); // 0.5 - 50 % equality
		5.9.fuzzyEqual(5.0, 0.5); // 0 - no equality

	compareObject(that, instVarNames)
	
		Tests if two Objects (of the same class) are the same in a certain respect: It returns true if instVarNames are equal in both. If none are given, all instance variables are tested (see also: instVarHash)
		
		a = Pseq([1, 2, 3], inf); b = Pseq([100, 200, 300], inf);
		a.compareObject(b, [\repeats]); // true
		a.compareObject(b, [\list]); // false
		
	hash
	
		Answer a code used to index into a hash table. This is used by Dictionary and Set and their subclasses to implement fast object lookup.  Objects which are equal == should have the same hash values. Whenever == is overridden in a class, hash should be overridden as well.
		
		a = "worth trying"; b = "worth trying";
		a.hash;
		b.hash;
		
	identityHash
	
		Answer a code used to index into a hash table. This method is implemented by a primitive and is not overridden. Objects which are identical === should have the same hash values.
		
		a = "worth trying"; b = "worth trying";
		a.identityHash;
		b.identityHash;
		
	instVarHash(instVarNames)
	
		Returns a combined hash value for the object's instance variables and the object's class. If none are given, all instance variables are tested (see also: compareObject).
		
		a = Pseq([1, 2, 3], inf); b = Pseq([100, 200, 300], inf);
		
		a.instVarHash([\repeats]); // same
		b.instVarHash([\repeats]);
		
		a.instVarHash([\list]); // different
		b.instVarHash([\list]);
		
		a = Pseq([1, 2, 3], inf); b = Prand([1, 2, 3], inf);
		a.instVarHash([\list]); // different
		b.instVarHash([\list]);


Testing

	isNil
	
		Answer a Boolean indicating whether the receiver is nil.

	notNil
	
		Answer a Boolean indicating whether the receiver is not nil.
		
	isNumber
	
		Answer a Boolean indicating whether the receiver is an instance of Number.
		
	isInteger
	
		Answer a Boolean indicating whether the receiver is an instance of Integer.
		
	isFloat
	
		Answer a Boolean indicating whether the receiver is an instance of Float.
		
	? anObject
	
		If the receiver is nil then answer anObject, otherwise answer the receiver.
		
	?? aFunction
	
		If the receiver is nil, evaluate the Function and return the result.
		
	pointsTo(obj)
	
		Returns true if receiver has a direct reference to obj.
		
		a = 9;
		b = [1, a, 6, 8];
		c = [1, b, 5];
		c.pointsTo(b); // true
		c.pointsTo(a); // false
	
	mutable
	
		Returns true if receiver is mutable.
		
		a = #[1, 2, 3]; b = [1, 2, 3];
		a.mutable; // false
		b.mutable; // true

	frozen
	
		Returns true if receiver is frozen.	
		
	switch(cases)
	
		Object implements a switch method which allows for conditional evaluation with multiple cases. These are implemented as pairs of test objects (tested using if this == test.value) and corresponding functions to be evaluated if true. In order for switch to be inlined (and thus be as efficient as nested if statements) the matching values must be literal Integers, Floats, Chars, Symbols and the functions must have no variables or arguments.
		
		(
		var x, z;
		z = [0, 1, 1.1, 1.3, 1.5, 2];
		switch (z.choose.postln,
			1,   { \no },
			1.1, { \wrong },
			1.3, { \wrong },
			1.5, { \wrong },
			2,   { \wrong },
			0,   { \true }
		).postln;
		)
		
		or:
				
		(
		var x, z;
		z = [0, 1, 1.1, 1.3, 1.5, 2];
		x = switch (z.choose)
			{1}   { \no }
			{1.1} { \wrong }
			{1.3} { \wrong }
			{1.5} { \wrong }
			{2}   { \wrong }
			{0}   { \true };
		x.postln;
		)

Messaging

Instead of directly sending a method to an object, a method may be invoked given a method selector only (a Symbol). The other arguments may be provided by passing them directly, from an environment. If it si not known whether the receiver implements the metod, tryPerform only sends if it does, and superPerform invokes the method of the superclass.


	perform(selector ... args)
	
		The selector argument must be a Symbol. Sends the method named by the selector with the given arguments to the receiver.

	performList(selector, [args])
	
		The selector argument must be a Symbol. Sends the method named by the selector with the given arguments to the receiver. If the last argument is a List or an Array, then its elements are unpacked and passed as arguments.
		
		a = { |a, b, c| postf("% plus % plus % is %\n", a, b, c, a + b + c); "" };
		a.performList(\value, [1, 2, 3]);
		
	performMsg([args])
	
		The argument must be a List or Array whose first element is a Symbol representing a method selector. The remaining elements are unpacked and passed as arguments to the method named by the selector.
		
		a = { |a, b, c| postf("% plus % plus % is %\n", a, b, c, a + b + c); "" };
		a.performMsg([\value, 1, 2, 3]);
	
	performWithEnvir(selector, envir)
	
		selector: A Symbol representing a method selector. 
		envir: The remaining arguments derived from the environment and passed as arguments to the method named by the selector.
		
		a = { |a, b, c| postf("% plus % plus % is %\n", a, b, c, a + b + c); "" };
		a.performWithEnvir(\value, (a: 1, c: 3, d: 4, b: 2));
	
	performKeyValuePairs(selector, pairs)
	
		selector: A Symbol representing a method selector. 
		pairs: Array or List with key-value pairs.
		
		a = { |a, b, c| postf("% plus % plus % is %\n", a, b, c, a + b + c); "" };
		a.performKeyValuePairs(\value, [\a, 1, \b, 2, \c, 3, \d, 4]);	
	
	tryPerform(selector ... args)
	
		Like 'perform', but tryPerform passes the method to the receiver only if the receiver understands the method name. If the receiver doesn't implement that method, the result is nil. Note that this does not catch errors like 'try' does (see Exception). If the receiver does have a matching method but that method throws an error, execution will halt. But, 'tryPerform' is faster than 'try'.

		(a: 1, b: 2, c: 3).tryPerform(\keysValuesDo, { |key, value| [key, value].postln });

		// Array does not understand keysValuesDo -- result is nil
		[1, 2, 3].tryPerform(\keysValuesDo, { |key, value| [key, value].postln });

		// Error occurs within keysValuesDo -- error is thrown back to halt execution
		(a: 1, b: 2, c: 3).tryPerform(\keysValuesDo, { |key, value| [key, value].flippityblargh });
		
		
	superPerform(selector, ... args)
		Like perform, superPerform calls a method, however it calls the method on the superclass.
		selector: A Symbol representing a method selector. 
		args: Method arguments.
		
		
	superPerformList([args])
		Like performList, superPerformList calls a method, however it calls the method on the superclass.
		selector: A Symbol representing a method selector. 
		args: Method arguments. If the last argument is a List or an Array, then its elements are unpacked and passed as arguments.	
	
	multiChannelPerform(selector ... args)
	
		selector: A Symbol representing a method selector. 
		args: Method arguments, which if they contain an array, will call the method multiple times for each sub-element.
		a = { |a, b, c| format("% plus % times % is %", a, b, c, a + b * c).quote; };
		a.multiChannelPerform(\value, [1, 10, 100, 1000], [2, 7, 9], [3, 7]);	
		


Unique Methods

Method definitions not yet implemented may be added to an Object instance. 

	addUniqueMethod(selector, function)
	
		Add a unique method.
		
	a = 5;
	a.addUniqueMethod(\sayHello, { |to| "hello " ++ to ++ ", I am 5" });
	a.sayHello;
	
	removeUniqueMethod(selector)
	
		Remove a unique method.
		
	a.removeUniqueMethod(\sayHello);
	a.sayHello;
	
	removeUniqueMethods
	
		Remove all unique methods of an Object.


		
Dependancy

	addDependant(aDependant)
	
		Add aDependant to the receiver's list of dependants.

	removeDependant(aDependant)
	
		Remove aDependant from the receiver's list of dependants.
		
	dependants
	
		Returns an IdentitySet of all dependants of the receiver.
		
	changed(theChanger)
	
		Notify the receiver's dependants that the receiver has changed. The object making the change should be passed as theChanger.
		
	update(theChanged, theChanger)
	
		An object upon which the receiver depends has changed. theChanged is the object that changed and theChanger is the object that made the change.
		
	release
	
		Remove all dependants of the receiver. Any object that has had dependants added must be released in order for it or its dependants to get garbage collected.
		


Error Support

Object implements a number of methods which throw instances of Error. A number of methods (e.g. doesNotUnderstand) are 'private' and do not normally need to be called directly in user code. Others, such as those documented below can be useful for purposes such as object oriented design (e.g. to define an abstract interface which will be implemented in subclasses) and deprecation of methods. The reserved keyword thisMethod can be used to refer to the enclosing method. See also Method and Function (for exception handling).

	throw
	
		Throws the receiver as an Exception, which may or may not be caught and handled by any enclosing Function.
				
	subclassResponsibility(method)
	
		Throws a SubclassResponsibilityError. Use this to indicate that this method should be defined in all subclasses of the receiver.
		
		someMethod {
			this.subclassResponsibility(thisMethod);
		}
		
	shouldNotImplement(method)
	
		Throws a ShouldNotImplementError. Use this to indicate that this inherited method should not be defined or used in the receiver.

	deprecated(method, alternateMethod)
	
		Throws a DeprecatedError. Use this to indicate that the enclosing method has been replaced by a better one (possibly in another class), and that it will likely be removed in the future. Unlike other errors, DeprecatedError only halts execution if Error.debug == true. In all cases it posts a warning indicating that the method is deprecated and what is the recommended alternative.
		
		foo {
			this.deprecated(thisMethod, ThisOrSomeOtherObject.findMethod(\foo);
			... // execution of this method will continue unless Error.debug == true
		}

	
		
Printing and Introspection

	post
	
		Print a string representation of the receiver to the post window.
		"hello".post; "hello".post; "";

	postln
	
		Print a string representation of the receiver followed by a newline.
		"hello".postln; "hello".postln; "";
	
	postc
	
		Print a string representation of the receiver preceded by comments.
		"hello".postc; "hello".postc; "";
	
	postcln
	
		Print a string representation of the receiver preceded by comments, followed by a newline.
		"hello".postcln; "hello".postcln; "";
	
	postcs
	
		Print the compile string representation of the receiver, followed by a newline.
		"hello".postcs; "hello".postcs; "";
		
	dump
	
		Print a detailed low level representation of the receiver to the post window.
		
		
		 
		
System Information

	gcInfo
	
		Posts garbage collector information in a table format. 
		flips: the number of times the GC "flipped", i.e. when it finished incremental scanning of all reachable objects
		collects: the number of partial collections performed
		nalloc: total number of allocations
		alloc: total allocation in bytes
		grey: the number of "grey" objects, i.e. objects that point to reachable objects and are not determined to be (un)reachable yet

		Then for each size class: numer of black, white and free objects, total number of objects and the total set size.
		
		flips 241  collects 689096   nalloc 40173511   alloc 322496998   grey 346541
 		0  bwf t sz:    882      0 368573   369455    2955640
 		1  bwf t sz:   6197    122 5702377   5708696   91339136
		2  bwf t sz:    947      4 1500009   1500960   48030720
 		3  bwf t sz:   8056  65201 301800   375057   24003648
		4  bwf t sz:   4047    145   3457     7649     979072
		5  bwf t sz:    422      1    431      854     218624
		6  bwf t sz:    124      2     72      198     101376
		7  bwf t sz: 153504      1      0   153505   157189120
		8  bwf t sz:     22      0      0       22      45056
		9  bwf t sz:      5      0      0        5      20480
		10  bwf t sz:      5      0      0        5      40960
		12  bwf t sz:      2      0      0        2      65536
		13  bwf t sz:      1      0      0        1      65536
		19  bwf t sz:      1      0      3        4   16777216
		tot bwf t sz: 174215  65476 7876722   8116413   341832120
		

		you can also query the amount of free memory with Object.totalFree and dump the currently grey objects with Object.dumpGrey. More memory status methods are: Object.largestFreeBlock, Object..gcDumpSet, and Object.gcSanity.
	
	

	
		
Iteration

	do(func)
	
		Object evaluates the function with itself as an argument, returning the reasult. Different classes interpret this message differently.  
		
		f = { |x, i| [x, i].postln; };
		[1, 2, 3].do(f); // Array.do
		10.do(f); // Integer.do
		($Q).do(f); // Object.do
		
	generate(func, state)
	
		Object iterates by the message do, sent to the receiver.
		This method is used internally by list comprehensions. 
		
	dup(n)
	
		Duplicates the receiver n times, returning an array of n copies. Different classes interpret this message differently.  The shortcut "!" can be used in place.
		
		8.dup(10);
		8 ! 10; // same as above
		x = [[1], [2], [3]].dup(5);
		x[0] === x[1]; // false: copies receiver.
		x[0][0] === x[1][0] // true: doesn't deepCopy receiver
		{ 1.0.rand }.dup(5) // other objects respond differently to dup


Routine Support

	Objects support the basic interface of Stream, just returning itself in respone to the following messages:
	next, reset, stop, free, clear, removedFromScheduler, asStream.
	
	

	yield
	
		Must be called from inside a Routine. Yields control to the calling thread. The receiver is the result passed to the calling thread's method. The result of yield will be the value passed to the Routine's next method the next time it is called.

	yieldAndReset
	
		Must be called from inside a Routine. Yields control to the calling thread. The receiver is the result passed to the calling thread's method. The Routine is reset so that the next time it is called, it will start from the beginning. yieldAndReset never returns within the Routine.
		
	alwaysYield
	
		Must be called from inside a Routine. Yields control to the calling thread. The receiver is the result passed to the calling thread's method. The Routine, when called subsequently will always yield the receiver until it is reset. alwaysYield never returns within the Routine.
	
	embedInStream
		Yields the receiver
		
	idle(time)
		within a routine, return values (the receiver) until this time is over. (for an example, see Routine)
		Time is measured relative to the thread's clock.
		
	iter
		Returns a OneShotStream with the receiver as return value.
		
	cyc(n)
		Embeds the receiver in the stream n times (default: inf), each time resetting it.
	
	fin(n)
		Calls next with the receiver n times only (default: 1), yielding the result.
	
	repeat(repeats)
		Repeatedly embeds the receiver in the stream using a Pn (may thus be used for patterns and other objects alike)
	
	loop
		Indefinitely embeds the receiver in the stream 



FunctionList

The messages addFunc, addFuncTo, removeFunc, removeFuncFrom are supported by Object. See Function.




