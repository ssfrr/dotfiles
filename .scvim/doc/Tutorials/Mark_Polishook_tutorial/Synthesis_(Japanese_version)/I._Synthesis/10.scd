10.

減算合成とフィルターの使用

減算合成の基本的な考え方はコーヒーをいれることに似ています。つまり、最終的に必要ない成分をフィルターを通じて取り除くということです。

////////////////////////////////////////////////////////////////////////////////////////////////////

次の様に.dumpClassSubtreeメッセージをFilterクラスに送ることで、SuperCollider 3のほとんど全てのフィルターのリストが得られます。

Filter.dumpClassSubtree;

これがそのリストです。

Filter
[
  DetectSilence
  Formlet
  Ringz
  SOS
  FOS
  Slew
  Median
  LPZ2
    [ BRZ2 BPZ2 HPZ2 ]
  Slope
  LPZ1
    [ HPZ1 ]
  MidEQ
  BPF
    [ BRF ]
  LPF
    [ HPF ]
  RLPF
    [ RHPF ]
  LeakDC
  Lag
    [ Ramp Lag3 Lag2 ]
  Decay2
  Decay
  Integrator
  TwoPole
    [ APF TwoZero ]
  OnePole
    [ OneZero ]
  Resonz
]

SuperColliderのヘルプ・システムでHelp/UGens/Filtersを調べることでもフィルターのヘルプ・ファイルをみることができます。ヘルプ・ファイルの全てにはそれぞれのフィルターがどのように動作するのかを示す素晴らしい例があります。

////////////////////////////////////////////////////////////////////////////////////////////////////

ヒント：次の様にObjectクラスに.dumpClassSubtreeメッセージを送ることで

Object.dumpClassSubtree;

SuperColliderのそれぞれの単独のクラスのリストが表示されます。

////////////////////////////////////////////////////////////////////////////////////////////////////

LPF（ローパス・フィルター）を使って入力ソースから高い周波数成分を減算します。

(
SynthDef("subtractive", {
	Out.ar(
		0,
		LPF.ar(
			Pulse.ar(440, 0.5, 0.1),	// フィルターをかけるソース
			Line.kr(8000, 660, 6)		// フィルターの周波数をLineでコントロールする
		)
	)
}).load(s);
)

Synth("subtractive")
		
////////////////////////////////////////////////////////////////////////////////////////////////////

RLFP（レゾナント・ローパス・フィルター）は、高い周波数成分を取り除き、フィルターの（カットオフ・ポイントの）周波数を強調するためによく使います。

(
SynthDef("passLowFreqs2", {
	Out.ar(
		0,
		RLPF.ar(
			Saw.ar([220, 221] + LFNoise0.kr(1, 100, 200), 0.2),
			[LFNoise0.kr(4, 600, 2400), LFNoise0.kr(3, 600, 2400)],
			0.1
		)
	)
}).load(s);
)

Synth("passLowFreqs2")

////////////////////////////////////////////////////////////////////////////////////////////////////

Rezonzはとても、とても、とても強力なフィルターです。特定の周波数帯域を強調する時に使います。

カットオフが非常にシャープなためにノイズをピッチに変えてしまいます。

(
SynthDef("noiseToPitch", { arg out = 0, mul = 1;
	Out.ar(
		out,
		Resonz.ar(
			WhiteNoise.ar(mul),
			LFNoise0.kr(4, 110, 660),
			[0.005, 0.005]
		)
	)
}).load(s);
)

(
// 左右のチャンネルをアクティブ化する
Synth("noiseToPitch", [\out, 0\mul, 1]);
Synth("noiseToPitch", [\out, 1, \mul, 1]);
)

////////////////////////////////////////////////////////////////////////////////////////////////////


