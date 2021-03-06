Runtime errors

Runtime errors occur while a program is executing.

////////////////////////////////////////////////////////////////////////////////////////////////////

Common errors 

1. an object receives a message which it doesn't understand
2. a binary operation (addition, subtraction, multiplication, etc.) can't be performed
3. a value other than true or false appears in a conditional (boolean) test
4. a file can't be opened (a primitive fails)

////////////////////////////////////////////////////////////////////////////////////////////////////

Object doesn't understand

In the case of

3.createRuntimeError

SuperCollider prints a four-part error notification to the post window. The parts of the notification are ERROR, RECEIVER, ARGS, and CALL STACK, as in

ERROR: Message 'createRuntimeError' not understood.
RECEIVER:
   Integer 3
ARGS:
Instance of Array {    (057E7560, gc=01, fmt=01, flg=11, set=00)
  indexed slots [0]
}
CALL STACK:
	DoesNotUnderstandError-reportError
		arg this = <instance of DoesNotUnderstandError>
	Nil-handleError
		arg this = nil
		arg error = <instance of DoesNotUnderstandError>
	Object-throw
		arg this = <instance of DoesNotUnderstandError>
	Object-doesNotUnderstand
		arg this = 3
		arg selector = 'createRuntimeError'
		arg args = [*0]
	< closed FunctionDef >  (no arguments or variables)
	Interpreter-interpretPrintCmdLine
		arg this = <instance of Interpreter>
		var res = nil
		var func = <instance of Function>
	Process-interpretPrintCmdLine
		arg this = <instance of Main>
		
////////////////////////////////////////////////////////////////////////////////////////////////////

The ERROR section explains what went wrong. The RECEIVER section names the the class of the object to which the message was sent. The ARGS section says how many arguments were included in the message. Read the CALL STACK from the bottom to the top to see where the error happened. Reading from bottom to top means going from

Process-interpretPrintCmdLine 

to 

Interpreter-interpretPrintCmdLine 

to 

Object-doesNotUnderstand

to

Object-throw

to

Nil-handleError

to

DoesNotUnderstandError-reportError

which is the first line in the stack.

////////////////////////////////////////////////////////////////////////////////////////////////////

DoesNotUnderstandError-reportError 

is the mechanism that prints the error notification to the post window. Select it and press cmd-j to see how it works (how it prints the notification).

////////////////////////////////////////////////////////////////////////////////////////////////////

Execute

$a * $b

to create another runtime error message. 

////////////////////////////////////////////////////////////////////////////////////////////////////

The ERROR, RECEIVER, ARGS, and CALL STACK headers in the post window explain the problem: Instances of class Char have no knowledge of multiplication.

ERROR: Message '*' not understood.
RECEIVER:
   Character 97 'a'
ARGS:
Instance of Array {    (067F5470, gc=C4, fmt=01, flg=00, set=01)
  indexed slots [1]
      0 : Character 98 'b'
}
CALL STACK:
	DoesNotUnderstandError-reportError
		arg this = <instance of DoesNotUnderstandError>
	Nil-handleError
		arg this = nil
		arg error = <instance of DoesNotUnderstandError>
	Object-throw
		arg this = <instance of DoesNotUnderstandError>
	Object-doesNotUnderstand
		arg this = $a
		arg selector = '*'
		arg args = [*1]
	< closed FunctionDef >  (no arguments or variables)
	Interpreter-interpretPrintCmdLine
		arg this = <instance of Interpreter>
		var res = nil
		var func = <instance of Function>
	Process-interpretPrintCmdLine
		arg this = <instance of Main>
		
////////////////////////////////////////////////////////////////////////////////////////////////////

Unitialized variable (binary operation fails)

Here, the variable a is initialized to an integer and the variable b isn't initialized. Multiplying a (the integer 10)  by b (nil, the value that SuperCollider uses for unitialized data) will create a runtime error.

(
var a = 10;	// a is declared and initialized
var b;		// b declared but not initialized, so it defaults to nil

t = Task({

	4.do({ arg item, i;
	
		if(i != 3) 
			{ i.postln } 			// print the value of i if it doesn't equal 3
			{ (a * b).postln };	// when i equals 3, do a * b
								// ... which is a problem if b is nil
		1.wait;
		
	})
	
});
t.start;
)

////////////////////////////////////////////////////////////////////////////////////////////////////

The printout shows the code ran successfully until the index, i, reached 3, which is when a * b happened. The ERROR, RECEIVER, ARGS, and CALL STACK headers describe the problem.

////////////////////////////////////////////////////////////////////////////////////////////////////

a Task
0
1
2
ERROR: binary operator '*' failed.
RECEIVER:
   nil
ARGS:
Instance of Array {    (067D92B0, gc=CC, fmt=01, flg=00, set=01)
  indexed slots [2]
      0 : Integer 10
      1 : nil
}
CALL STACK:
	DoesNotUnderstandError-reportError
		arg this = <instance of BinaryOpFailureError>
	Nil-handleError
		arg this = nil
		arg error = <instance of BinaryOpFailureError>
	Object-throw
		arg this = <instance of BinaryOpFailureError>
	Object-performBinaryOpOnSomething
		arg this = nil
		arg aSelector = '*'
		arg thing = 10
		arg adverb = nil
	Integer-*
		arg this = 10
		arg aNumber = nil
		arg adverb = nil
	< FunctionDef in closed FunctionDef >
		arg item = 3
		arg i = 3
	Integer-do
		arg this = 4
		arg function = <instance of Function>
		var i = 3
	< FunctionDef in closed FunctionDef >  (no arguments or variables)
	Routine-prStart
		arg this = <instance of Routine>
		arg inval = 758.000000

////////////////////////////////////////////////////////////////////////////////////////////////////

True, false, or other

A value other than true or false in a boolean test, as in

if(x=4) { "this is ok"};

produces

ERROR: Non Boolean in test.
RECEIVER:
   Integer 4
CALL STACK:
	MethodError-reportError
		arg this = <instance of MustBeBooleanError>
	Nil-handleError
		arg this = nil
		arg error = <instance of MustBeBooleanError>
	Object-throw
		arg this = <instance of MustBeBooleanError>
	Object-mustBeBoolean
		arg this = 4
	< closed FunctionDef >  (no arguments or variables)
	Interpreter-interpretPrintCmdLine
		arg this = <instance of Interpreter>
		var res = nil
		var func = <instance of Function>
	Process-interpretPrintCmdLine
		arg this = <instance of Main>
		
////////////////////////////////////////////////////////////////////////////////////////////////////

Correcting the test clause fixes the problem.

if(x==4) { "this is ok"};

////////////////////////////////////////////////////////////////////////////////////////////////////

Primitive fails

Asking for the length of a non-existent file creates a runtime error. The notification shows what went wrong (a C code primitive failed).

f = File("i_don't_exist", "r");
f.length;

ERROR: Primitive '_FileLength' failed.
Failed.
RECEIVER:
Instance of File {    (067D9970, gc=C4, fmt=00, flg=00, set=01)
  instance variables [1]
    fileptr : nil
}
CALL STACK:
	MethodError-reportError
		arg this = <instance of PrimitiveFailedError>
	Nil-handleError
		arg this = nil
		arg error = <instance of PrimitiveFailedError>
	Object-throw
		arg this = <instance of PrimitiveFailedError>
	Object-primitiveFailed
		arg this = <instance of File>
	File-length
		arg this = <instance of File>
	< closed FunctionDef >  (no arguments or variables)
	Interpreter-interpretPrintCmdLine
		arg this = <instance of Interpreter>
		var res = nil
		var func = <instance of Function>
	Process-interpretPrintCmdLine
		arg this = <instance of Main>
		
////////////////////////////////////////////////////////////////////////////////////////////////////


