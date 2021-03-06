SCImageKernel
// very experimental :)

kernel class to use with SCImage. Currently this class represents the CoreImage CIKernel you can apply to a SCImage. The Kernel language is a subset of the OpenGL Shading Language.

more information about the Kernel Language can be found here :

http://developer.apple.com/documentation/GraphicsImaging/Reference/CIKernelLangRef/Introduction/chapter_1_section_1.html

and here:

http://developer.apple.com/documentation/GraphicsImaging/Reference/CIKernelLangRef/chapter_2_section_1.html#//apple_ref/doc/uid/TP40004397-CH206-TPXREF101


here is the translation table between Kernel language Objects and SuperCollider objects
--------------------------------------------------------------------------------------------------------------------------------------------------
 Kernel Language Object		|	SuperCollider Object
--------------------------------------------------------------------------------------------------------------------------------------------------
	sampler					|	SCImage
	__color					|	Color
	float						|	Number
	vec2, vec3, vec4			|	Array
	__table					| 	SCImage (basically the __table modifier just use Images as a data providers - LUT)


Class Methods
	
	*new( shader, values, bounds )
		creates a new SCImageKernel
		shader - optional. the shader code string. nil by default
		values - optional. the values that match the kernel proc function defined in the shader string. nil by default
		bounds - optional. not used for now. nil by default
		
Instance Methods
	
	shader
		get the shader string.
		
	shader_
		set the shader string.	

	values
		get the values array.
		
	values_
		set the values array.	the object indexes in the values Array must match the argument declaration order as defined in the main
		kernel vec4 routine. See examples for more info.
	
	isValid
		very basic verification to tell if all arguments of the shader are set.
	
	compile
		compile the SCImageKernel object (and cache it). 
		Note: when rendered the first time, the kernel object is always compiled first.
		If you plan to change the shader string after, you must explicitely compile it to make it effective.
	
/**** Kernels ****/
// very experimental
// COLOR INVERSION SHADER EXAMPLE
(
a = SCImage.new(Document.current.dir +/+ "vduck2.jpg"); // get the image
k = SCImageKernel.new;
k.shader_("

vec4	invertPixel(vec4 pix) {
	return vec4(1.0 - pix.r, 1.0 - pix.g, 1.0 - pix.b, pix.a);
}

kernel vec4 _invertColor(sampler source)
{
	vec4 pixel;
	pixel = sample(source, samplerCoord(source));
	unpremultiply(pixel);
	return unpremultiply(invertPixel(pixel));
}
");

// the argument order should be kept in the array
// here we need only the "sampler" argument wich should be as the translation table informs you a SCImage
// the signature of the Kernel function is normaly 'kernel vec4'
// you can of course add other functions in the shader
k.values_([a]);

k.isValid.postln; // is it ok
a.applyKernel(k);

w = a.plot(freeOnClose:true);
)


(
// ANOTHER APPLE KERNEL EXAMPLE - See CoreImage programming guide for original example
a = SCImage.new(Document.current.dir +/+ "vduck2.jpg"); // get the image
k = SCImageKernel.new;
k.shader_("
vec2 testVec(float x, float y)
{
	return vec2(x, y);
}

kernel vec4 testKernelFromApple( sampler src, __color color, float distance, float slope )
{
	vec4 	t;
	float	d;
	d = destCoord().y * slope + distance;
	t = unpremultiply(sample(src, samplerCoord(src)));
	t = (t - d*color) / (1.0-d);
	return premultiply(t);
}
");

// as stated in the Apple Example
// distance - min: 0.0 max: 1.0
// slope - min: -0.01 max: 0.01
k.values_(
	[
	a,		// arg 0: the SCImage
	Color.white,  // arg 1: color
	0.5, 		// arg 2: distance
	-0.002		// arg 3: slope
	]
);

a.applyKernel(k);

w = a.plot(freeOnClose:true);
)




(
// OK a Better Colorfull Kernel
a = SCImage.new(600@600); // get the image
k = SCImageKernel.new;

k.shader_(
// shader/kernel from toneburst.com
// Generates spherical and planar displacement maps for VBO-based 3D heightfield. 
// http://machinesdontcare.wordpress.com 
"
const float PI = 3.14159265359;
const float TWOPI = 6.28318530718;

kernel vec4 _heightMap(sampler image, vec3 scale)
{
	vec2 xyNorm = samplerCoord(image) / samplerSize(image);
	float u = xyNorm.x * PI;
	float v = xyNorm.y * TWOPI;
	vec3 spherical;
	spherical.r = cos(v) * sin(u);
	spherical.g = sin(v) * sin(u);
	spherical.b = cos(u);
	
	spherical.r = (spherical.r * 0.5 + 0.5) * scale.x;
	spherical.g = (spherical.g * 0.5 + 0.5) * scale.y;
	spherical.b = (spherical.b * 0.5 + 0.5) * scale.z;
	
	return vec4(spherical,1.0);
}
");

k.values_([a, [1.0, 1.0, 1.0]]);

// k.isValid; // is it ok
a.applyKernel(k);
//.flatten; // ensure a bitmap rep so the kernel is not applied at each rendering call - uncomment that and rescale the plot window to see the difference.

w = a.plot(freeOnClose:true);
)


