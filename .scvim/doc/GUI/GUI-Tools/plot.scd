plot		plot data in a graph

The .plot method provides the ability to plot data in a GUI window. The method is implemented in the ArrayedCollection class but is also available for other classes for convenience, including Function, Env, Buffer, SoundFile, Wavetable.

receiver.plot(name, bounds, discrete, numChannels, minval, maxval, parent, labels)

Arguments (all optional):

	name - the name to be used as the GUI window title.
	bounds - a Rect providing coordinates for the GUI location.
	discrete - plots are line-plots by default. Set this to true for bar charts.
	numChannels - the number of interleaved channels that an array represents. For Buffers this argument is not available, since it's filled in automatically.
	minval - minimum value(s) for the display range. For a Buffer this defaults to -1 but can be changed.
	maxval - maximum value(s) for the display range. For a Buffer this defaults to +1 but can be changed.
	parent - by default the plot is placed in a new GUI window. This argument can be used to specify an existing GUI container to send the plot to.
	labels - by default labels appear at the top left of the plot giving a data readout based on mouse position. Set this argument to false to prevent them appearing.

If minval and/or maxval are set to nil (this is default, except for Buffers), they will be automatically calculated from the dataset minimum and/or maximum. For multi-channel data, minval and maxval may be arrays, specifying the range independently for each channel (including use of nil, in which case the min/max will be calculated for the specific channel rather than for the overall dataset).

Hitting the L-key on the keyboard when the window is focussed toggles the lock, and the window
can be used to edit the data.


Examples

(See some of the classes linked above for more examples)

// Arrays
[5, 6, 7, 6.5, 4.5, 3.5].plot("Some data")
[5, 6, 7, 6.5, 4.5, 3.5].plot("Some data, in stereo", numChannels:2)
[5, 6, 7, 6.5, 4.5, 3.5].plot("Some data, in stereo", numChannels:2, discrete: true)

{ |i| { |j| j + 1 * i % 6 }.dup(5) }.dup(200).plot("Some 2-d data");

// 3-channel interlaced data
b = [{1.0.rand}.dup(50), { 20.0.rand - 30 }.dup(50),{ 10.0.rand }.dup(50)].lace(150);
b.plot(numChannels:3, minval: nil, maxval: nil); // Common rescaling
b.plot(numChannels:3, minval: [nil, nil, nil], maxval: [nil, nil, nil]); // Separate rescaling

// Envelopes
Env.adsr(0.4, 0.4, 0.8, 0.9).plot

// Buffers
s.boot;
b = Buffer.read(s,"sounds/a11wlk01.wav");
b.plot; // +-1 range
b.plot(minval: nil, maxval: nil); // auto range
b.plot(minval: 0, maxval: nil); // semi-auto range



