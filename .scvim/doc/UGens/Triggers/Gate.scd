Gate				gate or hold

Gate.ar(in, gate)

Allows input signal value to pass when gate is positive, otherwise holds last value.

in - input signal.
gate - gate. The gate can be any signal. It will be treated as "on" when its value is greater than zero.

Server.internal.boot;
// Control rate so as not to whack your speakers with DC
{ Gate.kr(WhiteNoise.kr(1, 0), LFPulse.kr(1.333, 0.5))}.scope(zoom: 20);


