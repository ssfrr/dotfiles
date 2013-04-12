Scoping Out Some Plots

Function has two other useful audio related methods. The first you've already seen some results of, Function-plot:

	{ PinkNoise.ar(0.2) + SinOsc.ar(440, 0, 0.2) + Saw.ar(660, 0.2) }.plot;
	
This makes a graph of the signal produced by the output of the Function. You can specify some arguments, such as the duration. The default is 0.01 seconds, but you can set it to anything you want.

	{ PinkNoise.ar(0.2) + SinOsc.ar(440, 0, 0.2) + Saw.ar(660, 0.2) }.plot(1);
	
This can be useful to check what's happening, and if you're getting the output you think you're getting.

The second method, Function-scope, shows an oscilloscope-like display of the Function's output. This only works with what is called the internal server, so you'll need to boot that before it will work. You can do this using the internal server window





or you can do it in code, like so:

	Server.internal.boot;
	
BTW, clicking on the '-> default' button on the localhost or internal server's window sets that server to be the default, and stores it in the variable 's'. Thereafter, that will be the server on which all audio is played, unless you specify another one. Since Function-scope only works with the internal server, however, it will always play on it.

So let's try to scope some audio:

	{ PinkNoise.ar(0.2) + SinOsc.ar(440, 0, 0.2) + Saw.ar(660, 0.2) }.scope;
	
This should open a window which looks something like this:





This also works for multiple channels:

	{ [SinOsc.ar(440, 0, 0.2), SinOsc.ar(442, 0, 0.2)] }.scope;
	
Scope also has a zoom argument. Higher values 'zoom out'.

	{ [SinOsc.ar(440, 0, 0.2), SinOsc.ar(442, 0, 0.2)] }.scope(zoom: 10);

Like Function-plot, Function-scope can be useful for testing purposes, and to see if you're actually getting out what you think you are.

Scoping on Demand

You can also scope the output of the internal server at any time, by calling 'scope' on it.

	{ [SinOsc.ar(440, 0, 0.2), SinOsc.ar(442, 0, 0.2)] }.play(Server.internal);
	Server.internal.scope; // you could also use 's' if the internal is the default

You can do the same thing by clicking on the internal server window and pressing the 's' key.

Local vs. Internal

If you're wondering what's the difference between the local and the internal servers, it's relatively straightforward: The internal server runs as a process within the client app; basically a program within a program. The main advantage of this is that it allows the two applications to share memory, which allows for things like realtime scoping of audio. The disadvantage is that the two are then interdependent, so if the client crashes, so does the server.

For more information see: 

Function Server Stethoscope

Suggested Exercise:

Experiment with scoping and plotting some of the Function examples from earlier sections, or some Functions of your own creation. Try experimenting with different duration or zoom values.

____________________

This document is part of the tutorial Getting Started With SuperCollider.

Click here to go on to the next section: Getting Help

Click here to return to the table of Contents: Getting Started With SC


