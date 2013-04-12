SCFreqScope			frequency analysis view	

Inherits from: Object : SCView : SCScope

SCFreqScope shows the frequency spectrum of a specified audio bus.

See also: SCScope, SCFreqScopeWindow

A Very Important Issue Regarding SCFreqScope:

The scope will remain active after a command-period. To turn it off you must use the 'active' method.
Very important: You must run kill() when the parent window is closed to avoid problems.
It also frees the buffers that the scope allocated and stops the FFT analysis synth. So:

		(
		w = SCWindow("My Analyzer", Rect(0, 0, 511, 300));
		f = SCFreqScope(w, w.view.bounds);
		w.onClose_({ f.kill }); // YOU MUST HAVE THIS
		w.front;
		)

Creation / Class Methods

	*new (parent, bounds)
	
		parent - The parent view.
		bounds - An instance of Rect, or a Point indicating width@height.
		
		// Start internal server
		s = Server.internal.boot;
		
		// Create analyzer in a window
		(
		w = SCWindow("My Analyzer", Rect(0, 0, 511, 300)); // width should be 511
		f = SCFreqScope(w, w.view.bounds);
		f.active_(true); 	// turn it on the first time;
		
		w.onClose_({ f.kill }); // you must have this
		w.front;
		{ SinOsc.ar([500, 1000], 0, 0.25).mean.dup }.play(s); // start two sine waves
		
		)

	*response (parent, bounds, bus1, bus2, freqMode)
	
		Create a scope in a special frequency-response mode. This uses FFT-based spectral division to estimate the frequency response of some effect, on the assumption that the signal to bus1 is transformed to the signal at bus2 by some linear time-invariant process.
		parent - The parent view.
		bounds - An instance of Rect, or a Point indicating width@height.
		bus1 - The bus on which the "pre" signal is found.
		bus2 - The bus on which the "post" signal is found.
		freqMode - linear (0) or log(1) frequency mode. Defaults to 1.

		
		Server.default = s = Stethoscope.defaultServer.boot;
			
		// basic usage. try these. Each one will open a new window
		// move the mouse left and right to test response in different ranges	
		LPF.scopeResponse
		HPF.scopeResponse
		MoogFF.scopeResponse
		BBandPass.scopeResponse
		BLowShelf.scopeResponse // by default BLowShelf doesn't mangle much
		Resonz.scopeResponse
		BRF.scopeResponse
		Integrator.scopeResponse
		Median.scopeResponse // nonlinear, and therefore interesting
		
		
		// customize the parameters for more informative scoping
		{|in| MoogFF.ar(in, freq: MouseX.kr(10, 10000, 1),
		gain:MouseY.kr(4,0))}.scopeResponse
		
		
Instance Methods

	kill
		Very important. This must be run when the parent window is closed to avoid problems. It also frees the buffers that the scope allocated and stops the FFT analysis synth.
	
	active
	active_ (bool)
	
		Turn the scope on or off.
		bool - An instance of Boolean.
		
	freqMode
	freqMode_ (mode)
	
		mode - 0= linear, 1= logarithmic.
		
	inBus
	inBus_ (num)
	
		The bus to listen on.
		num - an audio Bus number.
				
	dbRange
	dbRange_ (db)
	
		Get/set the amplitude range.
		db - A Number.
				
	special (defname, extraArgs)
	
		Put the scope into a special mode using a user-specified SynthDef. Note that only very particular SynthDefs should be used, namely ones that are derived from the \freqScope0 or \freqScope1 SynthDefs. Most users will not need to use this method directly, but it can be used to provide a customised analysis shown in the scope.
		defname - Name of the SynthDef you wish to use.
		extraArgs - extra arguments that you may wish to pass to the synth.
				
Subclassing and Internal Methods
	The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed.
	
	*viewClass Returns SCScope. See also Subclassing and Internal Methods in SCView

	*initClass Sets the classVar , server = Server.internal.
		
	server - A classVar. must be Server.internal
	start
	eventSeq (delta, funcs)
	cmdPeriod
	initSCFreqScope
	sendSynthDefs
	allocBuffers
	freeBuffers
	node
	scopebuf
	fftbuf
	bufSize
	
Examples

// Start internal server
s = Server.internal.boot;


// Create analyzer in a window
(
w = SCWindow("My Analyzer", Rect(0, 0, 511, 300)); // width should be 511
f = SCFreqScope(w, w.view.bounds);
f.active_(true); 	// turn it on the first time;

w.onClose_({ f.kill }); // you must have this
w.front;
{ SinOsc.ar([500, 1000], 0, 0.25).mean.dup }.play(s); // start two sine waves

)


f.freqMode_(1);		// change to log scale so we can see them
f.inBus_(1);			// look at bus 1
f.dbRange_(200);		// expand amplitude range
f.active_(false);		// turn scope off (watch CPU)
f.active_(true);		// turn it back on				


// Now press command-period. The scope is still running.


{ Mix.ar(SinOsc.ar([500, 1200, 3000, 9000,12000], 0, [0.2,0.1,0.05,0.03,0.01])) }.play(s); // restart some sines


// Close window and scope is killed.









