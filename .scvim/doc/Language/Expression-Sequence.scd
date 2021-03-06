Expression Sequence

A sequence of expressions separated by semicolons and optionally terminated by a semicolon are a single expression whose value is the value of the last expression. Such a sequence may be used anywhere that a normal expression may be used.

max( b = a * 2; b + 5,  10);	// computes the maximum of b+5 and 10

In the above example, the sequence: b = a * 2; b + 5 acts as a single expression for the first argument to max().



