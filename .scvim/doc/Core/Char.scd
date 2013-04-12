Char		ascii characters

Chars may be written as literals using the $ sign. For example $a, $b, $c.
See section [01 Literals]

Chars may be created from Integers using the Integer methods asAscii and asDigit.

Conversion

ascii

answers the integer ascii value of a Char.

digit

answers an integer value from 0 to 9 for chars $0 to $9, and values 10 to 35 for chars $a to $z
or $A to $Z.

toUpper

answers the upper case version of a char. Nonalphabetic chars return themselves.

toLower

answers a lower case version of a char. Nonalphabetic chars return themselves.

Testing

isAlpha

answers whether the char is an alphabetic character.

isAlphaNum

answers whether the char is an alphabetic or numeric character.

isPrint

answers whether the char is printable.

isPunct

answers whether the char is a punctuation character

isSpace

answers whether the char is white space.

 isDecDigit
 
 answers whether the char is a decimal digit $0 to $9.
 
 isFileSafe
 
 answers whether the char is safe for use as in a filename.
 excludes the path separators / and : 
 
 
 for(0,255,{ arg i;
	var a;
	[i,a = i.asAscii,a.isAlphaNum,a.isPrint,a.isPunct,a.isControl].postln;
});


 


