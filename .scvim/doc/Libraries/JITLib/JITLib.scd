Just In Time Programming

"Passenger to taxtidriver: take me to number 37. I'll give you the street name when we are there." 
											(an austrian math teacher's joke)


Disclaimer: there is no time, really; punctuality is your personal responsibility though.


Just in time programming (or: conversational programming, live coding1, on-the fly-programming, interactive programming) is a paradigm that includes the programming activity itself in the program's operation. This means a program is not taken as a tool that is made first, then to be productive, but a dynamic construction process of description and conversation – writing code thus becoming a closer part of musical or experimental practice. SuperCollider, being a dynamic programming language, provides several possibilities for modification of a running program - this library attempts to extend, simplify and develop them, mainly by providing abstract placeholders (proxies) that can be modified and used in calculations while playing. There is some specific networking classes which are made to simplify the distribution of  live coding activity.

JITLib simplifies and unifies some orthogonal aspects of SuperCollider. 
It consists of a number of placeholders (server side and client side) and schemes of access.
These two aspects of space corresponding to inclusion and reference, depend on their context - here the placeholders are like roles which have a certain behaviour and can be fulfilled by certain objects.
It is useful to be aware of the three aspects of such a placeholder: a certain set of elements can be their source, they can be used in a set of contexts and have a default source, if none is given.


Frequently used classes:
	Tdef (for tasks), ProxySpace, NodeProxy and Ndef (for synths), Pdef and Pdefn (for patterns).



For additional functionality, see also JITLib extensions Quark. To install it, evaluate:
"JITLib extensions".include;


Tutorial: Interactive Programming with SuperCollider and jitlib

This tutorial focusses on some basic concepts used in JITLib. There are many possibilities,
such as server messaging and pattern proxies which are not covered in tutorial form presently.


content:

	placeholders in sc 				jitlib_basic_concepts_01
	referencing and environments 	jitlib_basic_concepts_02
	internal structure of node proxy 	jitlib_basic_concepts_03
	timing in node proxy 			jitlib_basic_concepts_04




Overview of the different classes and techniques:


• One way or style of access is the 'def' classes (Pdef, Ndef etc.)
	it binds a symbol to an object in a specific way:
	Pdef(\name) returns the proxy
	Pdef(\name, object) sets the source and returns the proxy.
	the rest of the behaviour depends on its use.
	
	client side: 	Pdef, Pdefn, Tdef, Pbindef, Psym, Pnsym, Fdef
	server side: 	Ndef
	
• Another way, for server side NodeProxies, is an environment that returns placeholders on demand:
	ProxySpace.push
	~out = { ...}
	helpfile: 		ProxySpace for the use together with other environments, see jitlib_basic_concepts_02
	
• There is also direct access without using the access schemes: NodeProxy, TaskProxy etc. provide it.
	internally the former use these as base classes.

	client side: 	PatternProxy, EventPatternProxy, TaskProxy, PbindProxy, Pdict
	server side: 	NodeProxy

• To record all textual changes, History is provides navigation and a memory of code.

• For playing back on multichannel systems, Monitor (used internally) has a playN method.
			
• GUI classes: 	overviews and mixers: ProxyMixer, TdefAllGui, PdefAllGui, NdefMixer
			(for separate use: TdefGui, PdefGui, MonitorGui, NdefGui, NdefParamGui)				



Tutorials:
			proxyspace_examples 	(a broad variety of inputs and uses)
			jitlib_efficiency			(optimising code)
			the_lazy_proxy			(how the initialisation works)
			jitlib_fading			(how crossfade of code works)
			jitlib_asCompileString	(storing and reproducing proxies)
			recursive_phrasing		(a specific use of Pdef)
			jitlib_asCompileString	(how to reproduce source code from objects)
			jitlib_networking		(how to collaborative live code with JITLib)
			basic_live_coding_techniques		(live coding without jitlib)


Networking:

• in remote and local networks thanks to sc-architecture node proxies can be used on any server, 
	as long as it notifies the client and has a correctly initialized default node.
	note that the client id should be set.

Internal classes / abstract classes:
			
			
			BusPlug		(listener on a bus)
			SkipJack		(a task that keeps awake across cmd-period)
			LazyEnvir		(and environment that returns proxies)
			EnvironmentRedirect (abstract superclass for redirecting environments)
			EnvGate		(singleton fade envelope)
			NodeProxy_roles (adverbial syntax for NodeProxy sources)







for suggestions / comments contact me
Julian Rohrhuber,  rohrhuber@uni-hamburg.de.

History and GUI classes are written by Alberto de Campo.

Thanks a lot for all the feedback and ideas!



_____________________________________________________________
The research for this project is funded by: German Research Foundation (DFG) 
and the Future Funds of Styria, Austria.

For Live Coding see: http://toplap.org






