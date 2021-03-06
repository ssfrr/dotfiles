To begin

Navigate to the  folder (the directory) in which SuperCollider resides and double-click on it (the red and white balloon icon). An untitled document with text such as

init_OSC
compiling class library..
	NumPrimitives = 548
	compiling dir: '/Applications/SuperCollider3/SCClassLibrary'
	pass 1 done
	Method Table Size 3091264 bytes
	Number of Method Selectors 2880
	Number of Classes 1744
	Number of Symbols 6926
	Byte Code Size 129989
	compiled 299 files in 1.61 seconds 
compile done
prGetHostByName hostname 127.0.0.1 addr 2130706433
RESULT = 256
Class tree inited in 0.09 seconds

appears in the top left of the screen. The document functions as a "Post Window," so-called because SuperCollider uses it to "post" notifications. 

////////////////////////////////////////////////////////////////////////////////////////////////////

Two more windows

On the bottom of the screen are two more windows. One is called "localhost server" and the other is "internal server." Click on the "boot" button on the localhost server. The words "localhost" in the black box of the button turn red and the word "Boot" on the button changes to "Quit." More text, such as

booting 57110
SC_AudioDriver: numSamples=512, sampleRate=44100.000000
start   UseSeparateIO?: 0
PublishPortToRendezvous 0 57110
SuperCollider 3 server ready..
notification is on

will print to the post window. The localhost server is now ready to be used. Activate the internal server, if you wish, in the same way. 

////////////////////////////////////////////////////////////////////////////////////////////////////

Workspace windows

Open existing SC documents with File->Open... or cmd-o. Use File->New or cmd-n to create new documents.

SuperCollider documents generally have .sc appended to their file names; however, SuperCollider can  read and write documents in Rich Text Format (.rtf) and several other formats, as well.

////////////////////////////////////////////////////////////////////////////////////////////////////

go to 2_Evaluating_code


