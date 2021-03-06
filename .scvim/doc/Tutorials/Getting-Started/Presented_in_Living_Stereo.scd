Presented in Living Stereo

Okay, but what about our first, unsimplified example? Remember:

	{ [SinOsc.ar(440, 0, 0.2), SinOsc.ar(442, 0, 0.2)] }.play;
	
This also has two SinOscs, but in a different arrangement, between two square brackets [], and with a comma in between. Just like the curly brackets indicate a Function, square brackets define something called an Array. An Array is a type of Collection, which is (you guessed it) a collection of Objects. Collections themselves are Objects, and most types of Collections can hold any types of objects, mixed together, including other Collections! There are many different types of Collections in SC, and you will come to learn that they are one of the SC's most powerful features.

An Array is a particular type of Collection: An ordered collection of limited maximum size. You can make one as we have above, by putting objects in between two square brackets, with commas in between. You can get the different elements of an Array using the method 'at', which takes an index as an argument. Indices correspond to the order of objects in the Array, and start from 0.

	a = ["foo", "bar"];	// "foo" is at index 0; "bar" is at index 1
	a.at(0);
	a.at(1);
	a.at(2);				// returns "nil", as there is no object at index 2
	
	// there's a shorthand for at that you'll see sometimes:
	a[0];				// same as a.at(0);
 
In addition to being used to hold collections of objects, Arrays also have a special use in SC: They are used to implement multichannel audio! If your Function returns an Array of UGens (remember that Functions return the result of their last line of code) then the output will be a number of channels. How many depends on the size of the Array, and each channel will correspond to an element of the Array. So in our example:

	{ [SinOsc.ar(440, 0, 0.2), SinOsc.ar(442, 0, 0.2)] }.play;

What we end up with is stereo output, with a SinOsc at 440Hz in the left channel, and a SinOsc at 442Hz in the right channel. We could have even more channels of output by having a larger array.

Now watch carefully, because this next bit involves a little slight of hand, but shows another way in which SC makes things very interchangeable. Because the arguments for phase and mul are the same for both SinOscs, we can rewrite the code for our example like this:

	{ SinOsc.ar([440, 442], 0, 0.2) }.play;

We've replaced the frequency argument with an Array. This causes something called 'multichannel expansion', which means that if you plug an Array into one of a UGen's arguments, you get an Array of that UGen instead of a single one. Now consider this:

	(
	{ var freq;
		freq = [[660, 880], [440, 660], 1320, 880].choose;
		SinOsc.ar(freq, 0, 0.2); 
	}.play;
	)

Try executing it several times, and you'll get different results. 'choose' is just a method which randomly selects one of the elements of the Array. In this case the result may be a single number or another Array. In the case of the latter you'll get stereo output, in the case of the former, monophonic. This sort of thing can make your code very flexible.

But what if you want to 'pan' something, crossfading it between channels? SC has a number of UGens which do this in various ways, but for now I'll just introduce you to one: Pan2. Pan2 takes an input and a position as arguments and returns an Array of two elements, the left and right or first and second channels. The position arg goes between -1 (left) and 1 (right). Take a look at this example:

	{ Pan2.ar(PinkNoise.ar(0.2), SinOsc.kr(0.5)) }.play;

This uses a SinOsc to control the position (remember it outputs values from -1 to 1, or left to right), but uses a different UGen as the input to the Pan2, something called PinkNoise. This is just a kind of noise generator, and it has a single argument: mul. You can of course also used fixed values for the position arg.

	{ Pan2.ar(PinkNoise.ar(0.2), -0.3) }.play; // slightly to the left
	
For more information see: 

MultiChannel Collections Pan2

Suggested Exercise:

Experiment with altering the Functions in the text above. For instance try changing the frequencies of the SinOsc, or making multi-channel versions of things.

____________________

This document is part of the tutorial Getting Started With SuperCollider.

Click here to go on to the next section: Mix it Up

Click here to return to the table of Contents: Getting Started With SC


