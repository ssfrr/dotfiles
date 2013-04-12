Filter		UGens that filter things

"Filter" is an abstract class - in other words, a class that you do not use directly. Instead, use one of its subclasses. Many common filters inherit from this abstract class, including LPF, HPF, MoogFF, Ringz, Integrator, Median, LeakDC... and many more.

To see all classes which derive from the Filter class, run this line:
Filter.allSubclasses.do(_.postln)

The Filter class also provides a simple way to visualise the frequency-wise effect of applying a filter:

Stethoscope.defaultServer.boot // boot the server that will be scoped
MoogFF.scopeResponse
HPF.scopeResponse
BRF.scopeResponse
Median.scopeResponse


