switch

object.switch( test1, trueFunc1, test2, trueFunc2 ... testN, trueFuncN, defaultFunc )

(

a = 4.switch(
	0, { "was 0" },
	1, { "was 1" },
	// test cases are evaluated
	{ 1 + 1 }, { "was 2" },
	4, { "was 4" },
	4, { "flow has stopped, we don't get here unlike traditional switch implementations" },
	// last function is the default
	{ "if the answer wasn't four we would have ended up here, the default" }
);

a

)

switch returns the result of the trueFunc



