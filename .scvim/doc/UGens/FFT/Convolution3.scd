Convolution3			real-time time-based convolver

Convolution3.ar(in, kernel, trigger, framesize, mul, add)
Convolution3.kr(in, kernel, trigger, framesize, mul, add)

Strict convolution with fixed kernel which can be updated using a trigger signal. The convolution is performed in the time domain, which is highly inefficient, and probably only useful for either very short kernel sizes, or for control rate signals. 

in - processing target
kernel - buffer index for the fixed kernel, may be modulated in combination with the trigger
trigger - update the kernel on a change from <=0 to >0
framesize - size of FFT frame, does not have to be a power of two.   


See Convolution2 and Convolution2L for more efficient convolution UGens.


