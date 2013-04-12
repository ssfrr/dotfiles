UnixFILE

superclass: IOStream

An abstract class.  See File and Pipe



( docs incomplete )

isOpen

returns whether the file is open. An open request can fail if a file cannot be found for example. 
This method lets you test that the open call succeeded.



length

Answer the length of the file.

pos

Answer the current file position

seek(offset, origin)

Seek to an offset from the origin. 
offset - an offset in bytes.
origin - one of the following Integers:

	0 - seek from beginning of file.
	1 - seek from current position in file.
	2 - seek from end of file.
	


write(item)

Writes an item to the file.
item - one of the following: 
	Float 
	Integer, 
	Char, 
	Color, 
	Symbol - writes the name of the Symbol as a C string.
	RawArray - write the bytes from any RawArray in big endian.





getLine

Reads and returns a String up to lesser of next newline or 1023 chars.

getChar

read one byte and return as a Char

getInt8

read one byte and return as a Integer.

getInt16

read two bytes and return as an Integer.

getInt32

read four bytes and return as an Integer.

getFloat

read four bytes and return as a Float.

getDouble

read eight bytes and return as a Float.

putChar

write a Char as one byte.

putInt8

write an Integer as one byte.

putInt16

write an Integer as two bytes.

putInt32

write an Integer as four bytes.

putFloat

write a Float as four bytes.

putDouble

write a Float as eight bytes.

putString

write a null terminated String.

readAllString

Reads the entire file as a String.

readAllInt8

Reads the entire file as an Int8Array.

readAllInt16

Reads the entire file as an Int16Array.

readAllInt32

Reads the entire file as an Int32Array.

readAllFloat

Reads the entire file as an FloatArray.

readAllDouble

Reads the entire file as an DoubleArray.


