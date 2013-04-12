Balance2   stereo signal balancer





Balance2.ar(left, right, pos, level)





Equal power panning balances two channels;
by panning, you are favouring one or other channel in the mix, and the
other loses power. The middle pan position (pos=0.0) corresponds to the
original stereo mix; full left (pos of -1) is essentially just left
channel playing, full right (pos of 1) just the right. The output of
Balance2 remains a stereo signal. &nbsp;





left - channel 1 of input
stereo signal

right - channel 2 of
input stereo signal

pos - pan position, -1 is
left, +1 is right

level - a control rate
level input.













{Balance2.ar(LFSaw.ar(44),Pulse.ar(33),FSinOsc.kr(0.5), 0.1) }.play;









{var
source; source= SinOsc.ar([440,550]);
Balance2.ar(source[0],source[1],LFNoise0.kr(4),0.3) }.play;















