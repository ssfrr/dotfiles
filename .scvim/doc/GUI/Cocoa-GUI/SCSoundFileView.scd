SCSoundFileView			a sound file editor / viewer

Inherits from: Object : SCView : SCScope

A sound file viewer with numerous options. 

See also: SoundFile, SCScope, SoundFileViewProgressWindow

Creation / Class Methods

	*new (parent, bounds)
	
		parent - The parent view.
		bounds - An instance of Rect, or a Point indicating width@height.

		(
		w = SCWindow.new("soundfile test", Rect(200, 200, 850, 400));
		a = SCSoundFileView.new(w, Rect(20,20, 700, 60));
		f = SoundFile.new;
		f.openRead("sounds/a11wlk01.wav");
		a.soundfile = f;
		a.read(0, f.numFrames);
		w.front;
		)

Accessing Instance and Class Variables

	soundfile
	soundfile_ (snd)
	.
		snd - An Instance of SoundFile.
						
	startFrame
		
		Returns the start frame as an Integer.
		
	numFrames
		
		Returns the number of frames in the soundfile.
								
	viewFrames
		
		Returns how many frames int the view.
		
	readProgress
		
		returns the read progress	
		
	scrollPos
	
		returns the scroll position	
			
	metaAction_(arg1)
	metaAction
		
		arg1 - An instance of Function to be evaluated on ctrl-click.
		
Reading A Sound File into the View

	read (startframe, frames, block, closeFile)
	
		Reads a section of  soundfile and displays it in the view. For large files, you may want to use readWithTask instead.
		startframe - An integer smaller than numFrames.
		frames - An integer smaller than numFrames-startFrame.
		block - An integer. The block size. Must be 2**n. Default value is 64. The visual resolution of the waveform.
		closeFile - If true, closes the SoundFile after reading. Default value is true.
		
	readFile (asoundfile, startframe, frames, block, closefile)
	
		Reads a section of any open instance of SoundFile, and displays it in the view. For large files, you may want to use the method readWithTask instead.
		asoundfile - Any instance of SoundFile. the file must be open.
		startframe - An integer smaller than numFrames.
		frames - An integer smaller than numFrames-startFrame.
		block - An integer. The block size. Must be 2**n. Default value is 64. The visual resolution of the waveform.
		closeFile - If true, closes the SoundFile after reading. Default value is true.

	readWithTask (startframe, frames, block, doneAction, showProgress)
	
		Reads a section of this.soundfile into the view, looping thrugh the frames and updating readProgress. If showProgress is true,  a SoundFileViewProgressWindow opens to show the read progress.
		startframe - An integer smaller than numFrames.
		frames - An integer smaller than numFrames-startFrame.
		block - An integer. The block size. Must be 2**n. Default value is 64. The visual resolution of the waveform.
		doneAction - An optional functiont o be evaluated on completion.
		showProgress - An instance of Boolean. Whether to open a progress window. Default value is true.
		
	readFileWithTask (soundfile, startframe, frames, block, doneAction, showProgress)
	
		Reads a section of an open instance of SoundFile into the view, looping thrugh the frames and updating readProgress. If showProgress is true,  a SoundFileViewProgressWindow opens to show the read progress.
		soundfile - Any instance of SoundFile. the file must be open.
		startframe - An integer smaller than numFrames.
		frames - An integer smaller than numFrames-startFrame.
		block - An integer. The block size. Must be 2**n. Default value is 64. The visual resolution of the waveform.
		doneAction - An optional functiont o be evaluated on completion.
		showProgress - An instance of Boolean. Whether to open a progress window. Default value is true.		

Navigating the Sound File

	zoom (factor)
	
		Zoom by factor relative to current zoom.
		factor - An instance of Float.

	zoomToFrac (frac)
	
		Zoom to a specific scale, frac.
		frac - An instance of Float.
		
	zoomAllOut
	
		Fill the window with the current selection.
		
	zoomSelection (index)
	
		Zoom to selections.at(index).
		index - An integer between 0 an 63.

	scrollTo (position)
	
		position - An integer.

	scroll (amount)
	
		amount - An integer.

	scrollToStart
	scrollToEnd

Selecting Ranges of Sound

	selections
	
		Returns an array of 64 arrays of start frames and sizes: [ [ start0, size0 ] , [ start1, size1 ], ... ].
		This is where the selections are stored.

	selection (index)
	setSelection (index, selection)
	
		Gets/sets selections.at(index).
		index - An integer between 0 an 63.
		selection - An instance of Array, [ [ start, size ] ], where start and size are integers.
		
	currentSelection
	currentSelection_ (index)
	
		Sets / gets the current selection.
		index - An integer between 0 an 63.

	selectionStart (index)
	setSelectionStart (index, frame)

		Gets/sets the start frame of selections.at(index).
		index - An integer between 0 an 63.
		frame - An integer smaller than numFrames .

	selectionSize (index)
	setSelectionSize (index, frame)
	
		Gets/sets the size of selections.at(index).
		index - An integer between 0 an 63.
		frame - An integer. The number of frames in the selection .
		
	selectionStartTime (index)
	
		Returns the start time of at selections.at(index).
		index - An integer between 0 an 63.
		
	selectionDuration (index)
	
		Returns the duration of at selections.at(index).
		index - An integer between 0 an 63.
		
	selectAll (index)
	
		Set selections.at(index) to the whole file .
		index - An integer between 0 an 63.

	selectNone (index)
	
		Set the size of the selection,  selections.at(index), to 0.
		index - An integer between 0 an 63.

	setSelectionColor (index, color)
	
		Sets the color of selections.at(index).
		index - An integer between 0 an 63.
		color - An instance of Color.

	setEditableSelectionStart (index, bool)
	setEditableSelectionSize (index, bool)
	
		Use this to protect a selection from being edited.
		index - An integer between 0 an 63.
		bool - An instance of Boolean.

	readSelection (block, closeFile)
	
		read this.selection
		block - An integer. The block size. Must be 2**n. Default value is 64. The visual resolution of the waveform.
		closeFile - If true, closes the SoundFile after reading. Default value is true.

	readSelectionWithTask

		read this.selection using the progress window.

Display Options

	gridOn
	gridOn_ (boolean)
	
		boolean - An instance of Boolean.
		
	gridResolution
	gridResolution_ (resolution)
	
		Get/set he resolution of the grid.
		resolution - An instance of Float.
		
	gridOffset_ (offset)
	
		set the grid offset.
		offset - an integer.
		
	gridColor_(color)
	gridColor
	
		color - An instance of Color.
		
	drawsWaveForm
	drawsWaveForm_ (bool)
	
		Whether the wave is drawn or not.
		bool - An instance of Boolean.
		
	timeCursorOn
	timeCursorOn_ (bool)
	
		Show/hide the time cursor.
		bool- An instance of Boolean.

	timeCursorPosition
	timeCursorPosition_ (frame)
	
		Get/set the time cursor frame position.
		frame - An integer.
		
	timeCursorColor
	timeCursorColor_ (color)

		color - An instance of Color

Subclassing and Internal Methods
	The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed.

	doMetaAction

	makeProgressWindow
	
		Creates a SoundFileViewProgressWindow.

	init (argParent, argBounds)
	
	dataFrames_(arg1)
	dataFrames
		
		Explanation including the type of dataFrames and a link to its help file.
		Default value is nil.
	dataNumSamples
	data
	data_ (arr)
	
		Get/set the view data.
		arr - An instance of Array.
		
	setData (arr, block, startframe, channels, samplerate)
	
		Set the view data.
		arr - An instance of Array.
		block - An integer. The block size. Must be 2**n. Default value is 64. The visual resolution of the waveform.
		startframe - An integer.
		channels - An integer.
		samplerate - An integer. Default value is 44100.

	updateScroll
	updateData
	
	elasticMode
	elasticMode_ (mode)
	
	mouseEndTrack (x, y)

	Not Implemented yet:
	
	*cacheFolder
	*cacheFolder_ (path)
	*cacheCapacity
	*cacheCapacity_ (megaBytes)
	*cacheActive
	*cacheActive_ (bool)
	
Examples

(
w = SCWindow.new("soundfile test", Rect(200, 200, 800, 400));
a = SCSoundFileView.new(w, Rect(20,20, 700, 60));

f = SoundFile.new;
f.openRead("sounds/a11wlk01.wav");
f.inspect;

a.soundfile = f;
a.read(0, f.numFrames);
a.elasticMode = true;

a.timeCursorOn = true;
a.timeCursorColor = Color.red;
a.timeCursorPosition = 2050;
a.drawsWaveForm = true;
a.gridOn = true;
a.gridResolution = 0.2;

w.front;
)

// step by step examples:

( // make a simple SCSoundFileView
w = SCWindow.new("soundfile test", Rect(10, 700, 750, 100));
w.front;
a = SCSoundFileView.new(w, Rect(20,20, 700, 60));

f = SoundFile.new;
f.openRead("sounds/a11wlk01.wav");
// f.inspect;

a.soundfile = f;			// set soundfile
a.read(0, f.numFrames);		// read in the entire file.
a.refresh;				// refresh to display the file.
)

		// reading file
a.read(0, f.numFrames / 2).refresh;	// read first half
a.read.refresh;					// read entire file by default
a.read(f.numFrames / 2).refresh; 	// read second half
a.read(0, -1).refresh;				// -1 also reads entire file, like buffer.

	// block sets visual resolution of waveform, default is 64.
	// i.e. the view keeps peak values for each block of e.g. 64 samples
	// rather than the entire waveform.
a.read(0, -1, block: 32).refresh;
a.read(0, -1, block: 24).refresh;
a.read(0, -1, block: 16).refresh;

	// for longer files, you can use:
a.readWithTask;

	// zoom is relative
a.zoom(0.2).refresh;
a.zoom(2).refresh;
a.zoom(2).refresh;
a.zoomToFrac(0.5); // zoom to half file size
a.zoomAllOut;
	
a.gridOn = true;			// time grid, 1 second by default,
a.gridResolution = 0.2;		// or set resolution in seconds
a.gridColor = Color.cyan;	// color is changeable.
a.gridOffset_(0.1);		// not sure if this is working?

a.timeCursorOn = true;			// a settable cursor
a.timeCursorPosition = 2050;	// position is in frames.
a.timeCursorColor = Color.white;	

		// toggle drawing on/off
a.drawsWaveForm = false;
a.drawsWaveForm = true;

	// these methods should return view properties:
a.gridOn
a.gridResolution
a.gridColor
a.timeCursorOn
a.timeCursorPosition
a.timeCursorColor

		// Selections: multiple selections are supported.
		// e.g. use selection 0:
a.setSelectionColor(0, Color.red);	// set...( index, value )
a.selectionStart(0);				// at index
a.setSelectionStart(0, 12345);		
a.setSelectionSize(0, 12345);

a.setSelectionStart(0, 1234);
a.selectionStart(0);		//

		// now selection 1
a.setSelectionColor(1, Color.white);
a.setSelectionStart(1, 1234).setSelectionSize(1, 1234 * 2);
a.selectionStart(1);		//
a.setSelectionStart(0, 12345);		//

		// the current selection gets changed when click/dragging in view.
a.currentSelection;	// index of current selection;
a.currentSelection_(1);	// switch current selection - try click/drag white now.
a.currentSelection;

a.selections.size;		// 64 selections
a.selections[0];
a.selections[1];
a.selections;

	// setSelection (index, selection);
a.setSelection(0, [234, 2345]);
a.selection(1);	// returns [start, size].


a.elasticMode = true;	// not sure if this is working yet?

(		// mouseUpAction
a.mouseUpAction = {
	("mouseUp, current selection is now:"
		+ a.selections[a.currentSelection]).postln;
};
)
	// lock selection 0:
a.currentSelection_(0);
a.setEditableSelectionStart(0, false);
a.setEditableSelectionSize(0, false);


	// unlock selection 0:
a.setEditableSelectionStart(0, true);
a.setEditableSelectionSize(0, true);

a.selectionStartTime(0);
a.selectionDuration(0);


a.setSelectionStart(0, 12345);
a.setSelectionSize(0, 12345);
a.readSelection.refresh;
a.readSelection(16).refresh;	// in higher resolution
a.read.refresh;				// go back to entire file.


a.dataNumSamples;	// visual data have this many points
a.data.plot;		//
a.setData(a.data.reverse);


a.zoom(0.25);		// scrolling is normalized
a.scrollTo(0.5);	//
a.scrollTo(0.6);	//
a.scroll(12);		// scroll is in viewFrames.

a.zoom(4);	

w.close;


