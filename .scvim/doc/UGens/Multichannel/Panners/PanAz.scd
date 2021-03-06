PanAz			azimuth panner

PanAz.ar(numChans, in, pos, level, width, orientation)

Multichannel equal power panner.

numChans - number of output channels
in - input signal
pos - pan position. Channels are evenly spaced over a cyclic period of 2.0 with 0.0 equal to the position directly in front, 2.0/numChans a clockwise shift 1/numChans of the way around the ring, 4.0/numChans equal to a shift of 2/numChans, etc. Thus all channels will be cyclically panned through if a sawtooth wave from -1 to +1 is used to modulate the pos. N.B. Front may or may not correspond to a speaker depending on the setting of the orientation arg, see below.
level - a control rate level input.
width - The width of the panning envelope. Nominally this is 2.0 which pans between pairs
of adjacent speakers. Width values greater than two will spread the pan over greater numbers
of speakers. Width values less than one will leave silent gaps between speakers.
orientation - Should be zero if the front is a vertex of the polygon. The first speaker will be directly in front. Should be 0.5 if the front bisects a side of the polygon. Then the first speaker will be the one left of center. Default is 0.5.


// five channel circular panning
Server.internal.boot;
(
{
	PanAz.ar(
		5, 				// numChans
		ClipNoise.ar, 	// in
		LFSaw.kr(MouseX.kr(0.2, 8, 'exponential')), // pos
		0.5,			// level
		3			// width
	);
}.play(Server.internal);
Server.internal.scope;
)



