matchItem			test if object fulfils a constraint	

Implemented by: Object,  Collection, Nil, Function

matchItem(item) may be passed to different objects that behave as constraints. More Objects may be conceived to implement matchItem to extend the interface.

See also: Dictionary matchAt.

implementations:

	Object:matchItem(item)
		Test if item is identical to object.
		
		a = [1, 2, 3, "wort", "1", [pi, 2pi]];
		a.any { |x| x.matchItem(3) }; // true
		a.any { |x| x.matchItem(5) }; // false
		a.any { |x| x.matchItem("wort") }; // false, because "wort" == "wort" but not identical.

		
	Collection:matchItem(item)
		Test if item is included in collection.
		
		a = [1, 2, 3, "wort", "1", [pi, 2pi]];
		a.any { |x| x.matchItem(pi) }; // true
	
				
	Nil:matchItem(item)
		returns true (Nil serves as a "joker", a stand-in for anything).
		
		a = [nil, 1, 2, 3, "wort", "1", [pi, 2pi]];
		a.any { |x| x.matchItem(10000.rand) }; // true always
	
		
	Function:matchItem(item)
		Test item by passing it to a function which should return a Boolean.
		
		a = [10, 20, 30, { |item| item.isPrime }];
		a.any { |x| x.matchItem(3) }; // true
		a.any { |x| x.matchItem(4) }; // false
		a.any { |x| x.matchItem(10) }; // true
		





