Notes on the HTML Help System

On the OSX platform SC provides support for html help files through NSTextView's WebKit integration. The following should be noted:

Links

- Selected text can be converted to a link to the corresponding help file in SC's help search path (Help/ and the Extension directories) using the "Link to Help File" item in the Edit menu. The selected text should not include file extensions.

- Links can be manually edited using the "Edit Link" item in the pop-up menu. (Ctrl-click)

- Links will be relative if both the linking file and the linked file are in Help/, or if both are not. (This allows for relative linking of extension help files which are distributed together.) Manually edited file: scheme links will be converted to relative links on save.

- If one file is not in Help/ and one is (i.e. linking from an extension file back to a file in Help/), a special SC: scheme link will be created, of the form SC://FilenameWithoutExtension. SC: scheme links call the help search routine.

- Bad links cause a warning to be posted, and then call the help search routine.

- Links which are not relative, and which do not use the file: or SC: schemes are not handled. This allows for http: scheme links to be passed on to Safari for instance.

Attachments

- Attachments are saved in ./attachments/thisDocName/ relative to the main file.

- Image attachments are converted to PNG files.

Generated HTML

- HTML is generated afresh each time a file is saved. This allows for WYSIWYG editing. The general html support is reasonable, but because of this custom and hand-coded html should be used as a last resort only.

- Occurences of %20 are converted to " " for compatibility with PsyCollider.

- NSTextView doesn't like <b> tags within spans, but unfortunately the html export outputs bold underlined text in that way. For this reason on save a function determines the span class for underlines and places these spans within the corresponding <b></b> tags, rather than the other way around.


