writeAsPlist

Object method

object.writeAsPlist(path);

Write the object to disk as a PropertyList.  It is used commonly in OS X to store data.  

This is an XML format that may be read from easily from Objective-C, Java or any language that uses the CoreFoundation(Cocoa) framework.  

Objective-C:

id rootObject = [NSKeyedUnarchiver  unarchiveObjectWithFile: path ];

The file may be double-clicked to open it in Property List Editor.

See also: Archive

 
When opening the PropertyList:

your SC objects are converted to Foundation objects in this fashion:

SimpleNumber -> NSNumber.
SequenceableCollection -> NSArray with each item converted
String -> NSString
Symbol -> NSString
Char -> NSString
Nil -> NSNull
Boolean ->NSNumber (numberWithBool:) equivalent to a CFBoolean
Dictionary ->NSDictionary (each item converted)
	
Other objects  -> NSNull

Most commonly the root object is an NSDictionary or NSArray.


4.0.writeAsPlist("testWritePlist.plist");

4.writeAsPlist("testWritePlist.plist");

"string".writeAsPlist("testWritePlist.plist");

'symbol'.writeAsPlist("testWritePlist.plist");

$c.writeAsPlist("testWritePlist.plist");

nil.writeAsPlist("testWritePlist.plist");

true.writeAsPlist("testWritePlist.plist");

false.writeAsPlist("testWritePlist.plist");

[1,false,'symbol'].writeAsPlist("testWritePlist.plist");

List[1,false,\symbol].writeAsPlist("testWritePlist.plist");

// cannot convert these objects
[Ref(pi), Pbind.new].writeAsPlist("testWritePlist.plist");

Dictionary[
	\a -> "a",
	"b" -> \b,
	3 -> 3.0
	].writeAsPlist("testWritePlist.plist");


IdentityDictionary[
	\a -> "a",
	"b" -> \b,
	3 -> 3.0
	].writeAsPlist("testWritePlist.plist");
	
	


