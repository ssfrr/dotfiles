ObjectTable			associate objects with IDs

Inherits from: Object : Collection : TwoWayIdentityDictionary

An ObjectTable is used to associate an id with an object. This is useful
for enabling references to objects on remote systems via Open Sound Control.


*init

Create the main ObjectTable. This is called in Main::startUp.


*add(obj)

Put an object in the main ObjectTable and generate an Integer id.
obj - the object to put in the table.


add(obj)

Put an object in an ObjectTable and generate an Integer id.
obj - the object to put in the table.


*put(key, obj)

Put an object in the main ObjectTable under a specific key. 
key - a Symbol.
obj - the object to put in the table.


*at(id)

Get an object in the main ObjectTable.
id - an Integer or Symbol.


*getID(obj)

Get the ID of an object in the table.
obj - an object in the table.



