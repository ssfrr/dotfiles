StartUp			register functions to be evaluated after the startup is finished

Superclass: AbstractSystemAction

StartUp registers functions to perform an action after the library has been compiled, and after the startup file has run. For instance this is used for creating SynthDef in the initClass function of class files in order to be able to make the synthdef directory customizable by the startup script.

If an object is registered, doOnStartUp must be implemented. Otherwise a function can be used.

See Also: CmdPeriod, ServerBoot, ServerTree, ServerQuit

Class Methods

*add(object)

Registers an object or function to be evaluated after startup is finished. 

*defer(object)

Registers an object or function to be evaluated after startup is finished, or immediately, if this has happened already.

*remove(object)

Removes an object that was previously registered.

*run

call the object in order.




Examples

*initClass {
	StartUp.add {
		// something to do...
	}


}




