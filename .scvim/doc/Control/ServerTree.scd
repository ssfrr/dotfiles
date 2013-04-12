ServerTree		register actions to be taken to initialise a basic tree of groups on the server	

Inherits from: Object : AbstractSystemAction : AbstractServerAction


The singleton ServerTree provides a place for registering functions and objects for 
events that should happen when a given server has booted and when all synths are freed.
This is to  initialise a basic tree of groups on the server.

See also: Server, ServerQuit, ServerBoot, CmdPeriod

See AbstractServerAction for usage.


