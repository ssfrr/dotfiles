DebugNodeWatcher

Posts when these messages are received from the server:
n_go n_end n_off n_on


s = Server.default;
s.boot;

d = DebugNodeWatcher(s);
d.start;

y = Group.new;

y.free;

d.stop;


