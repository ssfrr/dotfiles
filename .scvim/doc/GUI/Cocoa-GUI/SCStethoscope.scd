SCStethoscope			a wrapper for a window with an SCScope an control interface	

Inherits from: Object

A window containing a configurable SCScope with an interface to navigate on buses.

See also: SCScope, Server, Bus

Some Important Issues Regarding SCStethoscope

the scope window can be controlled by the following keys:

J		one channel back
K		switch rate (audio vs. control)
L		one channel forward

O		jump to first hardware output channel and adjust numChannels to hardware
I		jump to first hardware input channel and adjust numChannels to hardware

space 	run, if not running anyway.
. (period)	stop.
M		toggle screen size

+ / -		zoom horizontally
* / _		zoom vertically
S		change style between parallel and overlay

shift S 	change style to lissajou (use only with fast computer and small buffer size)
shift A	allocate buffer size so it fills the screen (to next power of two) (this can be dangerous, might crash)

Creation

	*new (server, numChannels, index, bufsize, zoom, rate, view, bufnum)
	
		server - must be Server.internal.
		numChannels - An integer. Default value is 2..
		index - The offset index. An integer. Default is nil.
		bufsize - The size of the analysis buffer. Default value is 4096. .
		zoom - Horizontal maginification of the displayed wave. Default is 1.
		rate - \audio or \control. Default is Audio.
		view - The parent view of the scope. Default is nil. If nil, then it will open its own SCWindow.
		bufnum - The id number of the Buffer to analyze. Default value is nil. If nil, then a Buffer of size bufSize is allocated.
		
		Server.default = s = Server.internal
		s.boot
		{SinOsc.ar([330,440], 0, 0.4)}.play;
		SCStethoscope(s,2);

Creation by Message .scope

	aServer.scope(numChannels, index, bufsize, zoom, rate)
	
		Opens a scope window for the server, and stores it in the server instance var scopeWindow
		
		Server.default = s = Server.internal
		s.boot
		{SinOsc.ar([330,440], 0, 0.4)}.play;
		s.scope;
		
	aBus.scope(bufsize, zoom)
	
		Displays a bus in scope, using the Bus's numChannels, index, and rate settings.
		
		Server.default = s = Server.internal
		s.boot
		b=Bus.audio(s,2);
		a={SinOsc.ar([330,440], 0, 0.4)}.play(s,b) //you won't hear this if you only have two channels
		b.scope
		
		a.free;
		b.free;
		
	aFunction.scope(numChannels, outbus, fadeTime, bufsize, zoom)
	
		Plays a function and shows output in scope, returns synth object, like { }.play
		
		Server.default = s = Server.internal
		s.boot
		a={SinOsc.ar([330,440], 0, 0.4)}.scope;
		a.free;

	*ugenScopes
	
		Returns an array of the running ugen scopes.
		
		Server.default = s = Server.internal
		s.boot
		{[SinOsc.ar.scope,WhiteNoise.ar(0.5).scope]*0.1}.scope(2);
		SCStethoscope.ugenScopes; // returns the ugen scopes

Accessing Instance and Class Variables
	
	ugenScopes
		
		Returns an array of the running ugen scopes, just like the class method ugenSopes.
				
	numChannels
	numChannels_ (n)
	
		Get/set the number of Channels in a scope.
		n - an Integer.
				
	rate
	rate_ (argRate)
	
		Get/set the rate of a scope.
		argRate - \audio or \control.
		
	index
	index_ (val)
	
		Get/set the offest index in a scope.
		val - and Integer.

	size_ (val)
	
		Set the width and height tof the scope window.
		val - An integer (the iwndow is square).

	window
		
		Returns the parent SCWindow of the scope .
				
	bufsize
		
		The size of the buffer.
				
	server
		
		Returns the server of SCStethoscope
				
Controlling the Scope
	
	quit

		Closes the window, and cleans up synths and buffer.

	toggleSize
	
		Toggle between size 500 and 212.
		
	zoom_ (val)
	xZoom_ (val)
	
		Zoom the horizontal value by factor val.
		val - An instance of Float.
		
	yZoom_ (val)
	
		Zoom the vertical value by factor val.
		val - An instance of Float.

	style_ (val)
	.
		val - 1 = Separate channels, 2 = overlayed channels, 3= lissajou (use only with fast computer and small buffer size)
		
Subclassing and Internal Methods
	The following methods are usually not used directly or are called by a primitive. Programmers can still call or override these as needed.

	*tileBounds
	
		A utility used by Ugen : scope to tile scope windows.
		
	*defaultServer
	
		SCStethoscope's default server. Returns Server.internal


	*isValidServer (aServer)
	
		Tests if a server is a valid server. Returns a n instanc of Boolean;
		aServer - An instance of Server.
		
	keyDown (char)
	spec
	setProperties (numChannels, index, bufsize, zoom, rate)
	allocBuffer (argbufsize, argbufnum)
	xZoom
	yZoom
	updateColors
	switchRate
	toInputBus
	toOutputBus
	adjustBufferSize
	run
	free

Examples


(
Server.default = Server.internal;
s = Server.default;
s.boot;
)
(
{
	SinOsc.ar([225, 450, 900], 0, 0.2)
	+ LPF.ar(
		LFPulse.ar(226 * [1, 2, 5],[0,0.1,0.1],0.2, 0.2),
		MouseX.kr(20, 10000, 1)
		)
}.scope;
)

// server.scope only changes the properies explicitly given:

s.scope(numChannels:5);
s.scope(index:12);
s.scope(zoom:4);
s.scope(index:0);

s.scopeWindow.size = 600;
s.scopeWindow.size = 222;

// scoping buses:

a = Bus.audio(s, 4);
{ WhiteNoise.ar(0.2.dup(4)) }.play(s, a);

a.scope;

c = Bus.control(s, 3);
{ WhiteNoise.kr(1.dup(4) * MouseX.kr) }.play(s, c);

c.scope;

// note that scoping control rate buses shows block size interpolation (this is due to the
// fact that ScopeOut.kr doesn't work yet.)

external use: you can pass your own view in to add a stethoscope to it;

w = Window.new("my own scope", Rect(20, 20, 400, 500));
w.view.decorator = FlowLayout(w.view.bounds);
c = Stethoscope.new(s, view:w.view);
w.onClose = { c.free }; // don't forget this
w.front;




