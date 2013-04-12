ChaosGen		UGens that cause chaos

"ChaosGen" is an abstract class - in other words, a class that you do not use directly. Instead, use one of its subclasses. Various things inherit from this abstract class, including HenonN, LinCongL, LatoocarfianL, GbmanL, CuspL, StandardL, and more.

These chaotic UGens generally each represent a deterministic set of equations, which can take different starting parameters. The equations define a system whose evolution over time is highly sensitive to initial conditions, and can exhibit highly intricate behaviour.

To learn more, start here: http://en.wikipedia.org/wiki/Chaos_theory

To see all classes which derive from the ChaosGen class, run this line:
ChaosGen.allSubclasses.do(_.postln)


