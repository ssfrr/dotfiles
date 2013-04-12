ControlName		object to store control information of SynthDef (used internally)

Inherits from: Object

	
	see SynthDesc, SynthDef
	
	For an explicit creation of control names see: NamedControl, Control
	
	
	
	// example
	
	a = SynthDescLib.global; // the global library of SynthDescs
	x = a.synthDescs.at(\default); // get the default SynthDesc
	x.controls.do { |ctl| [\name, ctl.name, \defaultValue, ctl.defaultValue].postln };"";


