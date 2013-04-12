SomeClass			explanation of what SomeClass is and/or does	

Inherits from: Object : SuperClassOfSomeClass

More detailed prose description of SomeClass.

See also: Server [some other help files]

Some Important Issues Regarding SomeClass (optional)

Explanation of the issues. For more information see ServerTiming and [some other help files].

Creation / Class Methods

	*new(arg1, arg2)
	
		Short prose description of method.
		arg1 - Explanation of arg1 and its default value. Further important information regarding this method. Note the use of margins for effective text wrapping.
		arg2  - Explanation of arg1 and its default value.		
		
		// inline example
		g = SomeClass.new;
		g.doSomething; // explanation
		g.cleanUpMethod;

	*aMethodWithNoArgs
	
		Short prose description of method.
			
An optional short bit of prose explaining something important about the following class methods:

	*anotherSimpleMethod(arg1)
		
		This method does something to arg1. 

	*yetAnotherMethod
		
		Short prose description.
		
		// inline example
		g = SomeClass.new;
		g.yetAnotherMethod; // explanation
		g.cleanUpMethod;

Accessing Instance and Class Variables
	
	setSomeVar_(arg1)
	getSomeVar
		
		Explanation including the type of someVar and a link to its help file.
				
Doing Some Task (optional)

A short bit of prose explaining something about the task.
	
	instanceMethod1(arg1)
		
		Explanation including default value for arg1.	
		
	instanceMethod2(arg1, arg2)
		
		Explanation of this method.
		arg1 - Explanation and default value for arg1. Further important information regarding this method. Note the use of margins for effective text wrapping.
		arg2  - Explanation of arg2 and its default value.	
		
	instanceMethodWithAReturnValue
		
		Returns a Float indicating... (explanation of the method)	
		
	someInstanceMethod(aNode)
	someInstanceMethodMsg(aNode)
	
		Explanation of these two closely related methods.	

Examples

// what this example does
g = SomeClass.new;
g.instanceMethod(someObject);
g.cleanUp;

...


