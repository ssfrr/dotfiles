FunctionDef

superclass: Object

FunctionDefs contain code which can be executed from a Function.

Accessing

Even though it is possible to change the values in the various arrays that define the FunctionDef,
you should not do it, unless you like to crash.

code

Get the byte code array.

{ |a = 9, b = 10, c| a + b }.def.code;

sourceCode

Get the source code string.

{ |a = 9, b = 10, c| a + b }.def.sourceCode.postcs;

context

Get the enclosing FunctionDef or Method.

findReferences(aSymbol)

return a list of all references to a given symbol.

argNames

Get the Array of Symbols of the argument names.

{ |a = 9, b = 10, c| a + b }.def.argNames;

prototypeFrame

Get the array of default values for argument and temporary variables.

{ |a = 9, b = 10, c| a + b }.def.prototypeFrame;

varNames

Get the Array of Symbols of the local variable names.

{ |a = 9, b = 10, c| var x = 9; a + b + x }.def.varNames;


argumentString

Return a string that contains  arguments and their default values for embedding in a string

{ |a = 9, b = 10, c| a + b }.def.argumentString;

makeEnvirFromArgs

Get the Array of Symbols of the local variable names.

{ |a = 9, b = 10, c| a + b }.def.makeEnvirFromArgs;


Utilities

dumpByteCodes

"Disassemble" and post the FunctionDef's byte code instructions to the text window. 




