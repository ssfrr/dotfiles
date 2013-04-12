Library			keeping objects in a central place

Inherits from: Object : Collection : MultiLevelIdentityDictionary : LibraryBase

Library is a global MultiLevelIdentityDictionary.

see also: Archive, LibraryBase

Methods: see superclass.

The last argument to put is the object being inserted:

Library.put(\multi, \level, \addressing, \system, "i'm the thing you are putting in here");

Library.at(\multi, \level, \addressing, \system).postln;

Library.atList([\multi, \level, \addressing, \system]).postln;

The Library can be used as a place to store data that you want globally accesible.  Its an alternative to using class variables.  Its a nice place to store menus, annotations, and commonly reusable functions.

postTree
	post a formatted description of the entire library
	
	Library.postTree;


