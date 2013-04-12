Pkey			access a key in an event stream

superclass: Pattern

Pkey simplifies backward access to values in an event being processed by Pbind or another event pattern.

*new(key)

The key is the name of the event variable to read from.


// \b should thus take twice the value of \a in each event:
p = Pbind(\a, Pwhite(1, 10, inf), \b, Pkey(\a) * 2).asStream;


p.next(())	// for Pbind, must pass in a default event even if empty

( 'a': 10, 'b': 20 )
( 'a': 2, 'b': 4 )
( 'a': 5, 'b': 10 )
( 'a': 4, 'b': 8 )
( 'a': 2, 'b': 4 )


