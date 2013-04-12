This document is OSX (SCapp) specific in key commands, though the principles extend to all platforms. See the helpfile Shortcuts for key commands in other editors.


Synthesizing sound

To run (evaluate) one line of code, such as

{ SinOsc.ar([400, 401], 0, 0.1) * Saw.ar([11, 33], 1) * EnvGen.kr(Env.sine(10)) }.play

first make sure that the localhost server is booted. Then put the cursor anywhere on the line (shown above) and press <enter>. If you don't have an enter key, then you can use ctrl-Return, Ctrl-c, fn-Return( on Some Macs), or Shift-Return. The server will synthesize audio and text that looks something like

Synth("-613784702" : 1000)

will appear in the post window.

Press command-period (cmd-.) to stop synthesis.

////////////////////////////////////////////////////////////////////////////////////////////////////

To run more than one line of code, select all the lines and press <enter>.

To help with the selection process, examples with more than one line often are placed in enclosing parentheses. In such cases, select the text by clicking immediately to the right of the top parenthesis or to the left of the bottom parenthesis. Or, with the cursor to the right of the top parenthesis or the left of the bottom one, press cmd-shift-b.

Then press enter (to run the example).

(
{
	RLPF.ar(
		in: Saw.ar([100, 102], 0.15),
		freq: Lag.kr(LFNoise0.kr(4, 700, 1100), 0.1),
		rq: 0.05
	)
}.play
)

The server will synthesize audio and text that looks something like

Synth("-393573063" : 1000)

will appear in the post window.

Press command-period (cmd-.) to stop synthesis.

////////////////////////////////////////////////////////////////////////////////////////////////////

Scoping sound

To scope whatever it is you're synthesizing (create a graphical display of the waveform):

1. make sure the internal server is running (press its boot button)
2. press the default button on the internal server window.
3. evaluate your code as described above.

For example, run

{ SinOsc.ar([400, 401], 0, 0.5) * Saw.ar([11, 33], 0.5) }.play

4. then evaluate

s.scope(2)

which will produce a window with the title of "stethoscope."

As a shortcut to steps 2 through 4, send the scope message directly to the example.

{ SinOsc.ar([400, 401], 0, 0.5) * Saw.ar([11, 33], 0.5) }.scope(2)

Press cmd-. to stop sound synthesis.

////////////////////////////////////////////////////////////////////////////////////////////////////

Recording sound

The localhost and the internal server windows have buttons, on the far right, to activate recording. To record, choose the a default server. The button on the default server of your choice intially will say "prepare rec." Press it once and it will say record >. Press it again to start recording.

////////////////////////////////////////////////////////////////////////////////////////////////////

go to 3_Comments







