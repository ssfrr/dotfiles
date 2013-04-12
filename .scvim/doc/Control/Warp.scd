Warp			specification of a shape for a mapping of numerical input 

Inherits from: Object 

The subclasses of Warp specify translations from input (a number) to an output (another number).  This is an abstract class – already available shapes are linear, exponential, sine, cosine, decibel, curve (this is similar to the curves in envelopes, see also Env). 

Warps are internally created by ControlSpec. Usually they are created by the message asWarp, understood by symbols and numbers. A warp has a Spec to specify a certain range of input and output values.

	// create a new warp:
	a = \exp.asWarp;
	a = -4.asWarp; // a curve warp;

	map (value)
	
		Maps and constrains a value between 0 and 1 to the output domain.
		

	unmap (value)
	in the output domain to a value in the range between 0 and 1.
		
	g = -3.asWarp;
	g.map(0.5);
	g.unmap(0.9);	
	
	// fore and back translation should be identical:
	g.unmap(g.map(0.5));
	

	


