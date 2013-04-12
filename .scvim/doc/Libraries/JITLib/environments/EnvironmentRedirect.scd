EnvironmentRedirect				base class for environment redirects

superclass: Object

Environment that redirects access (put) and assignment (at). 


	*new(envir)		create new redirect, if envir is given it is used.
	envir			return the source environment
	envir_			replace the source environment
	

Overriding the following methods, one can redirect where objects go when they are assigned to 
the space: at, put, localPut, removeAt.
This is done for example in LazyEnvir and ProxySpace.



EnvironmentRedirect implements some of the 
interface of Environment, which it can replace where needed:
	
	*push, *pop, push, pop, make, use, do, clear, keysValuesDo, keysValuesArrayDo,
	findKeyForValue, sortedKeysValuesDo, choose, <>know, doesNotUnderstand




Networking:

EnvironmentRedirect and its subclasses can be used to dispatch assignment over a network.
To do this, a dispatch function can be supplied - see Public.


