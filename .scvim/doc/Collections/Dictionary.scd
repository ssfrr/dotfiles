Dictionary			associative collection mapping keys to values

Inherits from: Object : Collection : Set

A Dictionary is an associative collection mapping keys to values.
Two keys match if they are equal. (i.e. == returns true.)

The contents of a Dictionary are unordered. You must not depend on the order of items in a Dictionary.
You must only rely on equality for the keys (e.g. symbols are ok, strings not). For identity matching see: IdentityDictionary.

See also: Envirownment, Event


The Difference between Dictionary, IdentityDictionary, Environment, and Event

Often, the subclass Event is used as an IdentityDictionary, because there is a syntactical shortcut:

		a = (foo: 7); // return a new Event.
		a.put(\foo, 2.718);
		a.at(\foo);
		a[\foo] = 3.5; // different syntax for put

Event, Environment and IdentityDictionary differ mainly insofar from Dictionary as the keys are taken to be identical (===) objects (see IdentityDictionary), instead of equal (==) objects. By consequence, the subclasses are also faster for indexing. Apart from this, the subclasses add specific functionality only. Because of its very common usage, the examples often use the shortcut for the subclass Event.

		// preliminary identity and equality of strings and symbols
		"hello" == "hello" // true, but
		"hello" === "hello" // false. However:
		\hello === \hello // true
		
		// compare
		Dictionary["hello" -> 0, "hello" -> 1]; // Dictionary[ (hello -> 1) ]
		("hello": 0, "hello": 1); // ( "hello": 1, "hello": 0 )
		
		// for symbols as keys, the behaviour is identical:
		Dictionary[\hello -> 1, \hello -> 0];
		( \hello: 1, \hello: 0 )
		

Creation / Class Methods

	*new(n)
		Creates a Dictionary with an initial capacity for n key value mappings.


Adding and Removing	
	
	add(anAssociation)
		Add anAssociation to the Dictionary.  If the key value pair already exists in the Dictionary, the key's value will be replaced.

		(
		d = Dictionary.new;
		d.add(\monkey -> 0).postln;
		// Add robot as a key with a value of 1
		d.add(\robot -> 1).postln;
		// Replaces the value for the key monkey with 2
		d.add(\monkey -> 2).postln;
		)

	put(key, obj)
		Associate two objects and add them to the Dictionary.
		key - key to associate with object. THis can be any objects, but is often a Symbol.
		obj  - an object
		
		d = Dictionary.new;
		d.put("abc", 10);
		
		// using an event:
		d = ();
		d.put("abc", 10);

	removeAt(key)
		Remove the key and the value associated with it from the Dictionary.

		d = (monkey: 99);
		d.removeAt(\monkey);
		
	putAll(... dictionaries)
		Add all items of each argument to the dictionary.
		dictionaries - any Object that responds to keysValuesDo (usually a Dictionary).

		d = ();
		d.putAll(Dictionary[\hello -> 9, \whello -> "world"], Dictionary["abd" -> 6]);
		
	
	putPairs(pairs)
		Add all items to the dictionary, using them as key and value pairwise

		d = ();
		d.putPairs(\hello, 10, \whello, "lord", "abc", 7);
		
				
Accessing:

	at(key)
		Access the value associated with the key.

		d = (robot: 99);
		// Get the value associated with key
		d.at(\robot);
		d[\robot]; // different syntax, same behaviour
		// Key doesn't exist: return Nil
		d.at(\monkey);
	
	keys
		Return a Set of all keys.

		d = (hello: 9, whello: "world");
		d.keys;
		
	values
		Return a List of all values.
		
		d = (hello: 9, whello: "world");
		d.values;
		
	atAll(... keys)
		Return an array of all values for the given keys.

		d = (hello: 9, whello: "world", z: 99, c: 0.33);
		d.atAll([\hello, \z, \hello, \c, \whello]);
		
	getPairs
		Return an array with all keys and values pairwise.

		d = (hello: 9, whello: 77, z: 99);
		d.getPairs;
			
	associationAt(key)
		Access the Association that has the given key.

		// Get the value associated with key
		d = (robot: 99);
		d.associationAt(\robot);

	findKeyForValue(argValue)
		Try to find a given value and return its key.

		d = (hello: 1, whello: 1976);
		d.findKeyForValue(1);
		

	matchAt(item)
		The dictionary's keys are used as conditions against which the arbitrary item is matched.
		see: matchItem 

		Note: if an item matches multiple criteria, the value returned is arbitrary. This is because a dictionary is an unordered collection. It's the user's responsibility to make sure that criteria are mutually exclusive.
		
		If the key is an object, the item will be matched by identity (if key === item, the value will be returned). 
		If the key is a collection, the item is matched if it's contained in the collection. 
		If the key is a function, the function is evaluated with the item as an argument and the item is matched if the function returns true.
		
		(
		d = (
			0: \zero,
			\abc: \alpha,
			[1, 2, 3, 5, 8, 13, 21]: \fibonacci,
			{ |x| try { x.even } }: \even // try is needed because argument might not be a number
		);
		);
		
		d.matchAt(0)
		d.matchAt(1)
		d.matchAt(2)  // matches both 'fibonacci' and 'even', either may be returned
		d.matchAt(4)
		d.matchAt(\abc)
		
	trueAt(key)
		Returns true if the item at the key is true, otherwise false.This method is also valid in Object.

	falseAt(key)
		Returns false if the item at the key is not true, otherwise true. This method is inherited from Object.
		


Iteration/Enumeration
		
	Most methods for iteration work analogously to Dictionary's superclasses, see e.g. Collection. 
	
	do(func)
	collect(func)
	reject(func)
	select(func)
		
		// do, collect, reject, select
		d = Dictionary[\a -> "hello", \b -> "robot", \c -> [1, 2, 3]];
		d = (a: "hello", b: "robot", c: [1, 2, 3]); // equivalent
		d.do { |item, i| [item, i].postln };	
		d.collect { |item| item + 100 };	
		d.reject { |item| item.size > 4 };
		d.select { |item| item.size > 4 };	


	keysValuesDo(function)
		Iterate over the associations, and evaluate the function for each, passing key and value as argument.
		
		d = (a: "hello", b: "robot", c: [1, 2, 3]);
		d.keysValuesDo { |key, value| postln("the key: " ++ key ++ " the value: " ++ value) };
		
	keysValuesChange(function)
		Iterate over the associations, and evaluate the function for each, passing key and value as argument. Replace the value with the return value from the function (similar to collect, but modifies the dictionary in place)
		
		d = (a: "hello", b: "robot", c: [1, 2, 3]);
		d.keysValuesChange { |key, value| "the key: " ++ key ++ " the value: " ++ value };
		d;
		
	keysDo(function)
		Iterate over the associations, and evaluate the function for each, passing key as argument.
		
		d = (a: "hello", b: "robot", c: [1, 2, 3]);
		d.keysDo { |key| postln("the key: " ++ key) };
		
	associationsDo(function)
		Iterate over the associations, and evaluate the function for each.
		
		d = (a: "hello", b: "robot", c: [1, 2, 3]);
		d.associationsDo { |assoc| postln("the association: " ++ assoc) };
	
	pairsDo(function)
		Iterate over the associations, and evaluate the function for each, passing key and value as argument.
		Identical to keysValuesDo
		
	invert
		Return a new dictionary with all the values as keys and vice versa.
		
		d = (a: "hello", b: "robot", c: [1, 2, 3]);
		d.invert;
		
		
Other instance methods:

	order(func)
		Return an array of keys which corresponds to the order of the values of the dictionary.
		
		d = (a: 5, b: 7, c: 1, d: 0);
		d.order;
		d.atAll(d.order) // returns items in order		
		

	powerset
		Return the set of all subsets: here an array of all sub-dictionaries.
		
		d = (a: 5, b: 7, c: 1, d: 0);
		d.powerset;
		
		
	merge(that, func, fill)
		Combine two dictionaries into a new one by applying a function to each value. If fill is true (default: true), values missing from one of them are kept as they are.
		
		d = (a: 5, b: 7, d: 0);
		e = (a: 3, b: -3, c: 1);
		merge(d, e, { |a, b| a + b });
		merge(d, e, { |a, b| a + b }, false);
		
		
	blend(that, blend, fill, specs)
		Blend two dictionaries into a new one by interpolating each value - blend is the blend ratio. If fill is true (default: true), values missing from one of them are kept as they are, specs is a dictionary of Specs that are apples dto each before blending. 
		
		d = (a: 5, b: 7, d: 0);
		e = (a: 3, b: -3, c: 1);
		blend(d, e, 0.3);
		blend(d, e, 0.3, false);
		
		d = (a: 500, b: 0.001);
		e = (a: 300, b: 0.1);
		blend(d, e, 0.3, specs: (a: \freq, b: \rq));

		
	asSortedArray
		Return the values in a sorted array of key value pairs
		
		d = (a: 5, b: 7, c: 1, d: 0);
		d.asSortedArray;
		
	asKeyValuePairs
		Return the values in an array of alternating key value pairs
		
		d = (a: 5, b: 7, c: 1, d: 0);
		d.asKeyValuePairs;
	
	embedInStream(event)
		If the event is not nil, yields a copy, with all the elements of the receiver.
		See also Event.
		
		// write a generator for dictionaries
		(
		d = (
			a: 5, b: 7, c: 1,
			rout: Routine { |inval|
					inf.do { |i|
						var event = d.copy.put(\count, i);
						inval = event.embedInStream(inval) 
					}
				}
			);
		);
		
		// draw new values
		d.rout.((z:999));
		d.rout.((z:1, a:0));
		d.rout.(());

		
		// sound example
		// this also allows to use events or dictionaries in patterns directly:
		(
		d = (freq: 402, dur: 0.3);
		Pseq([
			d,
			(freq: 300, dur: 0.3),
			d,
			(freq: [400, 770, 800], dur: 1),
			d,
			(freq: 451, dur: 0.33)
		], inf).play;
		);
		
		d[\freq] = [900, 1002, 1102];
		d[\freq] = [200, 101, 1102];
		
		


