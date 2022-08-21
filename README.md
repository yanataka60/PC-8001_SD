# PC-8001にSD-CARDからCMT形式ファイルのロード、セーブ機能

![PC-8001_SD](https://github.com/yanataka60/PC-8001_SD/blob/main/JPEG/TITLE.jpg)

　PC-8001でSD-CARDからCMT形式ファイルのロード、セーブ機能を実現するものです。

　CMTからの読み込み実行に数分掛かっていたゲームも数十秒で実行できます。

　接続は、PC-8001本体後ろの拡張端子に接続しますが、50pフラットケーブルでの接続、50pカードエッジコネクタでの接続のどちらかを選択できます。

　なお、Arduino、ROMへ書き込むための機器が別途必要となります。

## 回路図
　KiCadフォルダ内のPC-8001_SD.pdfを参照してください。

[回路図](https://github.com/yanataka60/PC-8001_SD/blob/main/Kicad/PC-8001_SD.pdf)

![PC-8001_SD](https://github.com/yanataka60/PC-8001_SD/blob/main/Kicad/PC-8001_SD.jpg)

## 部品
|番号|品名|数量|備考|
| ------------ | ------------ | ------------ | ------------ |
|J1|2x25Pinコネクタ|1|秋月電子通商 PH-2x40RGなど(注1)|
|J2|Micro_SD_Card_Kit|1|秋月電子通商 AE-microSD-LLCNV (注2)(注4)|
|J3|50Pカードエッジコネクタ|1|せんごくネット通販 HRS CR22A-50D-2.54DSなど(注1)|
|U1|74LS04|1||
|U2 U3|74LS30|2||
|U4|8255|1||
|U5|2764/28C64相当品|1||
|U6|Arduino_Pro_Mini_5V|1|(注3)|
|C1-C5|積層セラミックコンデンサ 0.1uF|5||
|C6|電解コンデンサ 16v100uF|1||
|S1|3Pスライドスイッチ|1|秋月電子通商 SS12D01G4など|

　　　注1)J1又はJ3のどちらかを選択して取り付けてください。

　　　注2)秋月電子通商　AE-microSD-LLCNVのJ1ジャンパはショートしてください。

　　　注3)Arduino Pro MiniはA4、A5ピンも使っています。

　　　注4)Arduino等に使われる5V電源に対応したMicroSD Card Adapterも正しく信号を繋げば使えます。変換基板等繋ぎ方は適宜対応してください。

|AE-microSD-LLCNVピン番号|MicroSD Card Adapterピン番号|信号名|
| ---------------------- | -------------------------- | ---- |
|1|2|5V|
|4|1|GND|
|5|5|SCK|
|6|3|MISO|
|7|4|MOSI|
|8|6|CS|

![MicroSD Card Adapter](https://github.com/yanataka60/PC-8001_SD/blob/main/JPEG/MicroSD%20Card%20Adapter.JPG)

### その他必要なもの
　2x25Pinコネクタ(J1)を取り付けた場合には、本体との接続用ケーブルが必要となります。

　片側が2.54mmピッチ2x25Pinメスコネクタ、片側が2.54mmピッチ50pカードエッジコネクタのフラットケーブルを用意してください。

## ROMへの書込み
　Z80フォルダ内のEXT_ROM.binをROMライター(TL866II Plus等)を使って2764又は28C64に書き込みます。

## Arduinoプログラム
　Arduino IDEを使ってArduinoフォルダのPC-8001_SDフォルダ内PC-8001_SD.inoを書き込みます。

　SdFatライブラリを使用しているのでArduino IDEメニューのライブラリの管理からライブラリマネージャを立ち上げて「SdFat」をインストールしてください。

　「SdFat」で検索すれば見つかります。「SdFat」と「SdFat - Adafruit Fork」が見つかりますが「SdFat」のほうを使っています。

注)Arduinoを基板に直付けしている場合、Arduinoプログラムを書き込むときは、PC-8001本体とは接続を外し、74LS04を外したうえで書き込んでください。

## コネクタの取り付け
### 2x25Pinコネクタ(J1)を取り付ける場合
　取付穴は外側から１列目と２列目を使います。基板の表側に取り付けます。
![Flat cable1](https://github.com/yanataka60/PC-8001_SD/blob/main/JPEG/fitting(2).jpg)

### 50Pカードエッジコネクタ(J3)を取り付ける場合
　取付穴は外側から１列目と３列目を使います。基板の裏側に取り付けます。
![Flat cable2](https://github.com/yanataka60/PC-8001_SD/blob/main/JPEG/fitting(1).jpg)

## 接続
　PC-8001本体後ろの拡張端子に接続します。
### フラットケーブルによる接続
![Flat cable1](https://github.com/yanataka60/PC-8001_SD/blob/main/JPEG/PC-8001_SD(3).JPG)
![Flat cable2](https://github.com/yanataka60/PC-8001_SD/blob/main/JPEG/PC-8001_SD(5).JPG)

### カードエッジコネクタによる接続
![Card Edge Connector1](https://github.com/yanataka60/PC-8001_SD/blob/main/JPEG/PC-8001_SD(2).JPG)
![Card Edge Connector2](https://github.com/yanataka60/PC-8001_SD/blob/main/JPEG/PC-8001_SD(4).JPG)

## SD-CARD
　FAT16又はFAT32が認識できます。

　ルートに置かれた拡張子が「.CMT」のCMT形式ファイルのみ認識できます。(CMT形式以外のファイル、フォルダも表示されますがLOAD実行の対象になりません)

　CMT形式であれば複数のCMTファイルを一つのファイルとしてまとめてあっても認識します。

　例)

　　BASIC+機械語　　　　　　　　　　　　　->　LOAD "DOSファイル名"[CR]、MON[CR]、L[CR]

　　機械語+機械語　　　　　　　　　　　　->　MON[CR]、 L DOSファイル名[CR]、L[CR]

　　オートラン機能ファイル+BASIC　　　　　->　MON[CR]、L DOSファイル名[CR]（以下オートラン）

　　オートラン機能ファイル+BASIC+機械語　->　MON[CR]、L DOSファイル名[CR]（以下オートラン）

　　オートラン機能ファイル+機械語+機械語　->　MON[CR]、L DOSファイル名[CR]（以下オートラン）

　　など

　ファイル名は「.CMT」を除いて32文字まで、ただし半角カタカナ、及び一部の記号はArduinoが認識しないので使えません。パソコンでファイル名を付けるときはアルファベット、数字および空白でファイル名をつけてください。

## 使い方

PC-8001_SDを使いたくない時には、PC-8001_SDを外してしまうのが簡単ですが、SHIFTキーを押してまま電源ON又はRESETすると拡張ROMは無効となります。

### BASICコマンド
#### FILES[CR]又はFILES "文字列"[CR]
FILES[CR]とするとSD-CARDルートディレクトリにあるファイルの一覧を表示します。

FILES "文字列"[CR]とするとSD-CARDルートディレクトリにあるその文字列から始まるファイルの一覧を表示します。

20件表示したところで指示待ちになるので打ち切るならESC又は↑を入力すると打ち切られ、Bキーで前の16件に戻ります。それ以外のキーで次の16件を表示します。

　行頭に「LOAD "」を付加して表示してあるので実行したいファイルにカーソルキーを合わせて[CR]キーを押すだけでLOAD可能です。

　表示される順番は、登録順となりファイル名アルファベッド順などのソートした順で表示することはできません。

##### 参考
　FILES "文字列"[CR]とする場合、基本的にはダブルコーテーションが無くても機能しますが、数字で始まるファイル名の場合ダブルコーテーションが無いと検索できません。

　× FILES 3

　○ FILES "3"

#### LOAD "DOSファイル名"[CR]
指定したDOSフィル名のBASICプログラムをSD-CARDからLOADします。

ファイル名の前に"(ダブルコーテーション)は必須ですが、ファイル名の後ろに"(ダブルコーテーション)は有っても無くても構いません。

ファイル名の最後の「.CMT」も有っても無くても構いません。

　例)

　　LOAD "TEST" -> DOSファイル名「TEST.CMT」を読み込みます。

　　LOAD "TEST.BAS" -> DOSファイル名「TEST.BAS.CMT」を読み込みます。

　　LOAD "TEST.BAS.CMT" -> DOSファイル名「TEST.BAS.CMT」を読み込みます。

##### 参考
　基本的にはDOSファイル名をダブルコーテーションで括らなくても機能しますが、数字で始まるファイル名の場合ダブルコーテーションが無いとLOADできません。

　NOT FIND FILEと表示されます。

　× LOAD 3D MAZE

　○ LOAD "3D MAZE"

#### LOAD ""[CR]（※多段ロードファイルの２段目以降のみ有効）
直前に読み込まれたDOSファイルが多段ロード用に複数のCMTファイルが連結されており、２段目以降がBASICプログラムであった時のみ有効に動作し、BASICプログラムをSD-CARDからLOADします。

#### SAVE "DOSファイル名"[CR]
BASICプログラムを指定したDOSフィル名でSD-CARDに上書きSAVEします。

ファイル名の省略は出来ません。

ファイル名の前に"(ダブルコーテーション)は必須ですが、ファイル名の後ろに"(ダブルコーテーション)は有っても無くても構いません。

ファイル名の最後の「.CMT」も有っても無くても構いません。

指定したDOSファイル名の最初の６文字がCMT形式の中に保存されるファイル名として使われます。

BASICプログラムであることを識別するために「.BAS」を付けることを推奨します。

　例)

　　SAVE "TEST" -> 「TEST.CMT」で保存される。

　　SAVE "TEST.BAS" -> 「TEST.BAS.CMT」で保存される。

##### 参考
　基本的にはDOSファイル名をダブルコーテーションで括らなくても機能しますが、数字で始まるファイル名の場合ダブルコーテーションが無いとSAVEできません。

　SD-CARD INITIALIZE ERRORと表示されます。

#### KILL DOSファイル名[CR]
指定したDOSフィル名がSD-CARDに存在すればSD-CARDから削除します。

ファイル名の最後に「.CMT」も指定してもしなくても構いません。

##### 参考
　基本的にはDOSファイル名をダブルコーテーションで括らなくても機能しますが、数字で始まるファイル名の場合ダブルコーテーションが無いとKILLできません。

　NOT FIND FILEと表示されます。

　× KILL 3D MAZE

　○ KILL "3D MAZE"

### MONITORコマンド
#### F[CR]又はF 文字列[CR]
文字列を入力せずにF[CR]のみ入力するとSD-CARDルートディレクトリにあるファイルの一覧を表示します。

文字列を付けて入力すればSD-CARDルートディレクトリにあるその文字列から始まるファイルの一覧を表示します。

20件表示したところで指示待ちになるので打ち切るならESC又は↑を入力すると打ち切られ、Bキーで前の16件に戻ります。それ以外のキーで次の16件を表示します。

　行頭に「*L 」を付加して表示してあるので実行したいファイルにカーソルキーを合わせて[CR]キーを押すだけでLOAD可能です。

　表示される順番は、登録順となりファイル名アルファベッド順などのソートした順で表示することはできません。

##### 例)
　　F[CR]

　　F S[CR]

　　F SP[CR]

#### L DOSファイル名[CR]
指定したDOSフィル名の機械語プログラムをSD-CARDからLOADします。

ファイル名の最後の「.CMT」は有っても無くても構いません。

　例)

　　L TEST -> DOSファイル名「TEST.CMT」を読み込みます。

　　L TEST.BIN -> DOSファイル名「TEST.BIN.CMT」を読み込みます。

　　L TEST.BIN.CMT -> DOSファイル名「TEST.BIN.CMT」を読み込みます。

#### L[CR]（※多段ロードファイルの２段目以降のみ有効）
直前に読み込まれたDOSファイルが多段ロード用に複数のCMTファイルが連結されており、２段目以降が機械語プログラムであった時のみ有効に動作し、機械語プログラムをSD-CARDからLOADします。

#### W 16進数4桁 16進数4桁 DOSファイル名[CR]
1番目の16進数4桁が表すアドレスから2番目の16進数4桁が表すアドレスまでを指定したDOSファイル名でSD-CARDに機械語として上書き保存します。

ファイル名の最後に「.CMT」を指定してもしなくても構いません。

またWの後ろや各パラメータ間に空白が有っても無くても構いません。

機械語プログラムであることを識別するために「.BIN」等を付けることを推奨します。

　例)

　　W 0000 001F TEST -> 　　0000番地から001F番地までをDOSファイル名「TEST.CMT」で保存する。

　　W 0000 001F TEST.BIN -> 0000番地から001F番地までをDOSファイル名「TEST.BIN.CMT」で保存する。

#### G 16進数4桁[CR]
16進数4桁が表すアドレスにジャンプします。

Gの後ろに空白があっても無くても構いません。

#### B[CR]
BASICに復帰します。MONITORでのコマンド入力をスクリーンエディタにしたため、CTRL+Bが機能しないので代替コマンドです。

CTRL+Cと動作は同じです。

#### CTRL+C
BASICに復帰します。MONITORでのコマンド入力をスクリーンエディタにしたため、CTRL+Bが機能しないので代替コマンドです。

B[CR]と動作は同じです。

#### S 16進数4桁 {16進数2桁}の繰り返し[CR]
PC-8001のメモリに16進数4桁が表すアドレスから16進数2桁が表すデータを書き込みます。

[CR]で改行すると有効な16進数2桁データを書き込んだ後、次に書き込みとなるアドレスを表示しますので続きの16進数2桁のデータを入力して[CR]で改行します。

アドレス表示の次に16進数2桁のデータを入力せずに[CR]を押すと終了します。

Sの後ろ、アドレス、データの区切りに空白が有っても無くても構いません。

例)

以下の例はすべて同じ結果となります。

　SA0001122334455

　SA000 11 22 33 44 55

　S A000 1122334455

　S A0001122334455

　S A000 1122 3344 55

#### D 16進数4桁[CR]
16進数4桁が表すアドレスからPC-8001のメモリの内容を128Byteを一画面として表示します。

一画面表示したところで「NEXT:ANY BACK:B BREAK:ESC」と表示して指示待ちとなるのでBで前の128Byteを表示、ESCで中止、それ以外のキーで次の128Byteの表示となります。

一画面表示している途中でもESCでいつでも中止できます。

### ファンクションキーを利用したオートラン機能
ファンクションキーを利用したオートラン機能に対応していますが、一部オリジナルと異なる点があります。

そこでオートラン機能ファイルをロードする時にPC-8001_SDの仕様に自動変換する機能を付けました。(2022.8.21実装)

以下の修正点についてオートラン機能ファイルをロードする時に自動的に修正ロードされます。当然、修正してあっても機能します。

自動で修正される点

　1　CTRL+BではMONITORからBASICへ復帰できません。CTRL+Cに修正されます。

　2　SD-CARDからのBASICプログラムをLOADするコマンドは「LOAD」で、1本のCMTファイルとなっていればファイル名を指定する必要もありませんので「CLOAD"ファイル名"」は「LOAD""」に修正されます。

## 操作上の注意
　「SD-CARD INITIALIZE ERROR」と表示されたときは、SD-CARDが挿入されているか確認し、PC-8001本体をリセットしてください。Arduinoのみのリセットでは復旧しません。

　SD-CARDにアクセスしていない時に電源が入ったままで SD-CARDを抜いた後、再挿入しSD-CARDにアクセスすると「SD-CARD INITIALIZE ERROR」となる場合があります。再挿入した場合にはSD-CARDにアクセスする前にArduinoを必ずリセットしてください。

　SD-CARDの抜き差しは電源を切った状態で行うほうがより確実です。

## New City HeroをSDから読み込み実行するための修正
　PC-8001_SDは内藤 時浩さんが頒布されているNew City HeroをPC-8001実機で手軽に遊びたいが為に作ったといっても過言ではありません。

　New City Heroは機械語の多段ロード方式で２段目のプログラム内にCMTからの読み込みルーチンをコールしている箇所がありますので、そこをSDから読み込むためのコール先に修正する必要があります。

　New City HeroのCMT形式ファイルに次の手順で修正を行いPC-8001_SD用のCMT形式ファイルを作り、SD-CARDに保存してください。

　　1　頒布していただいたNew City HeroのCMTファイルをbugfire2009さんの「DumpListEditor」にDrag&Dropする

　　2　表示される3つのBINファイルをうち、2番目のBINファイルを「マシン語入力に送る」を押す

　　3 「CD F3 0B」を検索して「00 00 00」に修正(1箇所)

　　4 「9E 5F」を検索して「06 60」に修正(14箇所)

　　5　v1.1.1の場合、「9E 5F」の検索では13箇所しか見つからないので「CD 9E」で検索し、「9E」を「06」に次行最初の「5F」を「60」に修正(1箇所)

　　6　修正が終わったら「ファイル整理画面にPaste」を押す

　　7　ファイル整理画面に戻ったことを確認し、「cmt書出し」を押してPC-8001_SD対応済cmtファイルとして保存する

## DumpListEditor動画作成機で作られたCMTファイルへの対応

　DumpListEditor動画作成機で作られたCMTファイルのうち、「Chain(cmt出力時のみ)」をチェックして作られたプログラムはCMTルーチンをコールしますので修正が必要となります。

セミグラ作成機＆動画作成機

https://bugfire2009.ojaru.jp/semigra/

で紹介されているきらびぃさん作成の

「メガCD版シルフィードのデモをPC8001で再生してみたフル版(修正版)」

「PC8001でBad Apple全編をcmt化」

の二つがこの機能を使っていますのでPC-8001_SDで再生するにはパッチ当てが必要になります。

　なお、以下の方法でPATCHを当てると最後のシーンが無限ループします。最後のファイルにはPATCHを当てないでおけば止まるのですが、手軽にPATCHを当てられますのでご容赦ください。

### 「メガCD版シルフィードのデモをPC8001で再生してみたフル版(修正版)」修正手順
　1　CMTファイルを「DumpListEditor」にDrag&Dropする。

　2　「BASIC入力」タブをクリックして言語「Patch File」を選択する。

　3　表示されているPathc File Sampleをすべて削除し、次の2行に入れ替える。

/CD,3A,5F,30/=CD,09,60,18

/E6,04,20,09/=E6,04,18,09

　4　「ファイル整理画面にPaste」を押す。

　5　ファイル整理画面に「PATCH.patch」というファイルが追加される。ファイルの位置はどこにあっても可。

　6　「cmt書出し」を押してPC-8001_SD対応済cmtファイルとして保存する。

### 「PC8001でBad Apple全編をcmt化」修正手順

　基本的に「メガCD版シルフィードのデモをPC8001で再生してみたフル版(修正版)」の修正手順と同じです。

　ですが、「PC8001でBad Apple全編をcmt化」には「EA68-EAD4.BIN」が最初に一つしかありません。

　CMTでは問題なく動作しますが、PC-8001_SDではLOADだけで止まってしまいますので「EA68-EAD4.BIN」を「メガCD版シルフィードのデモをPC8001で再生してみたフル版(修正版)」のように一つ置きにコピー＆ペーストします。

　終わったら『2　「BASIC入力」タブをクリックして言語「Patch File」を選択する。』以降を行ってください。

## 謝辞
　基板の作成に当たり以下のデータを使わせていただきました。ありがとうございました。

　Arduino Pro Mini

　　https://github.com/g200kg/kicad-lib-arduino

　AE-microSD-LLCNV

　　https://github.com/kuninet/PC-8001-SD-8kRAM

　New City Heroの修正点を公開することを快く承諾してくださった内藤 時浩様、ありがとうございました。

　NBASICのコマンド追加に当たっては、ちくらっぺ様のSD-DOSがとても参考になりました。ありがとうございました。

　　https://github.com/chiqlappe/SD-DOS

　DumpListEditorの動画作成機で作成されたcmtファイルへの修正方法を公開することを快く承諾してくださったbugfire2009様、ありがとうございました。

## 追記
2022.7.23

　BASICから機械語ファイルをLOADしようとしたときのエラーメッセージを修正しました。

2022.7.24

　FILES 文字列[CR]としたときにSYNTAX ERRORとなる事象を修正しました。これにより「FILSE SEARCH:」と聞いてくる仕様は廃止。

2022.7.25

　FILESを↑キーで打ち切ったとき、時々Syntax Errorが発生するため2行戻す動きを廃止

　FILES及びFコマンドの説明中誤りがあったので修正

　　一回で表示される行数　誤)20行　正)16行

　　打ち切るキー　誤)SHIFT+BREAK　正)ESC

2022.7.27

　DOSファイル名での拡張子について曖昧な記述があったので修正しました。

2022.8.4

　Arduinoを基板に直付けしている場合、Arduinoプログラムを書き込むときの注意点を書き加えました。

　Kicadライブラリ設定を修正しました。

　BASICでSyntax Errorが表示される事象に対応するためEXT_ROMプログラムに修正を加えました。

2022.8.14

　EXTROM.BINを修正

　　MONITOR Gコマンドの処理でPOP BCが抜けていたので追加。

　　mk2用と統合

　　　拡張ROM認識コードを041H,042H,00Hとした。

　　　SHIFTキーを押しながら起動することで拡張ROMを有効にするか選択できるようにした。(mk2用)

　　　mk2においてもfiles、save、killコマンドでSyntaxErrorが出ないように修正

2022.8.18

　DumpListEditorの動画作成機機能で作成されたきらびぃさん作成の「メガCD版シルフィードのデモをPC8001で再生してみたフル版(修正版)」、「PC8001でBad Apple全編をcmt化」の修正方法を追加しました。

2022.8.21

　MONITOR Lコマンドで読み込み時にオートラン機能ファイルであればCTRL+B、CLOADをSD用に書き換えるようにした
