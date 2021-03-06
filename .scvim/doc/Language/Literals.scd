Literals

Literals are values which have a direct syntactic representation. 
The following sections describe the types of literals that can be represented.

Numbers

An integer is any series of digits optionally preceeded by a minus sign.
examples of integers :
	-13      
	666      
	2112      
	96

A float is one or more decimal digits followed by a decimal point followed by one or more decimal digits. 
You must have digits on both sides of the decimal point.  This distinguishes floating point numbers from 
integer expressions like:

	8.rand
 
examples of floats :
	0.39      
	98.6      
	1.0      
	-0.5     

Exponential notation is also supported.

	1.2e4
	1e-4

The constant pi can be appended to a number to create floating point constant:

	2pi    
	0.5pi
	-0.25pi
	
Numbers can also be written in radices other than base 10 up to base 36. 
The radix is specified in base 10 followed by the letter 'r' followed by the value written in
that radix using characters 0-9,A-Z, or a-z, for digit values from 0 to 35. 
For example you can write hexidecimal numbers as follows:

16rF0
16rA9FF

Binary numbers can be written as follows:

2r01101011

Floating point values may also be specified in any base:

12r4A.A

Characters

Characters are preceeded by a dollar sign:
	$A     
	$B     
	$C       

Tab, linefeed, carriage return, and backslash are preceeded by a backslash:
	$\t
	$\n
	$\r
	$\\


Symbols 

A symbol is written as a string enclosed in single quotes. 
examples of symbols:

	'x'
	'aiff'
	'BigSwiftyAndAssoc'
	'nowhere here'  
	'somewhere there' 
	'.+o*o+.'
	
A symbol consisting of a single word can be written with a preceeding backslash.

	\x
	\aiff
	\BigSwiftyAndAssoc

Strings

Strings are written in double quotes:

	"This is a string."
	
If two or more strings are lexically adjacent, then they combine into a larger string. 

example:

	"This" " is " "also a " "string."

Strings may span more than one line. If so, then the new line characters become part of the string.
example:

"This
is 
also a
string.
"
	
Identifiers 

Names of methods and variables begin with a lower case alphabetic character, followed  by zero or more 
alphanumeric characters. 

var abc, z123, func;


Class Names

Class names always begin with a capital letter followed  by zero or more  alphanumeric characters.

Object
Point
Synth


Special Values

The singular instances of the classes True, False and Nil are written as the 
words true, false, nil and inf.

x = true;
y = false;
z = nil;

Literal Arrays

Arrays of literals are created at compile time and are written with a # preceeding the array as follows:

#[1, 2, 'abc', "def", 4]

Literal Arrays must be used as is and may not be altered at run time.

In literal Arrays names are interpreted as symbols. This is not the case in regular Arrays, where they are interpreted as variable names:

#[foo, bar]	// this is legal; an Array of Symbols
[foo, bar]	// this is only legal if foo and bar have been declared as variables

Arrays and other collections may also be created dynamically which is explained in Collections.help.
Using a literal Array is faster than building an array dynamically every time you need it.

When nesting literal arrays, only the outermost literal array needs the '#' character.

#[[1, 2, 3], [4, 5, 6]]

Literal Arrays can be useful for things such as tables of constants, for example note names:

(
// build a table of note names
var table = ();
value {
	var semitones = [0, 2, 4, 5, 7, 9, 11];
	var naturalNoteNames = ["c", "d", "e", "f", "g", "a", "b"];

	(0..9).do {|o|
		naturalNoteNames.do {|c, i|
			var n = (o + 1) * 12 + semitones[i];
			table[(c ++ o).asSymbol] = n;
			table[(c ++ "s"  ++ o).asSymbol] = n + 1;
			table[(c ++ "ss" ++ o).asSymbol] = n + 2;
			table[(c ++ "b"  ++ o).asSymbol] = n - 1;
			table[(c ++ "bb" ++ o).asSymbol] = n - 2;
		};
	};
};

// translate note names to midi keys
table.atAll(#[c4, e4, gs4, c5, e5, gs5, c6])
)



