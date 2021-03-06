SCNSObject

Note: this is experimental (03/2006) things might change and be careful wrong or unsupported Cocoa-calls can crash this Application !

Object Creation - LifeCycle

On creation only the init message is passed, alloc is called internally. Instance methods and Class methods are supported by the bridge, but if an object (id or SCNSObject) is returned by the method you owns it (even for autoreleased object - because they are retained internally by SuperCollider), so you must call release when you're done with it (SCNSObject(s) are not automatically garbage collected)

Invocation

Once your Objective-C object is allocated / retained you can call it using invoke

Example:
The Objective-C synthax:
	NSNumber *n = [[NSNumber alloc] initWithFloat: 1.1];
	[n floatValue];
turns into:
	n = SCNSObject("NSNumber", "initWithFloat:", [1.1]);
	n.invoke("floatValue");
	
Multiple messages are put together in one String and their arguments in one Array.

Example:
Cocoa:
	NSWindow *c = [[NSWindow alloc] initWithContentRect: rect styleMask: 10 backing: 2 defer:YES];
SC:
	c = SCNSObject("NSWindow", "initWithContentRect:styleMask:backing:defer:",[Rect(0,0,400,100), 10, 2, 1]);


Deferring your calls

Some methods need to be defered. If you want to defer ust call invoke with defer:true. Watch out there is no smart protection for methods that need defer until now! In general you should defer graphic operations.
So calling this might crash sc-lang:
	c.invoke("makeKeyAndOrderFront:", [nil]);	
but this line is fine:
	c.invoke("makeKeyAndOrderFront:", [nil], true);	


Common Conversion Table

SuperCollider will try to convert types when possible, here are the most common types and their translation
betweem the 2 languages.

SuperCollider Types		->		Objective-C Types			(when using invoke / SCNSObject.new)
----------------------------------------------------------------------------------------------------
SCNSObject						id (NSObject)
Nil								nil, NULL pointer
Number (Float, Integer)				float, int, long, short, char, NSNumber
Boolean							YES, NO, bool, NSNumber
String							NSString, SEL, char*, void*
Rect								NSRect
Color							NSColor
Point							NSPoint, NSRange, NSSize
Int8Array							void*, char*
Int16Array						void*, short*
Int32Array						void*, int*
DoubleArray						void*, double*
FloatArray						void*, float*
Signal							float*
Array							QTTime, NSRange, NSSize, SCNSObject*

Objective-C Types			->		SuperCollider Types		(on method return)
----------------------------------------------------------------------------------------------------
NSString, char*					String
NSColor							Color
NSSize, NSRange, QTTime			Array
NSRect							Rect
NSPoint							Point
BOOL, long, char, int, short			Integer
float, double						Float
c99 _bool							Boolean
*(pointer type)						RawPointer							
id, (any other NSObject)				SCNSObject



Creation / Class Methods

	*new(classname, initname, args, defer)
	
		Creates a new SCNSObject instance. SCNSObject creates a bridge between SuperCollider and Objective-C / Cocoa.
		It holds an NSObject and sends messages to it. The class and messages are passed as Strings. Arguments must be in an Array.
		classname - The Objective-C name of the class you want to invoke / instantiate.
		initname - can be either a class method or an instance initX method, depending on the possible initialization call. You do not need to specify alloc if you instantiate an object, it is automatically done for you.
		args - the Array of arguments for the initname method.
		defer - defer the call. default is false.
		
		a = SCNSObject("NSHost", "currentHost");
		[\name, a.invoke("name"), \address, a.invoke("address")].postln;
		a.release;
	
	*newFromRawPointer(ptr)
		
		Creates a new SCNSObject from a RawPointer. Might be handy for very special occasion.
		
		i = SCImage.new("/Library/Desktop Pictures/Ripples Blue.jpg");
		a = SCNSObject.newFromRawPointer(i.slotAt(0)).invoke("nsimage");
		a.className.postln; // verify :)
		// now do what you want with the NSImage of the SCImage
		i.free; // release it when done
		// you do not have here to release the SCNSObject - it is dangerous to do so in this case
		
	*dumpPool
		
		Dump the current NSObjects in the pool, so retained by SuperCollider.
	
	*freePool
		
		Release all the current NSObjects in the pool and clear it. Call this method only if you really
		know what you are doing : all the SCNSObjects will be unvalidated !
		
		
Instance Methods
	
	invoke(method, args, defer)
		
		Invoke an SCNSObject
		method - The method to call the receiver with
		args - The arguments Array
		defer - defer the call. default is false. (might be needed for GUI otherwise you may experience a crash)
	
	release
		
		Release the internal NSObject retained by the application pool.
		You must call this method when you're done with your object.
		
		Note that it is not fully equivalent to a [myObject release], the NSObject is removed from the pool so if the application is the only one who retained it and owns it, it will properly dealloc it. But if the object is not IN the pool, it won't do anything.
		
		example:
		
		SCNSObject.freePool; // free all object first to see
		i = SCImage.new("/Library/Desktop Pictures/Ripples Blue.jpg"); // create a simple SCImage
		a = SCNSObject.newFromRawPointer(i.slotAt(0)); // get the SCImage object
		a.className; // SCImage
		a.invoke("size");
		SCNSObject.dumpPool; // look, we do not have any NSObject in our pool
		// a.release; // so this won't do anything - just clear our NSObject ref - note that the SCImage is not IN the pool
		a.invoke("retain"); // now we can retain the SCImage - but since the method returns the object it is also added - retained also in the pool !
		i.free; // release the SCImage
		SCNSObject.dumpPool; // look the SCImage is here
		a.invoke("release"); // now we have to release it twice
		SCNSObject.dumpPool; //
		a.release; // should be fine
		
	initAction(actionName)
		
		Creates a CocoaAction, a special delegate to handle Target / Action mechanism (See explainations above). initAction is a convenience method to add an action to a gui element, mostly for NSControl subclasses. Once an action is setted, a special delegate is created on your behalf to wich you can attach a action. You can access this delegate using the nsAction accessor method.
		actionName - may be "doFloatAction:" (default), "doIntAction:", "doStateAction:" or "doAction:"
		
		(
		var win, topview, slider;
		
		win = SCNSObject("NSWindow", "initWithContentRect:styleMask:backing:defer:", [Rect(100,140,400,30), 10, 2, 1]);
		win.registerNotification("NSWindowWillCloseNotification", {|name, nsnotification, object| 
			[win, topview, slider].do { |obj| obj.release };
			[name, nsnotification, object].postln}
		);
		
		slider = SCNSObject("NSSlider", "initWithFrame:", [Rect(0,0,390,20)]); 
		slider.invoke("setFloatValue:", [0.5]);
		slider.initAction.action_({|v,val| val.postln});
		
		topview = win.invoke("contentView");
		topview.invoke("addSubview:", [slider]);
		
		win.invoke("makeKeyAndOrderFront:", [win], true);
		win.invoke("setTitle:", ["cocoa test"]);
		)
		
	setDelegate
		
		Creates a special CocoaAction delegate object to handle delegate methods and notifications. Should not be confused with the nsAction one. This delegate can be retrieved with the nsDelegate accessor.
		
	registerNotification( aNotificationName, aFunc, obj )
		
		Register a special notification (see NSNotification) with a Function that will be triggered each time it is sent. This method will create a defaut nsDelegate if it does exist already.
		aNotificationName - The name of the notification
		aFunc - The responder function
		obj - the object of the notification, default is this.
		
		(
		var win, delegate;
		win = SCNSObject("NSWindow", "initWithContentRect:styleMask:backing:defer:", [Rect(100,400,400,400), 10, 2, 1]);
		win.registerNotification("NSWindowWillCloseNotification", {|name, nsnotification, object, delegate| 
			[delegate /* the window.nsDelegate */, delegate.object /* the win SCNSObject */, name, nsnotification, object].postln;
			win.release;
		});
		win.invoke("setMinSize:", [[100,100]]);
		win.invoke("makeKeyAndOrderFront:", [win], true);
		win.invoke("setTitle:", ["notification test - Close Me"]);
		)
		
	asArray( arrayType )
		
		SCNSObject holding an NSData object can be converted to array types using the asArray method. 
		arrayType - \string \int8 \int16 \int32 \float \double are the possible argument for an explicit conversion.


		d = SCNSObject.new("NSData", "dataWithBytes:length:", ["hellomydear", 11]); // 11 bytes passed
		e = d.asArray(\string); // get it back as a String
		d.release;
		
		d = SCNSObject.new("NSData", "dataWithBytes:length:", [Int32Array[98,99,100,101], 4*4]); // 4x32bit integers = 16 bytes
		e = d.asArray(\int32); // get it back as an Int32Array
		d.release;
		
		d = SCNSObject.new("NSData", "dataWithBytes:length:", [Int16Array[98,99,100,101], 4*2]); // 4x16bit integers = 8 bytes
		e = d.asArray(\int16); // get it back an Int16Array
		d.release;
		
		
	
	
		
Examples:
//create a window and add a Slider that posts its value.
(
var win, slider;

win = SCNSObject("NSWindow", "initWithContentRect:styleMask:backing:defer:",
	[Rect(100,140,400,30), 10, 2, 1]);
win.setDelegate.action_({ // for NSWindow objects using setDelegate.action will trigger the nsAction.action function when it is closed
	"closing window, releasing objects".postln;
	[slider,e].do{|it| it.release};
});
slider = SCNSObject("NSSlider", "initWithFrame:", [Rect(0,0,390,20)]); 
e = SCNSObject("SCGraphView", "initWithFrame:", [Rect(0,0,400,30)]); 
win.invoke("setContentView:", [e], true);
e.invoke("addSubview:", [slider], true);
slider.invoke("setFloatValue:", [0.5]);
win.invoke("makeKeyAndOrderFront:", [nil], true);
win.invoke("setTitle:", ["cocoa test"]);

{
a = slider.initAction;
a.action_({|v,val| val.postln});}.defer(0.1);
~win = win;
)

~win.className
~win.invoke("close", defer:true);


(
c = SCNSObject("NSWindow", "initWithContentRect:styleMask:backing:defer:",[Rect(0,0,400,100), 10, 2, 1]);
c.setDelegate.action_({ // for NSWindow objects using setDelegate.action will trigger the nsAction.action function when it is closed
	"closing window, releasing objects".postln;
	[c,d,e].do{|it| it.release};
});
d = SCNSObject("NSTextField", "initWithFrame:", [Rect(0,0,100,20)]); 
e = SCNSObject("NSView", "initWithFrame:", [Rect(0,0,400,100)]); 
c.invoke("setContentView:", [e], true);
e.invoke("addSubview:", [d], true);
c.invoke("makeKeyAndOrderFront:", [nil], true);
)



(
c = SCNSObject("NSWindow", "initWithContentRect:styleMask:backing:defer:",[Rect(100,100,100,20), 10, 2, 1]);
c.setDelegate.action_({ // for NSWindow objects using setDelegate.action will trigger the nsAction.action function when it is closed
	"closing window, releasing objects".postln;
	[c,d,e].do{|it| it.release};
});
d = SCNSObject("NSButton", "initWithFrame:", [Rect(0,0,100,20)]); 
e = SCNSObject("NSView", "initWithFrame:", [Rect(0,0,400,100)]); 
c.invoke("setContentView:", [e], true);
e.invoke("addSubview:", [d], true);
c.invoke("makeKeyAndOrderFront:", [nil], true);
d.invoke("setButtonType:", [3]);
{
d.initAction("doStateAction:");
d.nsAction.action_({|it,val| val.postln;});
}.defer(0.1);
)


/*
simple QTMovie example
creates a movie in the SuperCollider folder + adds an image to it
*/

(
d = SCNSObject("NSMutableDictionary", "dictionary");
d.invoke("setObject:forKey:", ["jpeg", "QTAddImageCodecType"]);

e = SCNSObject("NSMutableDictionary", "dictionary");
e.invoke("setObject:forKey:", [true, "QTMovieFlatten"]);

m = SCNSObject("QTMovie", "initToWritableFile:error:", [Platform.classLibraryDir ++ "/../test.mov", nil]); // creates an empty movie
i = SCImage("/Library/Desktop Pictures/Ripples Blue.jpg");

// newFromRawPointer does not need any release so fine to get the invocation result directly
a = SCNSObject.newFromRawPointer(i.slotAt(0)).invoke("nsimage"); // this is how you can create a NSImage from 
m.invoke("addImage:forDuration:withAttributes:", [a, [3, 1], d]); // 3 seconds
m.invoke("updateMovieFile");

[m, d, e].do ({ |object| object.release; });
i.free;
)

// HUD Panels - 10.5 only
(
w = SCNSObject("NSPanel", "initWithContentRect:styleMask:backing:defer:", [Rect(250, 250, 300, 200), (1<<13) + (1<<4) + 4 + 2 + 8, 2, true]);
w.registerNotification("NSWindowWillCloseNotification", {|notificationName,nsNotification|
	w.release;
});
w.invoke("makeKeyAndOrderFront:", [nil], true);
)


/*----------------------
Notification Examples
using Webview
________________________*/

(
var win, root, cocoaUI, cell, webview, levelIndicator;
win = SCNSObject("NSWindow", "initWithContentRect:styleMask:backing:defer:", [Rect(250, 250, 800, 600), 15, 2, 1]);

root = SCNSObject("NSView", "initWithFrame:", [Rect(0, 0, 800, 600)]);
root.invoke("setAutoresizingMask:", [1 + 2 + 8 + 16]);

webview = SCNSObject("WebView", "initWithFrame:frameName:groupName:", [Rect(10, 30, 800-20, 600-40), "mywebview", "mywebviewgroup"]);
webview.invoke("setAutoresizingMask:", [1 + 2 + 8 + 16]);

~webview = webview; // just to retrieve the source after

cell = SCNSObject("NSLevelIndicatorCell", "initWithLevelIndicatorStyle:", [1]);
levelIndicator = SCNSObject("NSLevelIndicator", "initWithFrame:", [Rect(10, 5, 800-20, 10)]);
levelIndicator.invoke("setCell:", [cell]);
levelIndicator.invoke("setMinValue:", [0]);
levelIndicator.invoke("setMaxValue:", [100]);
levelIndicator.invoke("setFloatValue:", [0]);
levelIndicator.invoke("setContinuous:", [true]);
cell.release;

cocoaUI.add(root);
cocoaUI.add(webview);
cocoaUI.add(levelIndicator);

win.invoke("setContentView:", [root]);
root.invoke("addSubview:", [webview]);
root.invoke("addSubview:", [levelIndicator]);

///// Notifications
// Window 
win.registerNotification("NSWindowWillCloseNotification", {
	|notificationName, nsNotificationObjectAsRawPointer|
	"closing window".postln;
	cocoaUI.do {|ui| ui.invoke("removeFromSuperviewWithoutNeedingDisplay")};
	win.release;
	root.release;
	webview.release;
	levelIndicator.release;
	~webview = nil;
});

win.registerNotification("NSWindowDidMoveNotification", {
	|notificationName, nsNotificationObjectAsRawPointer|
	notificationName.postln;
});

win.registerNotification("NSWindowDidMiniaturizeNotification", {
	|notificationName, nsNotificationObjectAsRawPointer|
	notificationName.postln;
});
// Webview Notifications
webview.registerNotification("WebProgressEstimateChangedNotification", {
	|notificationName, nsNotificationObjectAsRawPointer|
	var value;
	value = webview.invoke("estimatedProgress");
	levelIndicator.invoke("setFloatValue:", [value*100]);
	("loading progress: "+ (value*100) + "%").postln;
});

webview.registerNotification("WebProgressFinishedNotification", {
	|notificationName, nsNotificationObjectAsRawPointer|
	var t0, t1;
	levelIndicator.invoke("setFloatValue:", [0]);
	t0 = webview.invoke("mainFrame");
	t1 = t0.invoke("dataSource"); t0.release;
	t0 = t1.invoke("initialRequest"); t1.release;
	t1 = t0.invoke("URL"); t0.release;
	t0 = t1.invoke("absoluteString"); t1.release;
	(t0 ++ " finished Loading").postln;
	win.invoke("setTitle:", [t0]);
});
///// Show Window
win.invoke("makeKeyAndOrderFront:", [win], true);

///// URL Loading
{
	var url;
	url = "http://swiki.hfbk-hamburg.de:8888/MusicTechnology/6";
	webview.invoke("setMainFrameURL:", [url]);
	SCNSObject.dumpPool;
}.defer(0.2);
)

/*----------------------
NSData conversion
using Webview html source
Do not close the window before you exec this code or reload previous example !
________________________*/
(
/// interpret it AFTER previous example for getting source html file
var mainframe, datasource, nsdata;
mainframe = ~webview.invoke("mainFrame");
datasource = mainframe.invoke("dataSource"); mainframe.release;
nsdata = datasource.invoke("data"); datasource.release;
nsdata.isSubclassOf("NSData").postln; // 
"---- HTML Source ----".postln;
nsdata.asArray(\string).postln;
"---- End of HTML Source ----".postln;
nsdata.release;
)



/*----------------------
special Delegates actions with return values
using NSURLConnection as an example
________________________*/

/*
(
var url;

// first URL Request
url = SCNSObject("NSURL", "initWithString:", ["http://www.audiosynth.com"]);
~urlRequest = SCNSObject("NSURLRequest", "requestWithURL:cachePolicy:timeoutInterval:", [url, 0, 60]); url.release;

// redirection to set after delegate call
url = SCNSObject("NSURL", "initWithString:", ["http://www.apple.com"]);
~redirection = SCNSObject("NSURLRequest", "requestWithURL:cachePolicy:timeoutInterval:", [url, 0, 60]); url.release;

// we need here to set a void object to set its delegate before it is allocated really
// because urlConnection does not have a setDelegate: method
~urlConnection = SCNSObject.newClear;
~urlConnection.setDelegate; // create and attach a special delegate
~urlConnection.nsDelegate.addMethod("connectionDidFinishLoading:", nil, "@", {
|method, args| [method, args].postln;
});

//// Custom Delegate Method with return values allowed (automatic conversion for most)
//// Here we have to provide the (name, return type of the delegate method, and the type encoding for the arguments)
//// see http://developer.apple.com/documentation/Cocoa/Conceptual/ObjectiveC/Articles/chapter_13_section_9.html#//apple_ref/doc/uid/TP30001163-CH9-TPXREF165 for explanations
~urlConnection.nsDelegate.addMethod("connection:didReceiveResponse:", nil, "@@", {
	|method, args| [method, args].postln;
});

~urlConnection.nsDelegate.addMethod("connection:willSendRequest:redirectResponse:", "@", "@@@", {
	|method, arguments|
	[method, arguments].postln;
	url = ~redirection.invoke("URL");
	("redirecting to "++url.invoke("absoluteString")).postln; url.release;
	^~redirection; // redirect !
});

// we can init the object now
~urlConnection.init("NSURLConnection", "initWithRequest:delegate:", [~urlRequest, ~urlConnection.nsDelegate]); // now we can alloc the object and attach its delegate
)

(
~urlConnection.release;
~urlRequest.release;
~redirection.release;
)
*/

SCNSObject.dumpPool;
SCNSObject.freePool;



