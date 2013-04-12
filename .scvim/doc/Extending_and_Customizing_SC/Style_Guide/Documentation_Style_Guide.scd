Style Guide for SuperCollider Documentation

See also: Helper AutoClassHelper UGenHelpTemplate ClassHelpTemplate TopicHelpTemplate

What this Guide Covers

This document is intended as a style guide for SuperCollider documentation. SuperCollider's documentation must meet more varied requirements than some general purpose languages, as it needs to address a range of users from computer scientists to computer novices. It contains quick reference files, topics tutorials, and everything in between. As such, it should be understood that there will be numerous necessary exceptions to these guidelines, and that the intent of this guide is to assist in achieving consistency, clarity, and completeness.

This document is not specifically intended to cover large-scale tutorials or third party libraries, although it is expected that authors may find these guidelines useful and appropriate in those contexts as well.

General Points

Documentation should be complete. That is to say, all non-'private' methods of classes should be documented. Default values for arguments should be given, as should the type of any value returned. In general methods should only be documented in the help file for the class in which they are implemented, but on occasion it may be appropriate to document some inherited methods in help files for subclasses as well, for the sake of clarity.

HTML is the preferred file format for documentation, and these guidelines are written mostly with html in mind. That said, much of what is contained here could apply to documentation in rtf, rtfd, or scd (plain text) formats as well.

Use of the automatic help file generating faciliies of Helper and AutoClassHelper is encouraged. In addition to making it easier to create helpfiles these help ensure consistency, completeness and uniformity.

HTML should be basic. On OSX it can be generated automatically and is WYSIWYG editable. (See Notes-on-the-HTML-Help-System for details.) The use of hand-coded or overly complex HTML should be avoided wherever possible since it may not be parsed correctly on all platforms. HTML documents should not load non-local resources and should always function correctly in an offline context.

Authors should aim to strike an appropriate balance between specialist discussion and accessibility to new users. Jargon should be used where it enhances clarity, but not where it is unnecessary. Naturally the particular level at which a given document is written will be context dependant.

Links should be hyperlinks rather than the old style help links.

Underlining should be avoided, as it is used for the built-in wiki system and can result in unintentional document creation by users.

The use of margins (on OSX use Format->Text->Show Ruler, Copy Ruler, etc.) is preferrable to tabs when indenting chunks of prose (i.e. method explanations), as it maintains proper text wrap when edited. Tabs are fine for example code and should be utilised to indicate scope.

The use of 'see also' links is encouraged.

Authors are encouraged to keep these guidelines in mind when updating old help files, and correct any issues or inconsistencies.

Font Recommendations

Document Titles: Helvetica 18 point Bold
Document Description (on the same line as the title): Helvetica 12 point Bold
Section Titles: Helvetica 14 point Bold
Prose: Helvetica 12 point
Emphasized Text (inluding method and argument names, bullet headings, etc.): Helvetica 12 point Bold
Code examples: Monaco 9 point, syntax colorised

Code Examples

Examples should make use of object style rather than messaging style unless the document in question relates specifically to the latter.

Examples should use SynthDef:add rather than SynthDef:load or :store, or :memStore  wherever appropriate to avoid creating scsyndef files on the user's hard-drive (this recommendation has changed).

Examples can use a mixture of Function:play and SynthDef style approaches where appropriate.

Examples in object style should pass server abstraction objects such as Nodes, Buffers, and Busses as args directly rather than using the nodeID, bufnum, and index methods wherever possible.

Examples can be placed in an examples section at the end of the text or interspersed within the text. The former is often appropriate for short documents (such as UGen help files) and the latter for longer documents. In some cases it may be appropriate to do both; for instance a large class with short examples demonstrating individual methods within the text and a longer examples section at the end. Interspersed examples should be indented.

The initial examples in any help file should be as simple and clear as possible.

Examples in the general SC documentation should not be dependant on any third party libraries, Quarks, etc. in order to function.

Examples should include any necessary cleanup code. This includes explicitly freeing any created synths. Examples should not rely on an implicit use of Cmd-.

Examples should wrap blocks of code that are meant to be executed together in parentheses. Individual examples should be distinguished by comments.

Examples should make appropriate use of comments to explain what is happening.

GUI examples should make use of the view redirect classes wherever possible in order to ensure cross-platform compatibility. See GUI-Overview for more information.

Classes which are effectively front ends for OSC functionality (i.e. the server abstraction classes) should contain a section showing the OSC messages generated by the class. This can for instance take the form of an example using Server:makeBundle.

Examples which make reference to keyboard shortcuts should include all cross-platform equivalents. See Shortcuts for documentation of these.

The use of plot and scope in examples is encouraged where appropriate (i.e. to illustrate something particular about a UGen), but such examples should not be the only ones in any file as they have GUI dependencies. Alternatively, plots can be included as images. Scope examples should call Stethoscope.defaultServer to get the appropriate server object.

Layout

Documents should be in one three styles, broadly speaking (although the use of custom document styles may sometimes be necessary):

UGen Help File - A short file outlining *ar, *kr, and *ir methods as appropriate. Should include examples. mul and add arguments are generally not documented due to their ubiquity.

Class Help File - Usually a longer file documenting a particular class. In general methods will be divided up into sections by type and related functionality, rather than simply listed alphabetically. For smaller classes they might simply be divided into Class Methods and Instance Methods. Detailed general explanations can be done at the top of the document or at the top of each relevant section. It is often appropriate to document getters and setters or other closely related methods together. These documents should still be suitable for quick reference, so if extensive prose explanation is necessary it may be appropriate to move that text to a 'Topic' file and link to it.

Topic File - These are longer, mostly prose documents which serve as short tutorials explaining some aspect of SC's use or design, relevant theory, etc. These are less than full-fledged general tutorials but probably still useful for some reference. As a general rule particular care should be taken in this type of document to ensure that they are accessible to users with less experience.

Authors will probably find it simplest to use Helper and AutoClassHelper when creating help files, but the following templates are available for use: UGenHelpTemplate ClassHelpTemplate TopicHelpTemplate
	
v. 1.3 April 2009


