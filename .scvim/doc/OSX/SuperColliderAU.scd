SuperColliderAU 	wraps scsynth as an AudioUnits plugin

SuperColliderAU is an AudioUnit wrapper that allows using SuperCollider servers inside AudioUnits hosts on MacOSX. The embedded server may be controlled over OSC as usual. In addition, it may be packed with a synth definition and a configuration file that defines its parameters.

Installing

Copy the bundle "SuperColliderAU.component" into /Library/Audio/Plug-ins/Components or in ~/Library/Audio/Plug-ins/Components

Quick Start:

Start up an Audio Units host application. Common hosts include Apple Logic and Ableton Live. A list of supported hosts can be found in this page of the SuperCollider swiki (feel free to update it):

http://swiki.hfbk-hamburg.de:8888/MusicTechnology/823

Find SuperColliderAU among the rest of AudioUnit plugins and add an instance to a track (check the manual of your host if you don't know how to do this). A panel will appear telling you which port the server is listening to for OSC messages.

Now you can run this code from within the SuperCollider language to talk directly with the embedded server:

u = Server(\scau, NetAddr("127.0.0.1", 9989)); // Change the port from 9989 to the right one for you
u.serverRunning = true;
u.ping(10); // Gives about 0.02 for me - confirms that communication is working
// Now let's create a quick ring-modulator effect:
z = { AudioIn.ar([1,2]) * SinOsc.ar(MouseX.kr(100, 1000)) }.play(u)

Inside the bundle

As an AudioUnit plugin, SuperColliderAU is packaged in a component bundle. All the files needed by SuperColliderAU can be found in the Resources folder inside the bundle:

serverConfig.plist 
Stores configuration parameters for the server (see ServerOptions)

- PortNumber: the udp port that scserver will listen to if available (otherwise, it will look for an available port).
- BlockSize: block size configuration for the server.
- MemorySize: amount of real time memory allocated to this server
- NumWireBufs: maximum number of buffers for connecting ugens
- DoNoteOn: (experimental) if true the server will send an OSC bundle setting the "note" and "velocity" parameters when a MIDI noteon or noteoff message is received. For this to work you need a host that supports Midi effect AudioUnits and sends them MIDI mesages.
- BeatDiv: For linking Demand Ugens to the Host tempo. If this number is set, SupeColliderAU wil trigger bus 0 each beat division and use bus 1 for reset. 

pluginSpec.plist
Stores parameter configuration for standalone plugins. SuperColliderAU will use this to display and set the parameters of your synth definition. Note that the defalt values must be the same for the synth definition, they wil not be set by the wrapper. The value in this file is only for display.

synthdefs 
For standalone plugins you should have your synth definition here. When controlling the server remotely you can just send the synth definitions.

plugins
Here you need all the SC plugins you intend to use with that server. 


Making standalone plugins

Besides controlling SuperColliderAU from within the language, you can create AudioUnits plugins that are controlled from the host using the default GUI. This can be done manually by duplicating SupercolliderAU.component, adding a synthdef and associated SC plugins and editing pluginSpec.plist. However, if you want an AudioUnit with a unique identifier (the identifier is what you see from within the host GUI) you have to recompile its resource file (with the new identifier) using Rez. This program is included in Apple's Developer Tools. A helper class that automates all this process is mantained in the AudioUnitBuilder quark. Using AudioUnitBuilder you can create standalone AudioUnit plugins without leaving SuperCollider.


