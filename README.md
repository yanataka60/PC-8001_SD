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
　Z80フォルダ内のEXT_ROM.binをROMライター(TL866II Plus等)を使って2764又は28C64に書き込んでください。

## Arduinoプログラム
　Arduino IDEを使ってArduinoフォルダのPC-8001_SDフォルダ内PC-8001_SD.inoを書き込みます。

　SdFatライブラリを使用しているのでArduino IDEメニューのライブラリの管理からライブラリマネージャを立ち上げて「SdFat」をインストールしてください。

　「SdFat」で検索すれば見つかります。「SdFat」と「SdFat - Adafruit Fork」が見つかりますが「SdFat」のほうを使っています。

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

　ルートに置かれたCMT形式のファイルのみ認識できます。(CMT形式以外のファイル、フォルダも表示されますがLOAD実行の対象になりません)

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

### BASICコマンド
#### FILES[CR]
FILES[CR]とすると「FILSE SEARCH:」と聞いてくるので文字列を入力すればSD-CARDルートディレクトリにあるその文字列から始まるファイルの一覧を表示します。

文字列を入力せずに[CR]のみ入力するとSD-CARDルートディレクトリにあるファイルの一覧を表示します。

20件表示したところで指示待ちになるので打ち切るならSHIFT+BREAK又は↑を入力すると打ち切られ、Bキーで前の20件に戻ります。それ以外のキーで次の20件を表示します。

　行頭に「LOAD "」を付加して表示してあるので実行したいファイルにカーソルキーを合わせて[CR]キーを押すだけでLOAD可能です。

　表示される順番は、登録順となりファイル名アルファベッド順などのソートした順で表示することはできません。

##### 参考
　FILES 文字列[CR]としてしまった場合、文字列は無視されます。

　次に「FILSE SEARCH:」と聞いてくるので文字列を指定して[CR]としてください。

　なお、実行後に「Syntax error」と表示されますが、無視してかまいません。

#### LOAD "DOSファイル名"[CR]
指定したDOSフィル名のBASICプログラムをSD-CARDからLOADします。

ファイル名の前に"(ダブルコーテーション)は必須ですが、ファイル名の後ろに"(ダブルコーテーション)は有っても無くても構いません。

ファイル名の最後の「.CMT」も有っても無くても構いません。

#### LOAD ""[CR]（※多段ロードファイルの２段目以降のみ有効）
事前に読み込まれたDOSファイルが多段ロード用に複数のCMTファイルが連結されており、２段目以降がBASICプログラムであった時のみ有効に動作します。

#### SAVE "DOSファイル名"[CR]
指定したDOSフィル名でBASICプログラムをSD-CARDに上書きSAVEします。

ファイル名の省略は出来ません。

ファイル名の前に"(ダブルコーテーション)は必須ですが、ファイル名の後ろに"(ダブルコーテーション)は有っても無くても構いません。

ファイル名の最後の「.CMT」も有っても無くても構いません。

指定したDOSファイル名の最初の６文字がCMT形式の中に保存されるファイル名として使われます。

BASICプログラムであることを識別するために「.BAS」を付けることを推奨します。

　例)

　　SAVE "TEST" -> 「TEST.CMT」で保存される。

　　SAVE "TEST.BAS" -> 「TEST.BAS.CMT」で保存される。

##### 注)
　ファイル名の前に"(ダブルコーテーション)を付けずに実行すると最初の一文字目が欠けたファイル名で保存されてしまいます。

　例)

　　SAVE "TEST"[CR]

　　「EST.CMT」というDOSファイル名で保存される。

#### KILL DOSファイル名[CR]
指定したDOSフィル名がSD-CARDに存在すればSD-CARDから削除します。

ファイル名の最後に「.CMT」も指定してもしなくても構いません。

### MONITORコマンド
#### F[CR]又はF 文字列[CR]
文字列を入力せずにF[CR]のみ入力するとSD-CARDルートディレクトリにあるファイルの一覧を表示します。

文字列を付けて入力すればSD-CARDルートディレクトリにあるその文字列から始まるファイルの一覧を表示します。

20件表示したところで指示待ちになるので打ち切るならSHIFT+BREAK又は↑を入力すると打ち切られ、Bキーで前の20件に戻ります。それ以外のキーで次の20件を表示します。

　行頭に「*L 」を付加して表示してあるので実行したいファイルにカーソルキーを合わせて[CR]キーを押すだけでLOAD可能です。

　表示される順番は、登録順となりファイル名アルファベッド順などのソートした順で表示することはできません。

##### 例)
　　F[CR]

　　F S[CR]

　　F SP[CR]

#### L DOSファイル名[CR]
指定したDOSフィル名の機械語プログラムをSD-CARDからLOADします。

ファイル名の最後の「.CMT」は有っても無くても構いません。

#### L[CR]（※多段ロードファイルの２段目以降のみ有効）
事前に読み込まれたDOSファイルが多段ロード用に複数のCMTファイルが連結されており、２段目以降が機械語プログラムであった時のみ有効に動作します。

#### W 16進数4桁 16進数4桁 DOSファイル名[CR]
1番目の16進数4桁が表すアドレスから2番目の16進数4桁が表すアドレスまでを指定したDOSファイル名でSD-CARDに機械語として保存します。

ファイル名の最後に「.CMT」を指定してもしなくても構いません。

またWの後ろや各パラメータ間に空白が有っても無くても構いません。

機械語プログラムであることを識別するために「.BIN」等を付けることを推奨します。

　例)

　　W 0000 001F TEST -> 　　0000番地から001F番地までをDOSファイル名「TEST.CMT」で保存する。

　　W 0000 001F TEST.BIN -> 0000番地から001F番地までをDOSファイル名「TEST.CMT」で保存する。

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

正常に機能させるにはbugfire2009さんの「DumpListEditor」を使って適切に修正したオートラン機能ファイルを作成してください。

異なる点

　1　CTRL+BではMONITORからBASICへ復帰できません。CTRL+C又はB[CR]に置き換える必要があります。

　2　SD-CARDからのBASICプログラムをLOADするコマンドは「LOAD」でファイル名を指定する必要がありませんので「CLOAD"ファイル名"」を「LOAD""」とする必要があります。

例)サウンド付きRally-xの場合

![AutoRun1](https://github.com/yanataka60/PC-8001_SD/blob/main/JPEG/autorun(1).JPG)

　CTRL+BをCTRL+Cに修正

![AutoRun2](https://github.com/yanataka60/PC-8001_SD/blob/main/JPEG/autorun(2).JPG)


例)DeepScanの場合

![AutoRun3](https://github.com/yanataka60/PC-8001_SD/blob/main/JPEG/autorun(3).JPG)

　BASICプログラム中のClear文を確認して値を設定、CTRL+BをCTRL+Cに、CLOAD"DS"をLOAD""に修正

![AutoRun4](https://github.com/yanataka60/PC-8001_SD/blob/main/JPEG/autorun(4).JPG)

![AutoRun5](https://github.com/yanataka60/PC-8001_SD/blob/main/JPEG/autorun(5).JPG)


## 操作上の注意
　「SD-CARD INITIALIZE ERROR」と表示されたときは、SD-CARDが挿入されているか確認し、PC-8001本体をリセットしてください。Arduinoのみのリセットでは復旧しません。

　SD-CARDにアクセスしていない時に電源が入ったままで SD-CARDを抜いた後、再挿入しSD-CARDにアクセスすると「SD-CARD INITIALIZE ERROR」となる場合があります。再挿入した場合にはSD-CARDにアクセスする前にArduinoを必ずリセットしてください。

　SD-CARDの抜き差しは電源を切った状態で行うほうがより確実です。

## New City Heroを読み込み実行するための対応
　PC-8001_SDは内藤 時浩さんが頒布されているNew City HeroをPC-8001実機で手軽に遊びたいが為に作ったといっても過言ではありません。

　しかし、New City Heroは機械語の多段ロード方式で２段目のプログラム内にCMTからの読み込みルーチンがありますので、そこにSDから読み込むためのパッチを当てる必要があります。

　New City HeroのCMT形式ファイルに次の手順をあてPC-8001_SD用のCMT形式ファイルを作り、SD-CARDに保存してください。

　　1　頒布していただいたNew City HeroのCMTファイルをbugfire2009さんの「DumpListEditor」にDrag&Dropする

　　2　表示される3つのBINファイルをうち、2番目のBINファイルを「マシン語入力に送る」を押す

　　3 「CD F3 0B」を検索して「00 00 00」に修正(1箇所)

　　4 「9E 5F」を検索して「06 60」に修正(14箇所)

　　5　v1.1.1の場合、「9E 5F」の検索では13箇所しか見つからないので「CD 9E」で検索し、「9E」を「06」に次行最初の「5F」を「60」に修正(1箇所)

　　6　修正が終わったら「ファイル整理画面にPaste」を押す

　　7　ファイル整理画面に戻ったことを確認し、「cmt書出し」を押してPC-8001_SD対応済cmtファイルとして保存する

## 謝辞
　基板の作成に当たり以下のデータを使わせていただきました。ありがとうございました。

　Arduino Pro Mini

　　https://github.com/g200kg/kicad-lib-arduino

　AE-microSD-LLCNV

　　https://github.com/kuninet/PC-8001-SD-8kRAM

　New City Heroの修正点を公開することを快く承諾してくださった内藤 時浩様、ありがとうございました。

　NBASICのコマンド追加に当たっては、ちくらっぺさんのSD-DOSがとても参考になりました。ありがとうございました。

　　https://github.com/chiqlappe/SD-DOS
