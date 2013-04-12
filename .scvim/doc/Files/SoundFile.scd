SoundFile			sclang soundfile data

superclass: Object

The SoundFile class is used to check the size, format, channels etc. when the sclang client needs this information about a SoundFile. Soundfile data can be read and modified. Soundfile data can also be read and written incrementally, so with properly designed code, there is no restriction on the file size.

In most cases you will wish to send commands to the server to get it to load SoundFiles directly into Buffers.  You will not need to use this class for this. See the Buffer helpfile.



(
f = SoundFile.new;
f.openRead("sounds/a11wlk01.wav");
f.inspect;
f.close;
)


Creating

*new

Creates a new SoundFile instance. 

*collect(pattern = "sounds/*")

Returns an array of SoundFile objects whose paths match the pattern.  
(The associated files are closed. These objects can be used to cue playback buffers)

SoundFile.collect("sounds/*").do { |f| f.path.postln };

*use(path, function)

Reads the data of a SoundFile, evaluates the function (passing the file as argument) and closes it again.

// the above example
SoundFile.use("sounds/a11wlk01.wav", { |f| f.inspect });


Playback

cue(event, playNow)
	
Allocates a buffer and cues the SoundFile for playback. Returns an event parameterized to play that buffer.
(See NodeEvent for a description of how events can be used to control running synths.)
The event responds to play, stop, pause, resume, keeping both the file and buffer open.
The file is closed and the  buffer is freed when the event is sent a close message.

arguments
	event | Nil
	An event can passed as an argument allowing playback to be customized using the following keys:
	
		key			default value			what it does
		
		// buffer and playback position:	
		bufferSize		65536
		firstFrame		0					first frame to play
		lastFrame		nil					last frame to play (nil plays to end of file)
	
		// synth parameters
		out:			0					sets output bus
		server:		Server.default			which server
		group:		1					what target
		addAction:	0					head/tail/before/after
		amp:			1					amplitude
	
		instrument:	nil					if nil SoundFile:cue determines the SynthDef
										(one of diskIn1, diskIn2, ...diskIn16)
										
		Here is the default SynthDef used for stereo files:
	
		SynthDef(\diskIn2, { | bufnum, out,  gate = 1, sustain,  amp = 1, ar = 0, dr = 0.01 |
			Out.ar(out, DiskIn.ar(2, bufnum) 
			* Linen.kr(gate, ar, 1, dr, 2)
			* EnvGen.kr(Env.linen(0, sustain - ar - dr max: 0 ,dr),1, doneAction: 2) * amp)
		});
		
		The control sustain determines playback duration based on the firstFrame and lastFrame.
		The control gate allows early termination of the playback
		
	playNow
		This is a boolean that determines whether the file is to be played immediately after cueing.
			
		example:
		f = SoundFile.collect("sounds/*")
		e = f[1].cue;
		
		e = f[1].cue( (addAction: 2, group: 1) );	// synth will play ahead of the default group
		
Read/Write

openRead(inPathname)

Read the header of a file. Answers a Boolean whether the read was successful.
sets the numFrames,numChannels and sampleRate.  does not set the headerFormat and sampleFormat.
inPathname - a String specifying the path name of the file to read.

readData(rawArray)

Reads the sample data of the file into the raw array you supply. You  must have already called openRead.

The raw array must be a FloatArray. Regardless of the sample format of the file, the array will be populated with floating point values. For integer formats, the floats will all be in the range -1..1.

The size of the FloatArray determines the maximum number of single samples (not sample frames) that will be read. If there are not enough samples left in the file, the size of the array after the readData call will be less than the original size.

When you reach EOF, the array's size will be 0. Checking the array size is an effective termination condition when looping through a sound file. See the method channelPeaks for example.

openWrite(inPathname)

Write the header of a file. Answers a Boolean whether the write was successful.
inPathname - a String specifying the path name of the file to write.


writeData(rawArray)

Writes the rawArray to the sample data of the file. You  must have already called openWrite.

The raw array must be a FloatArray or Signal, with all values between -1 and 1 to avoid clipping during playback.

Example:

(
f = SoundFile.new.headerFormat_("AIFF").sampleFormat_("int16").numChannels_(1);
f.openWrite("sounds/sfwrite.aiff");
	// sawtooth
b = Signal.sineFill(100, (1..20).reciprocal);
	// write multiple cycles (441 * 100 = 1 sec worth)
441.do({ f.writeData(b) });
f.close;
)

isOpen
answers if the file is open

close
closes the file

duration
the duration in seconds of the file



Normalizing

*normalize(path, outPath, newHeaderFormat, newSampleFormat, startFrame, numFrames, maxAmp, linkChannels, chunkSize, threaded)

normalize(outPath, newHeaderFormat, newSampleFormat, startFrame, numFrames, maxAmp, linkChannels, chunkSize, threaded)

Normalizes a soundfile to a level set by the user. The normalized audio will be written into a second file. 

Note: While the normalizer is working, there is no feedback to the user. It will look like SuperCollider is hung, but it will eventually complete the operation. You can set threaded:true to get feedback but it will take slightly longer to complete.

Arguments:

path: a path to the source file
outPath: a path to the destination file
newHeaderFormat: the desired header format of the new file; if not specified, the header format of the source file will be used
newSampleFormat: the desired sample format of the new file; if not specified, the sample format of the source file will be used
startFrame: an index to the sample frame to start normalizing (default 0)
numFrames: the number of sample frames to copy into the destination file (default nil, or entire soundfile)
maxAmp: the desired maximum amplitude. Provide a floating point number or, if desired, an array to specify a different level for each channel. The default is 1.0.
linkChannels: a Boolean specifying whether all channels should be scaled by the same amount. The default is true, meaning that the peak calculation will be based on the largest sample in any channel. If false, each channel's peak will be calculated independently and all channels will be scaled to maxAmp (this would alter the relative loudness of each channel).
chunkSize: how many samples to read at once (default is 4194304, or 16 MB) 
threaded: if true, the normalization runs in a routine so that SC can respond (intermittently) while processing. Prevents OSX beachballing. Default is false.

Using the class method (SoundFile.normalize) will automatically open the source file for you. You may also openRead the SoundFile yourself and call normalize on it. In that case, the source path is omitted because the file is already open.

The normalizer may be used to convert a soundfile from one sample format to another (e.g., to take a floating point soundfile produced by SuperCollider and produce an int16 or int24 soundfile suitable for use in other applications).



Instance Variables

<path

Get the pathname of the file. This variable is set via the openRead or openWrite calls.

<>headerFormat

This is a String indicating the header format which was read by openRead and will be written by openWrite. In order to write a file with a certain header format you set this variable.

	Sound File Format symbols:
		header formats:
			read/write formats:
				"AIFF"				- Apple/SGI AIFF format
				"WAV","WAVE", "RIFF"	- Microsoft WAV format
				"Sun", "NeXT"			- Sun/NeXT AU format
				"SD2"				- Sound Designer 2
				"IRCAM"				- Berkeley/IRCAM/CARL
				"raw"				- no header = raw data
				"MAT4"				- Matlab (tm) V4.2 / GNU Octave 2.0
				"MAT5"				- Matlab (tm) V5.0 / GNU Octave 2.1
				"PAF"				- Ensoniq PARIS file format
				"SVX"				- Amiga IFF / SVX8 / SV16 format
				"NIST"				- Sphere NIST format
				"VOC"				- VOC files
				"W64"				- Sonic Foundry's 64 bit RIFF/WAV
				"PVF"				- Portable Voice Format
				"XI"					- Fasttracker 2 Extended Instrument
				"HTK"				- HMM Tool Kit format
				"SDS"				- Midi Sample Dump Standard
				"AVR"				- Audio Visual Research
				"FLAC"				- FLAC lossless file format
				"CAF"				- Core Audio File format
				
			Additionally, a huge number of other formats are supported read only.
			


<>sampleFormat

A String indicating the format of the sample data which was read by openRead and will be written by openWrite. libsndfile determines which header formats support which sample formats. This information is detailed at http://www.mega-nerd.com/libsndfile. The possible header formats are:

		sample formats:
			"int8", "int16", "int24", "int32"
			"mulaw", "alaw",
			"float"
			
		not all header formats support all sample formats.


<numFrames

The number of sample frames in the file.

<>numChannels

The number of channels in the file.

<>sampleRate

The sample rate of the file.



