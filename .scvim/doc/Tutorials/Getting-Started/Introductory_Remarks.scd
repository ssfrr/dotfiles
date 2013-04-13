Introductory Remarks

The following text is intended to serve as an introduction to SuperCollider 3, an object-oriented language for sound synthesis and digital signal processing (DSP). This tutorial does not assume a background in computer science, but does assume basic familiarity with your computer and its OS, as well as a basic knowledge of acoustics and digital audio. (I'm assuming here that words like frequency and sample will not cause any confusion.)

The tutorial is written from a Mac OSX perspective, but much of it should apply to linux and windows as well. The parts which specifically differ have mostly to do with GUI aspects (Graphical User Interface).

I should acknowledge that this tutorial is 'by' me in only a limited sense. In writing it I have drawn freely upon the general documentation, which was written by a number of people. This document is not intended to replace those (often more detailed) sources, and refers the reader to them constantly for further information.

A full list of those who have contributed to SuperCollider and its documentation can be seen at:

http://supercollider.sourceforge.net

Links

Within the text, and at the end of each section there might be a list links to other documents, that will look something like this:

	See also: Some other document

Most of these are meant to expand upon what you have just read, but some just point you in the direction of further information which you will probably need in the future. Some of the linked documents are written in fairly technical language, and may duplicate information which is presented in this tutorial in a more casual form. Often they are designed as reference documents for people already familiar with SC, so don't worry if everything in them doesn't immediately make sense. You won't need to have seen and/or fully understood them in order to continue with the tutorial.

Code Examples

Code examples within the text are in a different font:

	{ [SinOsc.ar(440, 0, 0.2), SinOsc.ar(442, 0, 0.2)] }.play;

This is a common convention in documentation of computer languages, and one that is followed throughout SC's doc. The different colours you'll see in code are just to make things clearer, and have no effect on what the code does. 

You are encouraged to copy the code examples to another window and play around with modifying them. This is a time honoured way of learning a new computer language! SC will allow you to mofify the original tutorial documents, but if you do so you should be careful not to save them (for instance if prompted when closing them). It's safest to copy things to a new document before changing them.

____________________

This document is part of the tutorial Getting Started With SuperCollider.

Click here to go on to the next section: First Steps

Click here to return to the table of Contents: Getting Started With SC

