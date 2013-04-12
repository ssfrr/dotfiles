Error			superclass of all Errors

Inherits from: Object : Exception

Error and its subclasses separate different types of error is that can occur in the SuperCollider program into distinct classes, so that they can be reported differently to the user.

Anywhere that an error must be reported to the user and execution must stop, an error object must be created and thrown.

(
var file, path = "betcha-this-file-doesnt-exist.txt";
if((file = File(path, "r")).isOpen) {
	"File is % bytes long.\n".postf(file.length);
	file.close;
} {
	Error("File % could not be opened.".format(path)).throw;
};
)

For backward compatibility, .die() creates the error for you.

"Nothing is really wrong; just committing suicide for fun. A Harold and Maude moment.".die;

Throwing an error object gives the caller the opportunity to catch, and possibly recover from, the error. See the Exception help file for more information about this.

Error hierarchy

The following error classes exist in the main library.

	Error
	DeprecatedError: this method is no longer supported.
	MethodError: generic error occurring within a method.
	DoesNotUnderstandError: the receiver does not understand the method name.
	BinaryOpFailureError: a binary operator cannot work with the operand classes.
	ImmutableError: attempted to modify an immutable object.
	MustBeBooleanError: a test (in if or while) returned a non-Boolean value.
	NotYetImplementedError: the method name exists, but isn't implemented yet.
	OutOfContextReturnError: a method return by ^ took place outside of a method.
	PrimitiveFailedError: an error occurred inside a primitive.
	ShouldNotImplementError: you called a method on a class that has no business implementing it.
	SubclassResponsibilityError: you called a method on an abstract class.


