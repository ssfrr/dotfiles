SCModalWindow			an application modal version of SCWindow	

Inherits from: Object : SCWindow : SCAbstractModalWindow

SCModalWindow is an application modal version of SCWindow. This means that it blocks all other user input until it is dismissed. It is thus useful for alerts, preference panels and other situations which should limit user input.

See also: SCWindow, SCModalSheet

Dismissing App Modal Windows

SCModalWindows have non-functional OSX close buttons. It is therefore very important that you add an SCButton or some other GUI widget to allow the user to close the window. As an 'escape hatch' pressing the esc key will kill any application modal window.

Blocking and Multiple App Modal Windows

There can only be one active SCModalWindow at any given time. If you attempt to create more than one they will be cued and launched in turn as each is dismissed.

N.B. If you launch multiple app modal windows which will alter the same data, you may need to take special care. You can use the *current class method to check if an app modal window is currently running, and add a Function to its onClose in order to check if the additional window is still needed once the first one has closed. See below for an example of how to do this.

Creation / Class Methods

	*new (name, bounds, resizable, border, server, scroll)
	
		Creates a new SCModalWindow instance. You do not need to call front on it to make it visible.
		name - The name that will be displayed in the title bar. An instance of String or Symbol. The default is 'panel'.
		bounds - A Rect or Point specifying the size of the window. The size does not include the title bar. N.B. App Modal windows are centred on the screen when created, so if you wish to move it for some reason you will need to call bounds_ on the window after creation.
		resizable - A Boolean indicating whether this window can be resized by the user. The default is false.
		border - A Boolean indicating whether this window has a border. Borderless windows have no title bar. The default is true.
		server - This is a dummy argument which is here to provide compatibility with SwingOSC and has no effect. See GUI for more details.
		scroll - A Boolean indicating whether this window will add scrollers if its contents exceed its bounds. If this is set to true resize settings will be ignored for enclosed views. See SCScrollTopView. The default is false.


Accessing Instance and Class Variables
	
	*current
		
		This returns the currently running app modal window, if it exists, or nil otherwise.


Examples

// simple example
(
var person, win;
win = SCModalWindow("What kind of person?", 230@60);
win.view.decorator = FlowLayout(win.view.bounds);
EZPopUpMenu(win, 210@20, "Are you:", ['Dog Person'->{person = "Dog Person"}, 'Cat Person'->{person = "Cat Person"}], initAction: true);
win.view.decorator.nextLine.nextLine;
SCButton(win, Rect(20,20,210,20))
	.states_([
		["OK", Color.black, Color.white]
	])
	.onClose_({("You're a" + person).postln})
	.action_({ win.close });
)

// multiple windows with state check
// checks against data1 and data2 to see if windows are still needed
(
var window1, window2, window3;
var func2, func3;
var data1 = false, data2 = false;

// 1
window1 = SCModalWindow.new("1");
SCButton(window1, Rect(20,20,340,30))
	.states_([
		["OK", Color.black, Color.red]
	])
	.action_({
		data1 = true; // we will still need 2
		window1.close;
	});

// 2
func2 = {
var curr;
curr = SCModalWindow.current;
if(curr.isNil, {
	if(data1, {
		window2 = SCModalWindow.new("2");
		SCButton(window2, Rect(20,20,340,30))
			.states_([
				["OK", Color.black, Color.red]
			])
			.action_({
				data2 = false; // we won't still need 3
				window2.close;
			}).onClose_({2.postln;});
	});
}, {curr.onClose = curr.onClose.addFunc(func2)});
};
func2.value;

// 3
func3 = {
var curr;
curr = SCModalWindow.current;
if(curr.isNil, {
	if(data2, {
		window3 = SCModalWindow.new("3");
		SCButton(window3, Rect(20,20,340,30))
			.states_([
				["OK", Color.black, Color.red]
			])
			.action_({ window3.close; })
			.onClose_({3.postln;});
	});
}, {curr.onClose = curr.onClose.addFunc(func3)});
};
func3.value;
)



