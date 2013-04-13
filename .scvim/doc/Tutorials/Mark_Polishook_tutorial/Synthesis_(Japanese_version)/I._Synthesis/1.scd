1.

シンセシスとスケジューリングは2つの独立したプロセスである

SuperColliderについてまず知らなければならないことは、それがクライアント／サーバー・モデルを使っているということです。このことが意味することは、私たちはSuperColliderの言語でシンセシスのプロセスを定義するプログラムを書のだくということです。私たちが書いたプログラムが正しい限りにおいては、サーバーは言われた通りのことをするでしょう。サーバーはオーディオを処理し、サウンドをシンセサイズします。
 
クライアント／サーバー・モデルによって、シンセシスの定義とシンセシスのスケジューリングを、2つのはっきり分かれた部分に簡単に分けることができます。シンセシスのスケジューリングからシンセシスの定義を分離することにはアドバンテージがあります。

例えば、シンセシスのプロセスを同時に実行する必要なく、MIDIや、ディスクへのサウンドファイルの読み書きをスケジューリングするのにSuperCollider 3を使うことができます。

スケジューリングからシンセシスを分離することは、コンピュータ・プログラムにおいてデータと関数を分離するというのにも似たパラダイムを作り出します。そうしたモデルによって、概念化したりプログラムを書くのが簡単になることがよくあります。

SuperCollider 3のクライアント／サーバー・アーキテクチャは、分散型のネットワーク化されたコンピューティングのモデルを作り出します。クライアント／サーバー・アーキテクチャによって、複数のコンピュータはネットワークのいたるところでコミュニケートして簡単に一緒に働くことができます。

ネットワーキングという考え方は、私のこの週末のレクチャーを通して何度も取り上げるテーマです。私の意見では、ローカル、リモート、そして離れたところとネットワークするためにコンピュータを使うということは、創造性と芸術性に新しいモデルを提供するものです。それは、メディアのアーティストであり科学者である私たちが、注意深く取り組まなければならないものです。

////////////////////////////////////////////////////////////////////////////////////////////////////

まとめると、SuperCollider 3はシンセシスのプロセスをクライアントで定義して、その定義をサーバーで動かすためのプログラムです。

////////////////////////////////////////////////////////////////////////////////////////////////////

////////////
// 例1
// define a simple synthesis process and schedule one synthesis event (on one machine)
// シンプルなシンセシスのプロセスを定義して、一つのシンセシスのイベントをスケジューリングする（一台のマシン上で）

// 第1に、サーバーを定義する
s = Server("thisMachine", NetAddr("localhost", 57110));	// "localhost"は"127.0.0.1"というIPと同義

// 第2に、シンセシスのエンジンを定義する
SynthDef("sine", { Out.ar(0, SinOsc.ar(440, 0, 0.2)) }).send(s);

// 第3に、シンセシスをスケジューリング（実行）する
s.sendMsg("s_new", "sine", 1000, 1, 0);


////////////////////////////////////////////////////////////////////////////////////////////////////

////////////
// 例2
// 例1と同じプロセスだが、ネットワークを通じて2台のコンピュータがコミュニケートするという点が異なる

リモート・ネットワークをセットアップするには、以下の様にする。

// 第1に、サーバーを定義する ... コンピュータはインターネット上の「どこか」にある
// この例は有効なIPアドレスを持つ2番目のコンピュータが無ければ動作しない ...
// 第2のコンピュータでは既にサーバーが起動して動作していなければならない ...
s = Server("thisMachine", NetAddr("... an ip number ...", 57110));

// 第2に、シンセシスのプロセスを定義する ... 前の例の二番目のステップと全く同じ
SynthDef("sine", { Out.ar(0, SinOsc.ar(440, 0, 0.2)) }).send(s);

// 第3に、シンセシスのプロセスをスケジュ−リングする .... 前の例の三番目のステップと全く同じ
s.sendMsg("s_new", "sine", 1000, 1, 0);


////////////////////////////////////////////////////////////////////////////////////////////////////

次のコードは、前の２つの例から持って来たものですが、唯一の違いはローカルとリモートのサーバーは異なるIPアドレスで、そのうちの１つはサーバー・オブジェクトのアーギュメントとして与えられているということです。

// ローカル・サーバー
s = Server("thisMachine", NetAddr("localhost", 57110));	 
SynthDef("sine", { Out.ar(0, SinOsc.ar(440, 0, 0.2)) }).send(s);
s.sendMsg("s_new", "sine", 1000, 1, 0);

vs.

// リモート・サーバー
s = Server("thisMachine", NetAddr("... an ip number ...", 57110));
// この行を評価する前にリモート・マシンでサーバーが起動している様にする
SynthDef("sine", { Out.ar(0, SinOsc.ar(440, 0, 0.2)) }).send(s);
s.sendMsg("s_new", "sine", 1000, 1, 0);

////////////////////////////////////////////////////////////////////////////////////////////////////

