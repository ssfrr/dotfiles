Splay





*ar(inArray, spread,level, center,
levelComp)

*arFill(n, function, spread,level,
center, levelComp)









Splay spreads an array of channels across
the stereo field.

Optional spread and center controls, and
levelComp(ensation) (equal power).





(

x = { arg
spread=1, level=0.2, center=0.0;&nbsp;

 Splay.ar(

  SinOsc.ar(
{ |i| LFNoise2.kr(
rrand(10, 20), 200, 400) } ! 10),&nbsp;

  spread,&nbsp;

  level,&nbsp;

  center

 );

}.play;

)





x.set(\spread,
1, &nbsp; \center, 0);  //
full stereo

x.set(\spread,
0.5, \center, 0);  //
less wide

x.set(\spread,
0,&nbsp;  \center, 0);  //
mono center

x.set(\spread,
0.5, \center, 0.5);
// spread from center to right

x.set(\spread,
0, &nbsp; \center, -1); //
all left

x.set(\spread,
1, &nbsp; \center, 0);  //
full stereo













 // the
same example written with arFill:

(

x = { arg
spread=1, level=0.2, center=0.0;&nbsp;

 Splay.arFill(10,&nbsp;

  { |i| SinOsc.ar( LFNoise2.kr(
rrand(10, 20), 200, i + 3 * 100))&nbsp;
},&nbsp;

  spread,&nbsp;

  level,&nbsp;

  center

 );

}.play;

)





 //
with mouse control

(

x = { var src;&nbsp;

 src
= SinOsc.ar( { |i| LFNoise2.kr( rrand(10, 20), 200, i +
3 * 100) } ! 10);

 Splay.ar(src, MouseY.kr(1, 0), 0.2,
MouseX.kr(-1, 1));

}.play;

)



