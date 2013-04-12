SCMovieView			a wrapper for a Cocoa Quicktime view	

Inherits from: Object : SCView

SCMovieView can play movies such as .mov and mpg,
and image files like jpg, png, tiff and others.

See also: SCImage

Creation / Class Methods

	*new (parent, bounds)
	
		parent - The parent view.
		bounds - An instance of Rect, or a Point indicating width@height.

Accessing Instance and Class Variables
	
	path
	path_ (moviePath)
	
		moviePath - The path to the movie.
				
Movie Control
	
	start
	stop
	stepForward
	stepBack
	gotoEnd
	gotoBeginning
	
	frame_ (frameIdx)
	
		Go to frame.
		frameIdx - An integer.
		
	playSelectionOnly_ (bool)
	
		bool - An instance of Boolean.
		
	skipFrames (numFrames)
	
		numFrames - An Integer.
		
	muted
	muted_ (bool)
	
		bool - An instance of Boolean.
		
	loopMode
	loopMode_ (mode)
	
		mode - An Integer . Loop modes:
		0 Playback runs forward and backward between both endpoints.
		1 Restarts playback at beginning when end is reached.
		2 Playback stops when end is reached.		

	rate
	rate_ (ratein)
	
		ratein - An instance of Float. 1.0 is the normal rate.
		
Movie Editing

	copy
	clear
	cut
	paste

	editable
	editable_ (bool)
	
		bool - An instance of Boolean.

	currentTime
	currentTime_ (time)
	
		Get/set the current time.
		time - Default value is nil. .

Adjusting Appearance

	showControllerAndAdjustSize (show, adjust)
	
		show - An instance of Boolean. Default is true.
		adjust - An instance of Boolean. Default is true.

	resizeWithMagnification (size)
	
		Resizes the whole view, adjusts its contents.
		size - An instance of Float.

	fixedAspectRatio_ (bool)
	
		bool - An instance of Boolean.

Examples

(
w = Window("mov").front;
b = Button(w, Rect(0, 0, 150, 20))
	.states_([["pick a file"]])
	.action_({ File.openDialog("", { |path| m.path_(path) }) });
m = MovieView(w, Rect(0,20,360, 260));
)
	// random-pick a tiff from the Help folder
m.path_("Help/*/*/*.tiff".pathMatch.choose);

	// or point it to a movie (you may have that one too):
m.path_("/Library/Application\ Support/iDVD/Tutorial/Movies/Our\ First\ Snowman.mov");


m.start;			// playback
m.muted_(false);	// thank god
m.stop;		
	
	//rate
m.rate_(1);	
	// backwards
m.gotoEnd.rate_(-1).start;

	// select a range on the controller and play it
m.rate_(1).playSelectionOnly_(true).start;

	// loopModes:
m.loopMode_(1);	// only one direction
m.loopMode_(0).start;	// back and forth



m.stop;
m.gotoBeginning;
	
	// single steps
m.stepForward;

10.do { m.stepForward; };
m.stepBack;

// select with shift-drag, copy paste between movieviews or quicktime player
m.editable_(true);


m.showControllerAndAdjustSize(true, true);
	// resize compared to image size:
m.resizeWithMagnification(0.25);	

	//goto time (in seconds)
m.currentTime_(1);

		// not there yet, but would be nice to have:
		// startFrame, length
m.setSelection_(20, 15);

		
m.frame_(frame);	// jump to frame
m.frame.postln;	// poll current frame pos



