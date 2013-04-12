CocoaDialog			file dialogs that utilize OS X Cocoa services	

Inherits from: Object

OSX only. See GUI for cross-platform information.

See also: GUI, Cocoa

Class Methods

	*getPaths (okFunc, cancelFunc, allowsMultiple)
	
		Displays an Open File Dialog. If ok is pressed then okFunc is evaluated withIf cancel is pressed then cancelFunc is evaluated.
		okFunc - A Function to be evaluated when OK is pressed. The selected paths are passed as an Array of Strings as the first argument. 
		cancelFunc - A Function to be evaluated if Cancel is pressed.
		allowsMultiple - A Boolean indicating whether the dialog allows the user to select multiple files. The default is true.
		
		(
		CocoaDialog.getPaths({ arg paths;
			paths.do({ arg p;
				p.postln;
			})
		},{
			"cancelled".postln;
		});
		)


	*savePanel (okFunc, cancelFunc)
	
		Displays a Save File Dialog.
		okFunc - A Function to be evaluated when OK is pressed. The selected path will be passed as a String as the first argument. 
		cancelFunc - A Function to be evaluated if Cancel is pressed.
		
		(
		CocoaDialog.savePanel({ arg path;
			path.postln;
		},{
			"cancelled".postln;
		});
		)



