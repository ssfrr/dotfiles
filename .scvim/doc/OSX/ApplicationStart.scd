ApplicationStart			register functions to be evaluated on Application start

Superclass: StartUp

Available in OSX SuperCollider.app Only.

ApplicationStart allows you to register functions or objects to perform an action only  on application start.
The functions will be evaluated last; After the library has been compiled, the startup file has run and StartUp actions have been evaluated.

Class Methods

*add(object)

Registers an object or function.
Objects will be receive a doOnApplcationStart message on application start. Functions will be evaluated.  

*remove(object)

Removes a function that was previously registered.

*run

evaluates the functions or objects in order.

See also [StartUp] for functions that are evaluated every time the ClassLibrary is recompiled.


Examples

SomeStartClass {
	*initClass {
		ApplicationStart.add {
			// something to do when the app has been launched...
		}
	
	
	}
}

// or...
SomeStartClass {
       *initClass {
               ApplicationStart.add(this);
       }

       *doOnApplicationStart { "something started".postln }
}




