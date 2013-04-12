BufChannels			current number of channels of soundfile in buffer

superclass: BufInfoUGenBase


	*kr(bufnum)
	*ir(bufnum)
		the .ir method is not the safest choice. Since a buffer can be reallocated at any time,
		using .ir will not track the changes.

	


