By default, SuperCollider has 128 buses for audio signals and 4096 for control signals. The buses, which are items in an array, are what SuperCollider uses to represent audio and control rate data.

////////////////////////////////////////////////////////////////////////////////////////////////////

// the array of audio buses (channels)
[ channel0, channel1, channel2, channel3, channel4, ... , ..., ..., etc., ... channel127 ]

// the array of control buses (channels)
[ channel0, channel1, channel2, channel3, channel4, ... , ..., ..., etc., ... channel4095 ]

////////////////////////////////////////////////////////////////////////////////////////////////////

Placing audio into a bus

Use an Out ugen at the audio rate to put data into an audio bus.

(
SynthDef("dataForABus", {
	Out.ar(
		0,					// write 1 channel of audio into bus 0
		Saw.ar(100, 0.1)		
	)
}).load(s);
)

Synth("dataForABus");

A SynthDef browser

(
SynthDescLib.global.read;
SynthDescLib.global.browse;
)

shows 1 channel of output on channel 0.

////////////////////////////////////////////////////////////////////////////////////////////////////

Getting audio from a bus

Send an .ar message to an In ugen to get data from an audio bus.

(
SynthDef("dataFromABus", {
	Out.ar(
		0,					
		[	// the left channel gets input from an audio bus
			In.ar(0, 1), 			
			SinOsc.ar(440, 0.2), 
		]	
	)
}).load(s);
)

(
Synth("dataForABus");	// synthesize a sawtooth wave on channel 0
Synth("dataFromABus");	// pair it with a sine wave on channel 1
)

////////////////////////////////////////////////////////////////////////////////////////////////////

Control rate buses

Use In.kr and Out.kr to read from or write to control buses.

////////////////////////////////////////////////////////////////////////////////////////////////////

For additional information, see the Out, In,  and Bus files in the SuperCollider help system.

////////////////////////////////////////////////////////////////////////////////////////////////////

go to 6_Controls


