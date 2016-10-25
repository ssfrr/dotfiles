Help

SuperCollider has a built-in help system. To see the main help page, press cmd-d (without first selecting anything). From that page, click on underlined topics or press cmd-d after selecting text. Another useful document is More-On-Getting-Help.

In general, there are help files for classes (capitalized words, such as SinOsc, Array, Nil, etc.). Select the name of a class and press Cmd-d. A help file, if one exists, will open.

////////////////////////////////////////////////////////////////////////////////////////////////////

To see every SuperCollider helpfile

evaluate

Help.all

////////////////////////////////////////////////////////////////////////////////////////////////////

To see all unit generators helpfiles

evaluate

Help("Help/UGens").dumpToDoc("SuperCollider UGens (Unit Generators)")

Each line of text in the document that appears contains a word to which is appended the suffix ".help". Double-click any of the words to select them and press Cmd-D to open the corresponding help file. Omit the ".help" appended to the word when double-clicking

////////////////////////////////////////////////////////////////////////////////////////////////////

Class definitions, message implementations, and the Find command

To see source code for class definitions, select the name of a class and type cmd-j

To see how a class or classes implement a particular message, select the message name and press cmd-y.

Use the Find and Find Next commands, available through the Edit menu, to search for text in the frontmost document

////////////////////////////////////////////////////////////////////////////////////////////////////

grep

Use grep in the Terminal (in the Applications->Utilities folder) to search for all occurrences of a given word or phrase. For example, to see all documents that use the LFSaw class, evaluate (in the Terminal application)

grep -r LFSaw /Applications/SuperCollider_f

Because lines in the terminal application break according to the size of the window and not through schemes that enhance readability, it may be easier to write grep results to a file, as in

// change the name of the path (the argument after the '>' sign, as appropriate
grep -r LFSaw /Applications/SuperCollider_f/ > /Users/yourHomeDirectory/Desktop/grep_results

////////////////////////////////////////////////////////////////////////////////////////////////////

Additional sources

The SuperCollider wiki: http://swiki.hfbk-hamburg.de:8888/MusicTechnology/6

The SuperCollider users mailing list archive: http://swiki.hfbk-hamburg.de:8888/MusicTechnology/437

The SuperCollider user or developer lists (or both).

	http://www.create.ucsb.edu/mailman/listinfo/sc-users
	http://www.create.ucsb.edu/mailman/listinfo/sc-dev
	
David Cottle has a large course on sound synthesis based around SC3.

A course by Nick Collins: 

	http://www.informatics.sussex.ac.uk/users/nc81/courses/cm1/workshop.html

The pseudonym tutorial: http://www.psi-o.net/pseudonym/

The MAT tutorial (UC-Santa Barbara) tutorial: http://www.mat.ucsb.edu/~sc/

////////////////////////////////////////////////////////////////////////////////////////////////////


