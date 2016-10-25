EventStreamPlayer

superclass: PauseStream

An EventStreamPlayer is used by Event based Patterns.  
You do not explicitly create an EventStreamPlayers, they are created for you
when you call Pattern-play.

The EventStreamPlayer holds a stream which returns a series of Events, and a protoEvent. At each call to next, it copies the protoEvent, passes that to the stream, and calls play on the Event returned.

for more on EventStreamPlayer  see Streams-Patterns-Events4


EventStreamPlayer uses the same control methods and status notifications as Task.

play(argClock, doReset, quant)
argClock - (optional) Override the clock assigned in Task.new
doReset - If true, the task will start over from the beginning. Default is false (task will resume where it was when it was last stopped)
quant - see the Quant helpfile


start(argClock, quant) - Restart the task from the beginning.
resume(argClock, quant) - Resume the task where it left off.
pause - Stop playing now.
stop - Stop playing now. (Pause and stop have the same implementation.)
reset - Set the stream to restart from the beginning the next time it's played.


