standardizePath

String Method


Returns a string with ~ replaced by the current user's home directory, and all symbolic links resolved.  

	"~/Documents".standardizePath

/Volumes/Macintosh HD/Users/cruxxial/Documents

	Note that my Documents folder is on a different partition than the boot,
	so the full path uses /Volumes
	
Resolves symbolic links, but does not resolve aliases.

	"~/Library/Favorites/SuperCollider3".standardizePath

/Volumes/Macintosh HD/Users/cruxxial/Library/Favorites/SuperCollider3

Removes extraneous . and .. and /  but does not otherwise expand them.

	"./Help/".standardizePath

Help





