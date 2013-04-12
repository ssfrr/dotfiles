FOS		first order filter section

Inherits from: Object : AbstractFunction : UGen : Filter 

FOS.ar(in, a0, a1, b1, mul, add)
FOS.kr(in, a0, a1, b1, mul, add)


A standard first order filter section. Filter coefficients are given directly rather than calculated for you.
Formula is equivalent to:

out(i) = (a0 * in(i)) + (a1 * in(i-1)) + (b1 * out(i-1))

Examples:

(
// same as OnePole
{	var x;
	x = LFTri.ar(0.4, 0, 0.99);
	FOS.ar(LFSaw.ar(200, 0, 0.2), 1 - x.abs, 0.0, x)
}.play;
)

(
// same as OneZero
{	var x;
	x = LFTri.ar(0.4, 0, 0.99);
	FOS.ar(LFSaw.ar(200, 0, 0.2), 1 - x.abs, x, 0.0)
}.play;
)

(
// same as OnePole, kr
{	var x, ctl;
	x = LFTri.kr(0.2, 0, 0.99);
	ctl = FOS.kr(LFSaw.kr(8, 0, 0.2), 1 - x.abs, 0.0, x);
	LFTri.ar(ctl * 200 + 500);
}.play;
)


