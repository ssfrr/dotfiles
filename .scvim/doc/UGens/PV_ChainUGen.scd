PV_ChainUGen		UGens that alter FFT chains

"PV_ChainUGen" is an abstract class - in other words, a class that you do not use directly. Instead, use one of its subclasses. It represents phase-vocoder UGens - i.e. UGens which apply some kind of transformation to the frequency-domain signal produced by FFT.

(Strictly, this class encompasses all units whose output is an FFT chain. This is why FFT is in this group but IFFT is not - the IFFT unit outputs ordinary time-domain audio.)

For more info on using these units, see FFT Overview.

To see all classes which derive from the PV_ChainUGen class, run this line:
PV_ChainUGen.allSubclasses.do(_.postln)


