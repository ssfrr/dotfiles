TabFileReader			file reader for tab separated data

Inherits from: Object : AbstractFunction : Stream : FileReader

TabFileReader reads tab/return delimited files into 2D arrays.

For comma-separated files, use: CSVFileReader.
For space-delimited files, or custom delimiters, use: FileReader

*read(path, skipEmptyLines)
(
// write a test file:
f = File("TabDelTest.sc", "w");
f.write(
"Some	tab-	delimited	items	in	line	1

and	then	some	more	in	line	3
"
);
f.close; 
)


	// open file, read and put strings into array, close file. 
x = TabFileReader.read("TabDelTest.sc").postcs;

	// can skip empty lines: 
x = TabFileReader.read("TabDelTest.sc", true).postcs;
	
	// do file open/close by hand if you prefer:
f = File("TabDelTest.sc", "r"); f.isOpen;
t = TabFileReader(f);	
t.read;
f.close;

(
// write a test file with numbers:
f = File("TabDelTestNum.sc", "w");

(1..10).do { |n| f.write(n.asString ++ Char.tab); };
f.close; 
)

x = TabFileReader.read("TabDelTestNum.sc").postcs;
x.collect(_.collect(_.interpret));	// convert to numbers.

			// or you can do it immediately:
x = TabFileReader.readInterpret("TabDelTestNum.sc").postcs;

(
// write a test file with numbers:
f = File("TabDelTestNum.sc", "w");

(1..100).do { |n| 
	f.write(n.asString ++ if (n % 10 != 0, Char.tab, Char.nl)); };
f.close; 
)


x = TabFileReader.readInterpret("TabDelTestNum.sc").postln;



