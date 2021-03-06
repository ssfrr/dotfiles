SuperCollider 3 Synth Definition File Format

copyright © 2002 James McCartney

Synth definition files are read by the synth server and define collections of unit generators and their connections. These files are currently written by  the SuperCollider language application, but theoretically could be written by any program. Such a program would need knowledge of the SC unit generators and their characteristics, such as number of inputs and outputs and available calculation rates. The code to write these files is open and available in the SuperCollider language app.

Basic types 

	All data is stored big endian. All data is packed, not padded or aligned.
	an int32 is a 32 bit integer.
	an int16 is a 16 bit integer.
	an int8 is an 8 bit integer.
	a float32 is a 32 bit IEEE floating point number.
	a pstring is a pascal format string: a byte giving the length followed by 
		that many bytes. 
	
	
File Format 

a synth-definition-file is :
	int32 - four byte file type id containing the ASCII characters: "SCgf"
	int32 - file version, currently 1.
	int16 - number of synth definitions in this file (D).
	[synth-definition] * D
end

a synth-definition is :
	pstring - the name of the synth definition
	
	int16 - number of constants (K)
	[float32] * K - constant values
	
	int16 - number of parameters (P)
	[float32] * P - initial parameter values
	
	int16 - number of parameter names (N)
	[param-name] * N
	
	int16 - number of unit generators (U)
	[ugen-spec] * U
end
	
a param-name is :
	pstring - the name of the parameter
	int16 - its index in the parameter array
end

a ugen-spec is :
	pstring - the name of the SC unit generator class
	int8 - calculation rate
	int16 - number of inputs (I)
	int16 - number of outputs (O)
	int16 - special index
	[input-spec] * I
	[output-spec] * O
end

an input-spec is :
	int16 - index of unit generator or -1 for a constant
	if (unit generator index == -1) {
		int16 - index of constant
	} else {
		int16 - index of unit generator output
	}
end

an output-spec is :
	int8 - calculation rate
end


Glossary

calculation rate - the rate that a computation is done. There are three rates numbered 0, 1, 2 as follows: 
	0 = scalar rate - one sample is computed at initialization time only.	1 = control rate - one sample is computed each control period.
	2 = audio rate - one sample is computed for each sample of audio output.
Outputs have their own calculation rate. This allows MultiOutUGens to have outputs at different rates. A one output unit generator's calculation rate should match that of its output.

constant -  a single floating point value that is used as a unit generator input.

parameter - a value that can be externally controlled using server commands /s.new, /n.set, /n.setn, /n.fill, /n.map .

parameter name - a string naming an index in the the parameter array. This allows one to refer to the same semantic value such as 'freq' or 'pan' in different synths  even though they exist at different offsets in their respective parameter arrays.

special index - this value is used by some unit generators for a special purpose. For example, UnaryOpUGen and BinaryOpUGen use it to indicate which operator to perform. If not used it should be set to zero.

synth - a collection of unit generators that execute together. A synth is a type of node.

synth definition - a specification for creating synths.

unit generator -  a basic signal processing module with inputs and outputs. unit generators are connected together to form synths.

Notes

Unit generators are listed in the order they will be executed. Inputs must refer to constants or previous unit generators. No feedback loops are allowed. Feedback must be accomplished via delay lines or through buses. 

For greatest efficiency:

Unit generators should be listed in an order that permits efficient reuse of connection buffers, which means that a depth first topological sort of the graph is preferable to breadth first.

There should be no duplicate values in the constants table.

copyright © 2002 James McCartney


