String					array of characters

Inherits from: Object : Collection : SequenceableCollection : ArrayedCollection : RawArray

String represents an array of characters.
Strings can be written literally using double quotes:

"my string".class.postln;

Class Methods

*readNew(file)

Read the entire contents of a File and return them as a new String.

Instance Methods

at(index)

Strings respond to .at in a manner similar to other indexed collections. Each element is a Char.

"ABCDEFG".at(2).postln;

compare(aString)

Returns a -1, 0, or 1 depending on whether the receiver should be sorted before the argument,
is equal to the argument or should be sorted after the argument. This is a case sensitive compare.

< aString

Returns a Boolean whether the receiver should be sorted before the argument.

== aString

Returns a Boolean whether the two Strings are equal.

post

Prints the string to the current post window.

postln

Prints the string and a carriage return to the current post window.

postc 	postcln

As post and postln above, but formatted as a comment.

"This is a comment.".postcln;


postf

Prints a formatted string with arguments to the current post window. The % character in the format string is replaced by a string representation of an argument. To print a % character use \\% .

postf("this % a %. pi = %, list = %\n", "is", "test", pi.round(1e-4), (1..4))

this is a test. pi = 3.1416, list = [ 1, 2, 3, 4 ]

format

Returns a formatted string with arguments. The % character in the format string is replaced by a string representation of an argument. To print a % character use \\% .

format("this % a %. pi = %, list = %\n", "is", "test", pi.round(1e-4), (1..4))

this is a test. pi = 3.1416, list = [ 1, 2, 3, 4 ]

matchRegexp(string, start, end)

POSIX regular expression matching. 
Returns true if the receiver (a regular expression pattern) matches the string passed to it.
The start is an offset where to start searching in the string (default: 0), end where to stop.

"c".matchRegexp("abcdefg", 2, 5); // true
"c".matchRegexp("abcdefg", 4, 5); // false

"behaviou?r".matchRegexp("behavior"); // true
"behaviou?r".matchRegexp("behaviour"); // true
"behaviou?r".matchRegexp("behavir"); // false
"b.h.v.r".matchRegexp("behavor"); // true
"b.h.vi*r".matchRegexp("behaviiiiir"); // true
"(a|u)nd".matchRegexp("und"); // true
"(a|u)nd".matchRegexp("and"); // true
"[a-c]nd".matchRegexp("ind"); // false
"[a-c]nd".matchRegexp("bnd"); // true

findRegexp(string)

POSIX regular expression search. 

"foobar".findRegexp("o*bar");

"32424 334 /**aaaaaa*/".findRegexp("/\\*\\*a*\\*/");

"foobar".findRegexp("(o*)(bar)");

"aaaabaaa".findAllRegexp("a+");


error

Prepends an error banner and posts the string

warn

Prepends a warning banner and posts the string.

inform

Posts the string.

++ aString

Return a concatenation of the two strings.

+ aString

Return a concatenation of the two strings with a space between them.

compile

Compiles a String containing legal SuperCollider code and returns a Function.

(
var f;
f = "2 + 1".compile.postln;
f.value.postln;
)

asCompileString

Returns a String formatted for compiling.

(
var f;
f = "myString";
f.postln;
f.asCompileString.postln;
)

postcs

As postln, but posts the compileString of the receiver

List[1, 2, ["comment", [3, 2]], { 1.0.rand }].postcs;

interpret

Compile and execute a String containing legal SuperCollider code, returning the result.

"2 + 1".interpret.postln;

interpretPrint

Compile, execute and print the result of a String containing legal SuperCollider code.

"2 + 1".interpretPrint;

asSymbol

Return a Symbol derived from the String.

(
var z;
z = "myString".asSymbol.postln;
z.class.postln;
)

asInteger

Return an Integer derived from the String. Strings beginning with non-numeric characters return 0.

"4".asInteger.postln;

asFloat

Return a Float derived from the String. Strings beginning with non-numeric characters return 0.

"4.3".asFloat.postln;

asSecs

Return a Float based on converting a time string in format (dd):hh:mm:ss.s.
This is the inverse method to SimpleNumber:asTimeString. 
 
(45296.asTimeString).asSecs;
"32.1".asSecs;
"62.1".asSecs;		// warns
"0:0:59.9".asSecs;
"1:1:1.1".asSecs;
"-1".asSecs;			// neg sign supported
"-12:34:56".asSecs;
"12:-34:56".asSecs;	// warns
"-23:12.3456".asSecs;	//
"-1:00:00:00".asSecs;	// days too.

catArgs(... args)

Concatenate this string with the following args.

"These are some args: ".catArgs(\fish, SinOsc.ar, {4 + 3}).postln;

scatArgs(... args)

Same as catArgs, but with spaces in between.

"These are some args: ".scatArgs(\fish, SinOsc.ar, {4 + 3}).postln;

ccatArgs(... args)

Same as catArgs, but with commas in between.

"a String".ccatArgs(\fish, SinOsc.ar, {4 + 3}).postln;

catList(list)	scatList(list)	ccatList(list)

As catArgs, scatArgs and ccatArgs above, but takes a Collection (usually a List or an Array) as an argument. 

"a String".ccatList([\fish, SinOsc.ar, {4 + 3}]).postln;

split(separator)

Returns an Array of Strings split at the separator. The separator is a Char, and is not included in the output array. The default separator is $/, handy for Unix paths.

"This/could/be/a/Unix/path".split.postln;
"These are several words".split($ ).postln;

ascii

Returns an Array of asci numbers of the Strings's characters.

"wertvoll".ascii;


find(string, ignoreCase, offset)

Returns the index of the string in the receiver, or nil if not found. If ignoreCase is true, find makes no difference between uppercase and lowercase letters. The offset is the point in the string where the search begins.

"These are several words".find("are").postln;
"These are several words".find("fish").postln;

findBackwards(string, ignoreCase, offset)

Same like find, but starts at the end of the string.

// compare:
"These words are several words".find("words"); // 6
"These words are several words".findBackwards("words"); // 24

findAll(string,  ignoreCase, offset)

Returns the indices of the string in the receiver, or nil if not found.

"These are several words which are fish".findAll("are").postln;
"These are several words which are fish".findAll("fish").postln;

contains(string)

Returns a Boolean indicating if the String contains string.

"These are several words".contains("are").postln;
"These are several words".contains("fish").postln;

containsi(string)

Same as contains, but case insensitive.

"These are several words".containsi("ArE").postln;

containsStringAt(index, string)

Returns a Boolean indicating if the String contains string beginning at the specified index.

"These are several words".containsStringAt(6, "are").postln;

icontainsStringAt(index, string)

Same as containsStringAt, but case insensitive.

escapeChar(charToEscape)

Add the escape character (\) at the location of your choice.

"This will become a Unix friendly string".escapeChar($ ).postln;

tr(from, to)

Transliteration. Replace all instances of from with to.

":-(:-(:-(".tr($(, $)); //turn the frowns upside down

replace(find, replace)

Like tr, but with strings as arguments.

"Here are several words which are fish".replace("are", "were");

printOn(stream)

Print the String on stream.

"Print this on Post".printOn(Post);

// equivalent to:
Post << "Print this on Post";

storeOn(stream)

Same as printOn, but formatted asCompileString.

"Store this on Post".storeOn(Post);

// equivalent to:
Post <<< "Store this on Post";

inspectorClass

Returns class StringInspector.

stripRTF

Returns a new String with all RTF formatting removed.

(
// same as File-readAllStringRTF
g = File("/code/SuperCollider3/build/Help/UGens/Chaos/HenonC.help.rtf","r");
g.readAllString.stripRTF.postln;
g.close;
)

Unix Support

Where relevant, the current working directory is the same as the location of the SuperCollider app and the shell is the Bourne shell (sh). Note that the cwd, and indeed the shell itself, does not persist:

"echo $0".unixCmd; // print the shell (sh)
"pwd".unixCmd;
"cd Help/".unixCmd;
"pwd".unixCmd;

"export FISH=mackerel".unixCmd;
"echo $FISH".unixCmd;

It is however possible to execute complex commands:

"pwd; cd Help/; pwd".unixCmd;
"export FISH=mackerel; echo $FISH".unixCmd;

Also on os x applescript can be called via osascript:

"osascript -e 'tell application \"Safari\" to activate'".unixCmd;

Should you need an environment variable to persist you can use setenv (see below).

NOTE: Despite the fact that the method is called 'unixCmd', it does work in Windows. The string must be a DOS command, however: "dir" rather than "ls" for instance.

unixCmd(action, postOutput)

Execute the String on the command line using the Bourne shell (sh). Returns the pid of the newly created process (use Integer.pidRunning to test if a pid is alive). action is a Function that is called when the process has exited. It is passed two arguments: the exit code and pid of the exited process. postOutput is a Boolean that controls whether or not the output of the process is displayed in the post window.

"ls Help".unixCmd;

"echo one; sleep 1; echo two; sleep 1".unixCmd { |res, pid| [\done, res, pid].postln };

unixCmdGetStdOut

Similar to unixCmd except that the stdout of the process is returned (synchronously) rather than sent to the post window.

~listing = "ls Help".unixCmdGetStdOut; // Grab
~listing.reverse.as(Array).stutter.join.postln; // Mangle

runInTerminal

Execute the String in a new terminal window. (The string is incorporated into a temporary script file and executed using a shell. "/usr/bash" is the default shell used but you can optionally specify which shell to use as an argument.)

"echo ---------Hello delightful SuperCollider user----------".runInTerminal;

setenv(value)

Set the environment variable indicated in the string to equal the String value. This value will persist until it is changed or SC is quit. Note that if value is a path you may need to call standardizePath on it (see below).

// all defs in this directory will be loaded when a local server boots
"SC_SYNTHDEF_PATH".setenv("~/scwork/".standardizePath); 
"echo $SC_SYNTHDEF_PATH".unixCmd;

getenv

Returns the value contained in the environment variable indicated by the String.

"USER".getenv;

pathMatch

Returns an Array containing all paths matching this String. Wildcards apply, non-recursive.

Post << "Help/*".pathMatch;

loadPaths

Perform pathMatch (see above) on this String, then load and execute all paths in the resultant Array.

"Help/Collections/loadPaths example.scd".loadPaths; //This file posts some text

load

Load and execute the file at the path represented by the receiver.

loadRelative

Load and execute the file at the path represented by the receiver, interpreting the path as relative to the current document or text file. Requires that the file has been saved.

resolveRelative

Convert the receiver from a relative path to an absolute path, relative to the current document or text file. Requires that the current text file has been saved. Absolute paths are left untransformed.

standardizePath

Expand ~ to your home directory, and resolve symbolic links. See PathName for more complex needs.

"~/".standardizePath; //This will print your home directory

basename

Return the filename from a Unix path.

"Imaginary/Directory/fish.rtf".basename;

dirname

Return the directory name from a Unix path.

"Imaginary/Directory/fish.rtf".dirname;

splitext

Split off the extension from a filename or path and return both in an Array as [path or filename, extension].

"fish.rtf".splitext;
"Imaginary/Directory/fish.rtf".splitext;

Document Support

newTextWindow(title, makeListener)

Create a new Document with this.

"Here is a new Document".newTextWindow;

openDocument

Create a new Document from the path corresponding to this. Returns the Document.

(
d = "Help/Help.html".openDocument;
d.class;
)

openTextFile(selectionStart, selectionLength)

Create a new Document from the path corresponding to this. The selection arguments will preselect the indicated range in the new window. Returns this.

(
d = "Help/Help.html".openTextFile(20, 210);
d.class;
)

findHelpFile

Returns the path for the helpfile named this, if it exists, else returns nil.

"Document".findHelpFile;
"foobar".findHelpFile;

openHelpFile

Performs foundHelpFile(above) on this, and opens the file it if it exists, otherwise opens the main helpfile.

"Document".openHelpFile;
"foobar".openHelpFile;

speak(channel, force)

Sends string to the speech synthesisier of the OS. (OS X only.) see: Speech

"hi i'm talking with the default voice now, i guess".speak;



Drawing Support

The following methods must be called within an Window-drawHook or a SCUserView-drawFunc function, and will only be visible once the window or the view is refreshed. Each call to Window-refresh SCUserView-refresh will 'overwrite' all previous drawing by executing the currently defined function.

See also: Window, SCUserView, Color, and Pen.


Note: for cross-platform GUIs, use Pen.stringAtPoint, Pen.stringInRect, Pen.stringCenteredIn, Pen.stringLeftJustIn, Pen.stringRightJustIn instead.


draw
	
Draws the String at the current 0@0 Point. If not transformations of the graphics state have taken place this will be the upper left corner of the window. See also Pen.

(
w = Window.new.front;
w.view.background_(Color.white);
w.drawHook = {
	"abababababa\n\n\n".scramble.draw
};
w.refresh
)

drawAtPoint(point, font, color)

Draws the String at the given Point using the Font and Color specified.

(
w = Window.new.front;
w.view.background_(Color.white);
w.drawHook = {
	"abababababa\n\n\n".scramble.drawAtPoint(
		100@100, 
		Font("Courier", 30), 
		Color.blue(0.3, 0.5))
};
w.refresh
)

drawInRect(rect, font, color)

Draws the String into the given Rect using the Font and Color specified.

(
w = Window.new.front;
r = Rect(100, 100, 100, 100);
w.view.background_(Color.white);
w.drawHook = {
	"abababababa\n\n\n".scramble.drawInRect(r, Font("Courier", 12), Color.blue(0.3, 0.5));
	Pen.strokeRect(r);
};
w.refresh
)

drawCenteredIn(rect, font, color)

Draws the String into the given Rect using the Font and Color specified.

(
w = Window.new.front;
w.view.background_(Color.white);
r = Rect(100, 100, 100, 100);
w.drawHook = {
	"abababababa\n\n\n".scramble.drawCenteredIn(
		r, 
		Font("Courier", 12), 
		Color.blue(0.3, 0.5)
	);
	Pen.strokeRect(r);
};
w.refresh
)

drawLeftJustIn(rect, font, color)

Draws the String into the given Rect using the Font and Color specified.

(
w = Window.new.front;
w.view.background_(Color.white);
r = Rect(100, 100, 100, 100);
w.drawHook = {
	"abababababa\n\n\n".scramble.drawLeftJustIn(
		r, 
		Font("Courier", 12), 
		Color.blue(0.3, 0.5)
	);
	Pen.strokeRect(r);
};
w.refresh
)

drawRightJustIn(rect, font, color)

Draws the String into the given Rect using the Font and Color specified.

(
w = Window.new.front;
w.view.background_(Color.white);
r = Rect(100, 100, 100, 100);
w.drawHook = {
	"abababababa\n\n\n".scramble.drawRightJustIn(
		r, 
		Font("Courier", 12), 
		Color.blue(0.3, 0.5)
	);
	Pen.strokeRect(r);
};
w.refresh
)


