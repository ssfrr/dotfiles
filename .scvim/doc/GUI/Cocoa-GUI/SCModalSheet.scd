SCModalSheet			a window modal version of SCWindow		

Inherits from: Object : SCWindow : SCAbstractModalWindow

SCModalSheet is an window modal version of SCWindow. A sheet is an accessory window which is attached to a parent window. SCModalSheet blocks all other user input to its parent window until it is dismissed. It is thus useful for alerts, preference panels and other situations which should limit user input.

See also: SCWindow, SCModalWindow

Dismissing Modal Sheets

SCModalSheets have no close button. It is therefore very important that you add an SCButton or some other GUI widget to allow the user to dismiss the sheet. As an 'escape hatch' pressing the esc key will kill a sheet if it has focus (i.e. is foremost and selected).

Blocking and Multiple Sheets on the Same Window

Each window can have only sheet attached to it at any given time. (You can however have sheets attached to sheets.) If you attempt to create more than one at the same time all but the first will fail. If needed, you can check parent window's currentSheet method to see if a sheet is running. This will return the current sheet if it exists, and nil otherwise. If one is running, you can add a Function to its onClose in order to relaunch the additional sheet(s) if desired, or do any necessary testing.

Creation / Class Methods

	*new (window, bounds, resizable, border, server, scroll)
	
		Creates a new SCModalSheet instance. You do not need to call front on it to make it visible.
		window - An instance of SCWindow or one of its subclasses. This is the parent window to which the sheet will be attached.
		bounds - A Rect or Point specifying the size of the window.
		resizable - A Boolean indicating whether this window can be resized by the user. The default is false.
		border - A Boolean indicating whether this window has a border. Borderless windows have no title bar. The default is true.
		server - This is a dummy argument which is here to provide compatibility with SwingOSC and has no effect. See GUI for more details.
		scroll - A Boolean indicating whether this window will add scrollers if its contents exceed its bounds. If this is set to true resize settings will be ignored for enclosed views. See SCScrollTopView. The default is false.

Examples

///// simple example
w = SCWindow.new("Parent").front; // make a window

(
// now attach a sheet
x = SCModalSheet.new(w, 380@70);
SCButton(x, Rect(20,20,340,30))
	.states_([
		["Dismiss me", Color.black, Color.red]
	])
	.onClose_({"Dismissed!".postln})
	.action_({ x.close });
)




