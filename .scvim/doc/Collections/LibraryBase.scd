LibraryBase			global storage base class	

Inherits from: Object : Collection : MultiLevelIdentityDictionary

Base class for Library and Archive

There is only one global instance: Archive.global, or Library.global, which is initialized automatically in the subclasses.

Class Methods

	*global
	*global_(obj)
		subclass responsibility
		
	*clear
		clear the dictionary
		
	*at(key1, key2, ...)
		access the dictionary at a path with keys. The keys may be any object, but are usually Symbols
	
	*put(key1, key2, ... obj)
		store an object in the dictionary at a path, given as a list of keys and the object to be stored as last argument. The keys may be any object, but are usually Symbols.
		
	*atList(args)
		access the dictionary at a path, given as a list of keys. The keys may be any object, but are usually Symbols.
	
	*putList(args)
		store an object in the dictionary at a path, given as a list of keys and the object to be stored as last argument. The keys may be any object, but are usually Symbols.
	
			

Examples

// an example from the subclass Library:

Library.put(\multi, \level, \addressing, \system, "i'm the thing you are putting in here");

Library.at(\multi, \level, \addressing, \system).postln;

Library.atList([\multi, \level, \addressing, \system]).postln;



