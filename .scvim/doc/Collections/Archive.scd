Archive			storing objects to file	

Inherits from: Object : Collection : MultiLevelIdentityDictionary : LibraryBase

Archives can write any object to disk and read from file again. Compex structures of objects can thus be restored. Writing an object to file as a compile string is usually more readable, but does not account for the internal structure of the object.

See also: Library, Object, LibraryBase, writeAsPlist

There is only one global instance: Archive.global, which is initialized automatically.

Class Methods (see superclass for more)

	*global
	*global_(obj)
		return / set the global archive instance
		
	*archiveDir
	*archiveDir_(string)
		set or get the directory that the archive is written to. 
		Default: Platform.userAppSupportDir.
	
	*write(filename)
		write the global archive now. This is called automatically when SuperCollider quits.
		The default filename is "/archive.sctxar"
	
	*read(filename)
		read the global archive now. This is called automatically when SuperCollider recompiles or starts.
		The default filename is "/archive.sctxar"
				

Examples

// make a storage place for various objects:
q = (); // Event

q[\a_long_array] = Array.rand(128, 0.0, 1.0);
q[\pi_squared] = pi * pi;
q[\favourite_sound] = { { SinOsc.ar([300, 330]).sum * LFPulse.kr(2 + [0, 0.01]) * 0.1 }.play };
q[\same_long_array] = q[\a_long_array]; // same objects may appear several times

Archive.global.put(\myData, q);


Archive.global.at(\myData).postcs;

// after a recompile:
s.boot;

q = Archive.global.at(\myData);
q.postcs;
q[\favourite_sound].value;





