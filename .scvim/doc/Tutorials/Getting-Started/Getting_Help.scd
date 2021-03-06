Getting Help

This is probably a good point to stop and explore some methods of finding further information. You're already familiar with the clickable links that have been used so far in this tutorial. Here's an example:

	Help

Clicking on this link will open the main help window, which contains a number of links to other help files. At some point, it would be a good idea to familiarise yourself with some of these. The ones under the headings 'Essential Topics' and 'Language' are of particular import. Again don't worry if everything doesn't immediately make complete sense to you. Learning a computer language is sometimes a little like slowly zeroing in on something, rather than getting it immediately, and some information you can just file away for future reference.

Classes and Methods

By now we've learned enough OOP theory that we know that we have classes, which are like templates for objects, and instances, which are objects which have been created from those templates. We also have class and instance methods, which may take arguments. Class methods do things like create instances (as well as some convenience functions that don't require an actual instance), and instance methods control and manipulate instances. There are also instance variables, which are the data specific to each instance, and class variables, which are data in common between all instances.

Recall that anything in the code that begins with an uppercase letter is a class. Most classes have help files. If you select a class by double-clicking on it, and press Cmd - d (that's hold down the Cmd key and press the d key) the help file for that class will open if it exists. (If not you'll get the main help window.) Try it with this example below:

	SinOsc

You should have gotten a window with a brief description of the class and what it does, a list of some methods, and a description of their arguments. (Remember that 'mul' and 'add' are usually not explained.)

Beneath that are some examples of the class in action. These can be very useful for making it clear exactly what the class does, and can serve as starting points for your own work. It's a good idea to cut and paste these to a new window, and then play around with modifying them. (Remember that SC won't stop you from saving any modified files, including this tutorial!) This is a great way to learn.

You may be wondering how to access the helpfiles for Function and Array, since they often appear in code as {...} and [...]. They are also named classes, so by typing in the following, you can also select and Cmd-? on them.

	Function
	Array

Some methods also have helpfiles, and there are a number of ones on general topics. Most of these are listed in the main help window.

Syntax Shortcuts

Remember the example of Mix(...) vs. Mix.new(...)? SC has a number of such shorthand forms or alternate syntaxes. A common example is the distinction between Functional and receiver notation. This means that the notation someObject.someMethod(anArg) is equivalent to someMethod(someObject, anArg). Here's a concrete example. Both of these do exactly the same thing:

	{ SinOsc.ar(440, 0, 0.2) }.play;
	
	play({ SinOsc.ar(440, 0, 0.2) });
	
You will find numerous other examples of syntax shortcuts throughout SC's documentation. If you see something you don't recognize, a good place to check is Syntax-Shortcuts, which gives examples of most of these.

Snooping, etc.

SC has numerous other ways of tracking down information on classes, methods, etc. Most of these won't be too helpful for you at this point, but are good to know about for future use. Information on these can be found in the files More-On-Getting-Help and Internal-Snooping.

For more information see: 

More-On-Getting-Help Internal-Snooping Syntax-Shortcuts

Suggested Exercise:

Go back over the examples in the previous tutorials, and try opening up the helpfiles for the various classes used. Try out the examples, and if you like open up the help files for any unfamiliar classes used in those examples. Get used to Cmd-d, you'll be using it a lot. :-)

____________________

This document is part of the tutorial Getting Started With SuperCollider.

Click here to go on to the next section: SynthDefs and Synths

Click here to return to the table of Contents: Getting Started With SC


