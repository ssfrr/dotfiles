VarSaw		variable duty saw

VarSaw.ar(freq, iphase,width, mul, add)
VarSaw.kr(freq, iphase,width, mul, add)

freq - frequency in Hertz
iphase - initial phase offset in cycles ( 0..1 )
width - duty cycle from zero to one.


({
	VarSaw.ar(
		LFPulse.kr(#[3, 3.03], 0, 0.3, 200, 200),	//freq
		0,									//iphase
		LFTri.kr(1.0).range(0, 1),				//width
		0.1									//mul
	)
}.play
)


({	//same but with static width
	VarSaw.ar(
		LFPulse.kr(#[3, 3.03], 0, 0.3, 200, 200),	//freq
		0,									//iphase
		0.2,									//width
		0.1									//mul
	)
}.play
)


//compare:
Server.internal.boot;
({
	[
		LFPulse.ar(LFPulse.kr(3, 0, 0.3, 200, 200), 0, 0.2, 0.1),
		VarSaw.ar(LFPulse.kr(3, 0, 0.3, 200, 200), 0, 0.2, 0.1)
	]
}.scope(bufsize: 44100, zoom: 5)
)


