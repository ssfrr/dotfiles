File

Superclass: UnixFILE

A class for reading and writing files.  Not sound files.

see also the superclass for further docs.

	*new(pathname, mode)
	
		Create a File instance and open the file. If the open fails, isOpen will return false.
	
	pathname
	
		a String containing the path name of the file to open.
	
	mode
		a String indicating one of the following modes:
	
		"r" - Opens a file for reading. The file must exist.
		"w" - Creates an empty file for writing. If a file with the
		      same name already exists its content is erased and the
		      file is treated as a new empty file.
		"a" - Appends to a file. Writing operations append data at
		      the end of the file. The file is created if it does
		      not exist.
		      
		"rb", "wb", "ab" - same as above, but data is binary
		
		"r+" - Opens a file for update both reading and writing. The
		       file must exist.
		"w+" - Creates an empty file for both reading and writing. If
		       a file with the same name already exists its content
		       is erased and the file is treated as a new empty file.
		"a+" - Opens a file for reading and appending. All writing
		       operations are performed at the end of the file,
		       protecting the previous content to be overwritten. You
		       can reposition the internal pointer using the seek
		       method to anywhere in the file for reading, but writing
		       operations will move it back to the end of file. The
		       file is created if it does not exist.

		"rb+", wb+", "ab+" - same as above, but data is binary
	
	open
	
		Open the file. Files are automatically opened upon creation, so this call is only necessary 
		if you are closing and opening the same file object repeatedly.
	
		NOTE:  it is possible when saving files with a standard file dialog to elect to "hide the extension" 
		and save it as RTF.  When opening the file you must specify the real filename:  "filename.rtf", 
		even though you can't see in file load dialogs or in the Finder.
	
	
	close
		Close the file.


	*open(pathname, mode)
		same as *new, but a more intuitive name.
	
	*exists(pathName)
		answers if a file exists at that path.
	
	 
	*delete(pathName)
		deletes the file at that path.
		use only for good, never for evil.
	
	 
	*openDialog(prompt,sucessFunc,cancelFunc)
	
		
	*saveDialog("hello",{},{})
		not yet implemented
	
	
	*getcwd
		POSIX standard 'get current working directory'.
	
		// example;
		File.getcwd
	
	*use(function)
		open the file, evaluate the function with the file and close it.
		
	readAllString
		Reads the entire file as a String.
		
	readAllStringRTF
		Reads the entire file as a String, stripping RTF formatting.

	seek(offset, origin)
		moves the read/write pointer to a given location in the file,
		where offset is location given in bytes, and origin is the
		reference of the offset:
		0 - offset is from the beginning of the file
		1 - offset is relative to the current position
		    in the file
		2 - offset is from the end of the file

	pos
		returns the current position in the file (in bytes)

	pos_(value)
		a shortcut for seek(0, value), so moves to a given location
		from the beginning of the file. the value is clipped so that it
		lies between 0 inclusively and the file length exclusively.
		
	length
		returns the current file size in bytes
		

Examples:

// write some string to a file:
(
var f, g;
f = File("test","w");
f.write("Does this work?\n is this thing on ?\n");
f.close;
)

// read it again:
(
g = File("test","r");
g.readAllString.postln;
g.close;
)

// try the above with File.use:

File.use("test", "w", { |f| f.write("Doesn't this work?\n is this thing really on ?\n"); })
File.use("test", "r", { |f| f.readAllString.postln })


// more file writing/reading examples:
(
var h, k;
h = File("test2", "wb");
h.inspect;
h.write( FloatArray[1.1, 2.2, 3.3, pi, 3.sqrt] );
h.close;

k = File("test2", "rb");
(k.length div: 4).do({ k.getFloat.postln; });
k.close;
)


(
var f, g;
f = File("test3","w");
100.do({ f.putChar([$a, $b, $c, $d, $e, $\n].choose); });
f.close;

g = File("test3","r");
g.readAllString.postln;
g.close;

g = File("test3","r");
g.getLine(1024).postln;
"*".postln;
g.getLine(1024).postln;
"**".postln;
g.getLine(1024).postln;
"***".postln;
g.getLine(1024).postln;
"****".postln;
g.close;

)

(
//var f, g;
f = File("test3","wb");
f.inspect;
100.do({ f.putFloat(1.0.rand); });

f.inspect;
f.close;

g = File("test3","rb");
100.do({
	g.getFloat.postln;
});
g.inspect;
g.close;

)

(
//var f, g;
f = File("test3","r");
f.inspect;

f.getLine(1024).postln;

f.close;


)

putInt8

put a signed integer value between -128 and 127




