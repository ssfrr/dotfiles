A Practical Guide to Patterns
H. James Harkins

Introduction

Patterns are one of the most powerful elements of the SuperCollider language, but in some ways they can be difficult to approach using only the class-oriented help files. These documents seek to bridge the gap, explaining the conceptual background behind patterns, describing the usage of specific Pattern classes, and proceeding into examples of practical musical tasks written as patterns.


Contents


 PG_01_Introduction: Fundamental concepts of patterns and streams
 PG_02_Basic_Vocabulary: Common patterns to generate streams of single values
 PG_03_What_Is_Pbind: Pattern-based musical sequencing with Pbind and cousins
 PG_04_Words_to_Phrases: Nesting patterns, arranging music in terms of phrases
 PG_05_Math_on_Patterns: Performing math and collection operations on patterns
 PG_06_Filter_Patterns: Overview of patterns that modify the behavior of other patterns
 PG_06a_Repetition_Contraint_Patterns: Patterns that repeat values, or cut other patterns off early
 PG_06b_Time_Based_Patterns: Patterns using time as the basis for their evaluation
 PG_06c_Composition_of_Patterns: Making multiple event patterns act as one
 PG_06d_Parallel_Patterns: Running multiple event patterns simultaneously
 PG_06e_Language_Control: Patterns that mimic some language-side control structures
 PG_06f_Server_Control: Patterns that manage server-side resources
 PG_06g_Data_Sharing: Writing patterns to use information from other patterns
 PG_07_Value_Conversions: Describes the default event's conversions for pitch, rhythm and amplitude
&nbsp;PG_08_Event_Types_and_Parameters: Describes the event types defined in the default event, and the parameters they expect.


The pattern cookbook is a set of examples with explanations.


 PG_Cookbook01_Basic_Sequencing

Playing a predefined note sequence
“Multichannel” expansion
Using custom SynthDefs (including unpitched SynthDefs)

 PG_Cookbook02_Manipulating_Patterns

Merging (interleaving) independent streams
Reading an array forward or backward arbitrarily
Changing Pbind value patterns on the fly

 PG_Cookbook03_External_Control

Control of parameters by MIDI or HID
Triggering patterns by external control

 PG_Cookbook04_Sending_MIDI: Sending notes under pattern control to MIDI devices.
 PG_Cookbook05_Using_Samples

Playing a pattern in time with a sampled loop
Using audio samples to play pitched material

 PG_Cookbook06_Phrase_Network

Building a more complicated melody using shorter phrase patterns
Also illustrates PmonoArtic for portamento with articulation

 PG_Cookbook07_Rhythmic_Variations: An ever-changing drumbeat


Reference material


 PG_Ref01_Pattern_Internals: Details of pattern implementation, with guidance on writing new pattern classes



Why patterns?

Patterns describe calculations without explicitly stating every step. They are a higher-level representation of a computational task. While patterns are not ideally suited for every type of calculation, when they are appropriate they free the user from worrying about every detail of the process. Using patterns, one writes what is supposed to happen, rather than how to accomplish it.

In SuperCollider, patterns are best for tasks that need to produce sequences, or streams, of information. Often these are numbers, but they don't have to be -- patterns can generate any kind of object.

For a simple example, let's count upward starting from 0. We don't know how high we will need to count; we just know that every time we ask for values, we should get a continually increasing series.

Writing everything out, it looks like this. Routine is used because this is a control structure that can interrupt what it's doing and remember where it was, so that it can pick up again at exactly that point. You can get some numbers out of it, and call it again later and it will keep counting from the last number returned. (This is an example of a Stream. You can find more about Streams in Streams-Patterns-Events1.)

a = Routine {
	var	i = 0;
	loop {
		i.yield;
		i = i + 1;
	};
};

a.nextN(10);

SuperCollider's built-in control structures allow some simplification.

a = Routine {
	(0..).do { |i|
		i.yield;
	};
};

a.nextN(10);

But wouldn't it be nice just to say, "Give me an infinite series of numbers starting with 0, increasing by 1"? With Pseries, you can. (Here, keyword addressing of the arguments is used for clarity, but 'start', 'step' and 'length' can be omitted.)

a = Pseries(start: 0, step: 1, length: inf).asStream;

a.nextN(10);

What are the advantages of the pattern representation?


It's shorter.
It's tested and it works. You don't have to debug how Pseries works (whereas, if you write a Routine, you might make a mistake and then have to find it.)
With the Routine -- especially if it's complicated -- you will have to decipher it when you come back to the code later. The Pattern states the purpose right there in the code.


What are some disadvantages?


Patterns are a new vocabulary to learn. Until you know a critical mass of them, it can be hard to trust them. That's the purpose of this guide!
If there isn't a pattern that does quite what you want, then it might take some ingenuity to combine patterns into new designs. (Custom behaviors can always be written using Proutine.)


Using patterns for sequencing might seem to be an advanced usage, but for many uses they are easier than the equivalent code written out step by step. They can serve as a bridge for new and advanced users alike, to represent a musical conception more directly with less connective tissue explicitly stated.

The first step in learning a new language is vocabulary, so the next chapter will concentrate on foundational patterns to generate data streams of nearly every sort.


Patterns versus Streams

Some context that is important to keep in mind throughout this discussion is the difference between patterns and streams. In the most general terms:

Patterns define behavior; streams execute it.

A pattern is like a blueprint for a building, showing how all the parts fit together. The building doesn't exist until the contractors go and do what the plans specify. When a stream is made from a pattern, it follows the plans laid out in the pattern's blueprint. Rendering the plans into a real-world result does not change the blueprint in any way, but to get the result, the stream has to go through different states.

A pattern is supposed to describe behavior, and in general, evaluating the pattern (by way of a stream) should not change anything in the Pattern object itself. In computer science terms, patterns are stateless; their definition does not change over time. The stream is what keeps track of where we are in the pattern's evaluation.

This explains an easy "gotcha" with patterns -- forgetting to turn the pattern into a stream doesn't get the expected result. Since a pattern doesn't have any concept of a current state, calling 'next' on it is meaningless, so 'next' does what it does for most objects: return the receiver object itself. The method 'asStream' creates the stream conforming to the pattern's specification, and calling 'next' on the stream advances to its next state and returns the new value.

p = Pseries(0, 1, 10);
p.next;	// always returns the Pseries, not actual numbers

q = p.asStream;
q.next;	// calling this repeatedly gets the desired increasing integers

There is a concrete benefit to this strict division of labor. Since the stream does not modify the original pattern, any number of streams can be made from the same blueprint. All of those streams maintain their own independent states, and they can operate concurrently without interfering with each other.

r = p.asStream;
r.next;	// starts from zero, even though q already gave out some numbers

q.next;	// resumes where q left off, with no effect from getting values from r

[q.next, r.next]	// and so on...

Bear these points in mind as we move to the next subject: getting basic types of data (deterministic and random) out of patterns.


Next:		PG_02_Basic_Vocabulary


Documentation licensing

The initial version of these documents was written December-February 2009 by H. James Harkins. As part of the SuperCollider package, they are released under the Creative Commons CC-BY-SA license. As SuperCollider is an open source project, it is expected (and encouraged) that other users will contribute to the series. Dr. Harkins, however, wishes to retain exclusive rights to revise and republish the original body of work independently of the open-source copy. This excludes material contributed into svn by others. The work may be redistributed at no charge with proper attribution:

Harkins, Henry James. "A Practical Guide to Patterns." SuperCollider 3.3 Documentation, 2009.


