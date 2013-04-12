IdentityDictionary				associative collection mapping keys to values


Inherits from: Object : Collection : Set : Dictionary

An IdentityDictionary is an associative collection mapping keys to values. 
Keys match only if they are identical objects. (i.e. === returns true.)
(In Dictionary, keys match if they are equal valued. This makes IdentityDictionary faster than Dictionary)
The contents of a Dictionary are unordered.  You must not depend on the order of items in a Dictionary.

See also: Environment, Event (more method documentation in superclasses)

Often, the subclass Event is used as an IdentityDictionary, because there is a syntactical shortcut:

a = (); // return a new Event.
a.put(\foo, 2.718);
a.at(\foo);


Creation / Class Methods

	*new (n, proto, parent, know)
	
	
		The parent and proto instance variables allow additional IdentityDictionary's to provide 
		default values. The precedence order for determining the value of a key is the IdentityDictionary, 
		its prototype, its parent.

		When the instance variable know is true, the IdentityDictionary responds to unknown messages 
		by looking up the selector and evaluating the result with the dictionary as an argument. 
		For example:

		a = IdentityDictionary(know: true);
		a.put(\foo, { | x | ("the argument is:" + x).postln });
		a.foo;
		

Accessing Instance Variables
	
	proto_(IdentityDictionary)
	proto
	parent_(IdentityDictionary)
	parent				
	know_(flag)
	know				
				
Methods

	IdentityDictionary reimplements the following methods of Dictionary:
	
	at (key)
	put (key, value)
	includesKey (key)
	findKeyForValue (argValue)
	scanFor (argKey)

	
	putGet (key, newValue)
		sets key to newValue, returns the previous value of key
		g.cleanUpMethod;

	The following three methods provide support for Quant
	nextTimeOnGrid (clock)
	asQuant
	timingOffset


Examples

	IdentityDictionary is often used to assign names to instances of a particular class.  For example,
	the proxy classes (Pdef, Pdefn, Tdef, Ndef, Fdef), SynthDefLib, and NodeWatcher all have class
	variables named all implemented as IdentityDictionary's.
	
	
	



