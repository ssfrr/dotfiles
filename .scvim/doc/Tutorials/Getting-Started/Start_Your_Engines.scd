Start Your Engines

Before we can make any sound, we need to start or 'boot' a server application. The easiest way to do this is to use one of the server windows which is automatically created by the client app. These can be found in the bottom left-hand corner of your screen. Look for the one that says 'localhost server'. It should look like this:





'localhost' just means on your local computer, as opposed to running on a different computer connected by a network. To start the server click on the 'Boot' button, or click on the window and press the space bar. After a second or two it should look something like this:





Notice that the white status box has changed from 'inactive' to 'running', and that the 'Boot' button has changed to 'Quit'. This indicates that the server is running. As well the window provides you with some information about CPU usage, and some other things which probably aren't too clear yet. More about them soon.

Also take a look at the post window, where SC has given you some info, and let you know that it booted okay:
	
	booting 57110
	SC_AudioDriver: numSamples=512, sampleRate=44100.000000
	start   UseSeparateIO?: 0
	PublishPortToRendezvous 0 57110
	SuperCollider 3 server ready..
	notification is on

If for some reason it had failed to boot, there would be some information indicating that.

By default you can refer to the localhost server in your code by using the letter s. You can thus send messages to start and stop it like so:

	s.quit;
	s.boot;
	
Try this out and then leave the server running. Many examples in the documentation have s.boot at the beginning, but in general you should make sure the server is running before using any examples that generate audio, or otherwise access the server. In general the examples in this tutorial assume that the server is running.

You can also refer to the localhost server with the text 'Server.local', for example:

	Server.local.boot;

For more information see: 

Server
____________________

This document is part of the tutorial Getting Started With SuperCollider.

Click here to go on to the next section: Functions and Other Functionality

Click here to return to the table of Contents: Getting Started With SC


