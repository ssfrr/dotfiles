Trig		timed trigger

Trig.ar(trig, dur)
Trig.kr(trig, dur)

When a nonpositive to positive transition occurs at the input, Trig outputs the level of the triggering input for the specified duration, otherwise it outputs zero.

trig - trigger. Trigger can be any signal. A trigger happens when the signal changes from non-positive to positive.
dur - duration of the trigger output. (Default 0.1)


{ Trig.ar(Dust.ar(1), 0.2) * FSinOsc.ar(800, 0, 0.5) }.play

{ Trig.ar(Dust.ar(4), 0.1) }.play

{ Trig.kr(Impulse.kr(4), MouseX.kr(0, 0.25)) * FSinOsc.ar(#[800, 808], 0, 0.5) }.play


