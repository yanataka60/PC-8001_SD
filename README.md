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

　　　注4)Arduino等に使われる5V電源に対応したMicroSD Card Adapterも正しく信号を繋げば使えます。

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
　基板の表側に取り付けます。なお、取付穴は外側から１列目と２列目を使います。
![Flat cable1](https://github.com/yanataka60/PC-8001_SD/blob/main/JPEG/fitting(2).jpg)

### 50Pカードエッジコネクタ(J3)を取り付ける場合
　基板の裏側に取り付けます。なお、取付穴は外側から１列目と３列目を使います。
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

　ファイル名は「.CMT」を除いて32文字まで、ただし半角カタカナ、及び一部の記号はArduinoが認識しないので使えません。パソコンでファイル名を付けるときはアルファベット、数字および空白でファイル名をつけてください。

## BASICコマンド
### FILES DOSファイル名[CR]

### LOAD DOSファイル名[CR]

### SAVE DOSファイル名[CR]

### KILL DOSファイル名[CR]

## MONITORコマンド
### L DOSファイル名[CR]
　DOSファイル名で指定したバイナリファイルをLOADして実行します。

　「.MZT」は省略可能です。

　LOAD実行可能範囲は0000h～F7FFhです。

例)

L TEST[CR]

### F[CR]
　SD-CARDルートディレクトリにあるファイルの一覧を表示します。20件表示したところで指示待ちになるので打ち切るならSHIFT+BREAK又は↑を入力すると打ち切られ、Bキーで前の20件に戻ります。それ以外のキーで次の20件を表示します。

　行頭に「*FD」を付加して表示してあるので実行したいファイルにカーソルキーを合わせて[CR]キーを押すだけでLOAD、実行が可能です。

　表示される順番は、登録順となりファイル名アルファベッド順などのソートした順で表示することはできません。

　LOAD実行可能範囲は0000h～F7FFhです。

### F x[CR]
ファイル名がxで始まるファイルの一覧を表示します。20件表示したところで指示待ちになるので打ち切るならSHIFT+BREAK又は↑を入力すると打ち切られ、Bキーで前の20件に戻ります。それ以外のキーで次の20件を表示します。

xはMZのキーボードから入力可能な32文字までの文字列です。(数字、記号、アルファベット)

　LOAD実行可能範囲は0000h～F7FFhです。


例)

F S[CR]

F SP[CR]

### D DOSファイル名[CR]

### S DOSファイル名[CR]

### W DOSファイル名[CR]

### G DOSファイル名[CR]

### B DOSファイル名[CR]

### CTRL+C DOSファイル名[CR]

** 参考 **

　S-OS SWORDでの運用に当たっては起動直後に「DV S:」としてデバイスを各SYSTEMデバイスとしてください。

　FUZZY BASICだけかもしれませんが共通フォーマットデバイスのままだとLOADコマンドでIBFファイル名の省略ができませんでした。

#### LOAD時の特殊コマンド
　「DOS FILE:」と表示して行入力待ちになったときに以下の特殊コマンドが使用可能です。

##### *FDL[CR]
##### *FDL x[CR]
　MONITORコマンド入力待ちからのFDL、FDL xと全く同等のファイル一覧機能が使えます。

　検索結果の行頭には「DOS FILE:」を付加して表示してあるのでLOADしたいファイルにカーソルキーを合わせて[CR]キーを押すだけでLOADが可能です。

　「*FDL」で検索、カーソルで選んで読み込もうとした場合に「DOS FILE:」に戻ってしまうアプリケーションがありますが、再度カーソルを合わせて[CR]すれば読み込めます。


### アプリケーションからのSAVE
　CMTの時と同様にアプリケーションの指定する入力方法、ルールでファイル名等を入力して保存してください。

　ただし、半角カタカナはArduinoが認識できないため、使用できません。アルファベット、数字および空白で指定してください。

　SAVE時は、入力したファイル名がIBFファイル名、DOSファイル名の両方に適用されます。

　DOSファイル名としての「.MZT」は自動的に付加されます。

例)BASIC MZ-1Z001では

○ SAVE "TEST"[CR]

## 操作上の注意
　「SD-CARD INITIALIZE ERROR」と表示されたときは、SD-CARDをいったん抜き再挿入したうえでArduinoをリセットしてください。

　SD-CARDにアクセスしていない時に電源が入ったままで SD-CARDを抜いた後、再挿入しSD-CARDにアクセスすると「SD-CARD INITIALIZE ERROR」となる場合があります。再挿入した場合にはSD-CARDにアクセスする前にArduinoを必ずリセットしてください。

　SD-CARDの抜き差しは電源を切った状態で行うほうがより確実です。

　SD-CARDへのセーブ時にDOSファイル名を指定せずに[CR]を押下してしまった場合、「.MZT」というDOSファイルが作成されてしまいます。この「.MZT」はアプリケーションからLOADする時にDOSファイル名を指定せずに[CR]を押下した場合に読み込まれることで不測の動作を起こす原因になるので作成された場合には削除しておく方が無難です。

　「.MZT」はWindowsパソコンからリネーム又は削除してください。

## New City Heroを読み込み実行するための対応
　PC-8001_SDは内藤 時浩さんが頒布されているNew City HeroをPC-8001実機で手軽に遊びたいが為に作ったといっても過言ではありません。

　しかし、New City Heroは機械語の多段ロード方式で２段目のプログラム内にCMTからの読み込みルーチンがありますので、そこにSDから読み込むためのパッチを当てる必要があります。

　New City HeroのCMT形式ファイルに次の手順をあてPC-8001_SD用のCMT形式ファイルを作り、SD-CARDに保存してください。

　　1　頒布していただいたCMTファイルをbugfire2009さんの「DumpListEditor」にDrag&Dropする

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

## 追記
2022.6.6

部品表中、ROMについて追記。

2022.6.7

DISK BASIC MZ-2Z002のSD対応を追加しました。

2022.6.20

q-Pascalコンパイラの対応を追加しました。

回路図にネットラベルを追加しました。
