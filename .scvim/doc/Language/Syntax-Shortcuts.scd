Syntax Shortcuts

This file shows a number of syntax equivalences in the compiler.

__________________________________________________________________________

Example: multiple ways to write the same thing.
			
Because of the multiple syntax equivalences, some expressions can be written in many different ways. All of the following do the same thing and compile to the same code. 

// new argument syntax

(1..10).collect({|n| n.squared }); // receiver syntax

collect((1..10), {|n| n.squared }); // function call syntax

(1..10).collect {|n| n.squared }; // receiver syntax with trailing function arg

collect ((1..10)) {|n| n.squared }; // function call syntax with trailing function arg

(1..10) collect: {|n| n.squared }; // binary operator syntax


// old argument syntax

(1..10).collect({ arg n; n.squared }); // receiver syntax

collect((1..10), { arg n; n.squared }); // function call syntax

(1..10).collect { arg n; n.squared }; // receiver syntax with trailing function arg

collect ((1..10)) { arg n; n.squared }; // function call syntax with trailing function arg

(1..10) collect: { arg n; n.squared }; // binary operator syntax


// partial application syntax

(1..10).collect( _.squared ); // receiver syntax

collect((1..10), _.squared ); // function call syntax

(1..10) collect: _.squared ; // binary operator syntax


You could even start expanding out the equivalent of (1..10) which is really a shortcut for series(1, nil, 10). This could also be written 1.series(nil,10). This adds another 26 variations to the 13 variations above.

__________________________________________________________________________

			functional and receiver notation

instead of writing:					you can write:

f(x, y)								x.f(y)
f(g(x))								x.g.f

			defining instance variable accessor methods

instead of writing:					you can write:
								
Thing { var x;  					Thing { var <>x; }	
	x { ^x }  
	x_ { arg z; x = z; } 
}				

			calling an instance variable setter method

instead of writing:					you can write:

p.x_(y)								p.x = y;							
			use a selector as binary operator

instead of writing:					you can write:

min(x, y)							x min: y

			multiple assignment

instead of writing:					you can write:

x = z.at(0); y = z.at(1);			# x, y = z;

			get environment variable

instead of writing:					you can write:

'myName'.envirGet					~myName

			set environment variable

instead of writing:					you can write:

'myName'.envirSet(9);				~myName = 9;

			instantiate object

instead of writing:					you can write:

Point.new(3, 4);					Point(3, 4)

			create a collection

instead of writing:					you can write:

Set.new.add(3).add(4).add(5);		Set[3, 4, 5]

			moving blocks out of argument lists

instead of writing:					you can write:

if (x<3, {\abc}, {\def});			if (x<3) {\abc} {\def}

z.do({|x| x.play });				z.do {|x| x.play };

while({ a < b },{ a = a * 2 });		while { a < b } { a = a * 2 };

			shorter argument lists

instead of writing:					you can write:

{ arg x; x < 2 }					{|x| x < 2 }

			shorthand for Symbols

instead of writing:					you can write:

'mySymbol'							\mySymbol

			creating a Ref

instead of writing:					you can write:

Ref.new(thing)						`thing

			calling the 'value' method

instead of writing:					you can write:

f.value(x)							f.(x)

			indexing with 'at'

instead of writing:					you can write:

z.at(i)								z[i]

			indexing with 'put'

instead of writing:					you can write:

z.put(i, y);						z[i] = y;

			creating IdentityDictionaries

instead of writing:							you can write:

IdentityDictionary['a'->1,'b'->2]		(a: 1, b: 2)

			creating arithmetic series

instead of writing:									you can write:

Array.series(16,1,1), or  series(1,nil,16)			(1..16)

Array.series(6,1,2), or  series(1,3,11)			(1,3..11)

			accessing subranges of Arrays

instead of writing:							you can write:

a.copyRange(4,8)						a[4..8]

a.copyToEnd(4)							a[4..]

a.copyFromStart(4)						a[..4]


			calling performList

instead of writing:									you can write:

object.performList(\method, a, b, array)		object.method(a, b, *array)


			partial application

instead of writing:									you can write:

{|x| object.msg(a, x, b) }						object.msg(a, _, b)

{|x,y| object.msg(a, x, y) }					object.msg(a, _, _)

{|x| a + x }									a + _

{|x| [a, b, x] }								[a, b, _]

{|x| (a: x) }									(a: _)



__________________________________________________________________________


