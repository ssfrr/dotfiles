Syntax Color Test

&#9658; Strings
&#9658; Special values like true, nil
&#9658; Comments
&#9658; Class names
&#9658; Numbers and character literals
&#9658; Punctuation
&#9658; Plain text, methods and variable names
&#9658; Special variables like super, thisProcess
&#9658; Declarations like var, const
&#9658; Symbols
&#9658; Environment vars


/* Some example nonsense code to test syntax coloring */

~foo = SomeClass.new(\abc, 123, "xyz") { |one, two, three=42.7|
    var myVariable, test = pi*5, bool = true;

    if ((two & one) < 3) { // A comment...
        "hello".postln;
        (abc: $x, def: \y, ghi: nil);
    } {
        [~bar, zoo, thisProcess.platform];
    };
};

Routine {
    inf.do {|i|
        ("count"+i).postln;
        5.0.rand.wait;
    };
}.play;




