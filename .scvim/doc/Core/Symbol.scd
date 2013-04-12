Symbol			unique name

superclass: Object

A Symbol is a name that is guaranteed to be unique. They can be used to represent
symbolic constant values, Dictionary keys, etc.

Symbols are represented syntactically as literals which are described in [Literals]


Creating a Symbol

	A symbol can be written by surrounding characters by single quotes (may include whitespace):

	'foo bar'

	Or by a preceeding backslash (then it may not include whitespace):

	\foo

	A String can be converted into a symbol:

	"arbeit".scramble.asSymbol;


Testing

	isClassName / isMetaClassName
	
		Answer whether the symbol can be a class name / meta class name. This does not say if the class exists.
	
		\Array.isClassName;
		\Bauxite.isClassName;
		\Meta_Array.isMetaClassName;
	
	isSetter
	
		Answer whether the symbol has a trailing underscore.
	
		'_action'.isSetter;
	
	isPrimitiveName
	
		Answer whether the symbol is a valid primitive name
	
		'_SymbolIsClassName'.isPrimitiveName;


Conversion

	asString
	
	Convert to a String
	
	asInteger
	
	Convert to an Integer
	
	asClass
	
	Answer the Class named by the receiver.
	
	asSetter
	
	Return a symbol with a trailing underscore added.
	
	asGetter
	
	Return a symbol with a trailing underscore removed.
	
	ascii
	
	return the ascii codes as an array
	
	asSpec
	
	Convert to a ControlSpec

	asTuning
	
	Convert to a Tuning
	
	asScale
	
	Convert to a Scale
	

Environments

Symbols are used as keys to look up objects in dictionaries and environments, but also in arrays. 
See IdentityDictionary, Environment, Event

	a = ();
	a.put(\commune, 1871);
	a.at(\commune);

	envirPut(aValue)
	
	put a value to the current environment using receiver as key
	
	
	envirGet
	
	return a value from the current environment using receiver as key
	
	\foo.envirPut(100);
	\foo.envirGet;
	\foo.envirPut(nil);
	
Math

	Symbols respond to all unary and binary math operations by returning themselves. The result of any math operation between a Number or other math object and a Symbol is to return the Symbol. This allows for example operations on lists of notes which contain 'rest's to preserve the rests.
	
		Pseq([1, 3, \rest, 2, 4] + 8);
	
	applyTo(firstArg ... args)
	
	Use the symbol as a method selector and perform the message on firstArg, with args as arguments. This is used for mixing functions with method selectors (see also: Function).
	
		'%'.applyTo(2553, 345);
		['+', '-', '*', { |a, b| a.rand + b.rand } ].choose.applyTo(2, 3);
		
	
	
Synthesis

	Inside SynthDefs and UGen functions, symbols can be used to conventiently specify control inputs of different rates and with lags (see:  NamedControl, ControlName, and Control).
	
	
	kr(val, lag)
	
	Return a control rate NamedControl input with a default value (val), and if supplied, with a lag. If val is an array, the control will be multichannel.
	
	a = { SinOsc.ar(\freq.kr(440, 1.2)) }.play;
	a.set(\freq, 330);
	a.release;
	a = { SinOsc.ar(\freq.kr([440, 460], 1.2)) }.play;
	a.setn(\freq, [330, 367]);
	a.release;
	
	ar(val, lag)
	
	Return an audio rate NamedControl input with a default value (val), and if supplied, with a lag. If val is an array, the control will be multichannel.

	ir(val)
	
	Return an intitalization rate NamedControl input with a default value (val). If val is an array, the control will be multichannel.
		
	tr(val)
	
	Return a TrigControl input with a default value (val). If val is an array, the control will be multichannel.
	
	a = { Ringz.ar(T2A.ar(\trig.tr), \freq.kr(500, 1), 0.8) }.play;
	a.set(\freq, 330, \trig, 1);
	a.set(\freq, 830, \trig, 1);
	a.release;

	


