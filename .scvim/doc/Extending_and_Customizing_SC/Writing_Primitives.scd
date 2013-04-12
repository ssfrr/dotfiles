Writing Primitives

In SuperCollider code:

Cocoa {
	prGetPathsDialog { arg returnSlot;
		_Cocoa_GetPathsDialog
		^this.primitiveFailed
	}
}

In your primitive source code define the primitive:

	void initCocoaFilePrimitives()
	{
		int base, index;
		
		base = nextPrimitiveIndex();
		index = 0;
	
		definePrimitive(base, index++, "_Cocoa_GetPathsDialog", prGetPathsDialog, 2, 0);		// further primitives can be laid in...
		//definePrimitive(base, index++, "_Cocoa_SaveAsPlist", prSaveAsPlist, 3, 0);
	}
	

Here is the prototype for definePrimitive:
	
	int definePrimitive(int base, int index, char *name, PrimitiveHandler handler, int numArgs, int varArgs);

The numArgs is the number of arguments that were passed into the SuperCollider method that calls the primitive, plus one to include the receiver which is passed in as the first argument.  

(TODO varArgs ...)
 
Write your primitive

g->sp is the top of the stack and is the last argument pushed. 
g->sp - inNumArgsPushed + 1 is the receiver and where the result goes.

In this example, the numArgsPushed will be 2 (as specified in definePrimitive)

	int prGetPathsDialog(struct VMGlobals *g, int numArgsPushed);
	int prGetPathsDialog(struct VMGlobals *g, int numArgsPushed)
	{
	        if (!g->canCallOS) return errCantCallOS;//if its deferred, does this matter ?
	
	        PyrSlot *receiver = g->sp - 1; // an instance of Cocoa
	        PyrSlot *array = g->sp; // an array
	
	// ...  the body
	
	        return errNone;
	}
	
This example does not set the receiver, so the primitive returns the original receiver unchanged (still an instance of Cocoa).

or set the object at
	
		receiver

which again is at (g->sp - numArgsPushed + 1)


some guidelines:

If possible, you should avoid creating objects in a primitive. Primitives are much simpler to write and debug if you pass in an object that you create in SC code and fill in its slots in the primitive.

When you do fill in slots in an object with other objects, you must call g->gc->GCWrite(obj, slot) in order to notify the garbage collector that you have modified a slot that it may have already scanned.

Do not store pointers to PyrObjects in C/C++ variables unless you can absolutely guarantee that they cannot be garbage collected. For example the File and SCWindow classes do this by storing the objects in an array in a classvar. The object has to stay in that array until no C object refers to it.

Failing to observe the above two points can result in very hard to find bugs.

If you create more than one object in a primitive you must make sure that all the previously created objects are reachable before you allocate another. In other words you must store them on the stack or in another object's slots before creating another. Creating objects can call the garbage collector and if you have not made your objects reachable, they can get collected out from under you.

Since SC is dynamically typed, you cannot rely on any of the arguments being of the class you expect. You should check every argument to make sure it is the correct type. One way to do this is by using isKindOfSlot.  If you just want a numeric value, you can use slotIntVal, slotFloatVal, or slotDoubleVal which will return an error if the value is not a numeric type. Similarly there is slotStringVal. 
It is safe to assume that the receiver will be of the correct type because this is ensured by the method dispatch mechanism.


Q: now where do i put the thing to return it ?

A: into g->sp - inNumArgsPushed + 1.
In most primitives this is referred to by the variable 'a'.






