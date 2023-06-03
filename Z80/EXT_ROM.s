;2022.7.24 FILESでSYNTAX ERRORとなる事象を回避、SERCH FILEと聞いてくる仕様を削除
;2022.7.25 FILESを↑キーで打ち切ったとき時々Syntax Errorが発生するため2行戻す動きを廃止
;2022.8.4  BASIC戻り時のSyntax Error対策を修正
;2022.8.14 MONITOR GコマンドでPOP BCが抜けていたので追加。
;          mk2用と統合
;            拡張ROM認識コードを041H,042H,00Hとした。
;            SHIFTキーを押しながら起動することで拡張ROMを有効にするか選択できるようにした。(mk2用)
;            mk2においてもfiles、save、killコマンドでSyntaxErrorが出ないように修正
;2022.8.21 MONITOR Lコマンドで読み込み時にファンクションキーエリアであればCTRL+B、CLOADをSD用に書き換えるようにした
;2023.5.30 MONHOTの扱い方を修正、MONERRを移動
;          LOAD中専用のスタックポインタとすることでCLEAR文でSPを変更していなくてもE800H以降に正常にLOAD出来るよう対処

CONOUT		EQU		0257H		;CRTへの1バイト出力
DISPBL		EQU		0350H		;ベルコードの出力
CSR			EQU		03A9H		;カーソルの移動
CSRADR		EQU		03F3H		;キャラクタ座標->VRAMアドレス変換
DSPCSR		EQU		0BE2H		;カーソル表示の開始
KYSCAN		EQU		0FACH		;リアルタイム・キーボード・スキャニング
LINPUT		EQU		1B7EH		;スクリーン・エディタ
AFTLOAD		EQU		1F8BH		;BASICテキストの終了アドレス設定
CHROUT		EQU		40A6H		;デバイスへの1バイト出力
MSGOUT		EQU		52EDH		;文字列の出力2
RENUM9		EQU		5B86H		;BASICプログラムSAVE前処理
MONBGN		EQU		5C3CH		;MONITOR開始アドレス
HEXCHK		EQU		5E39H		;16進コード・チェック
BINCV4		EQU		5E4BH		;16進コードからバイナリ形式への変換
MONBHX		EQU		5E83H		;8ビット数値から16進コードへの変換
MONDME		EQU		5EBDH		;16進データ2桁表示
MONDHL		EQU		5EC0H		;16進4桁表示
AZLCNV		EQU		5FC1H		;小文字->大文字変換
MONCLF		EQU		5FCAH		;CRコード及びLFコードの表示
MONSPC		EQU		5FD4H		;スペースの表示

CUSPOS		EQU		0EA63H		;カーソル位置
FKDEF		EQU		0EAC0H		;AUTO START キー定義場所初期値
BASSRT		EQU		0EB54H		;プログラムテキスト開始位置
IBUF		EQU		0EC96H		;キー入力バッファ
FKPINT		EQU		0EDC0H		;キーポインタ
FILNAM		EQU		0EF3EH		;現在ロード中ファイルネーム
VARBGN		EQU		0EFA0H		;変数領域の始まりアドレス
TBLOAD		EQU		0F139H		;LOADコマンドジャンプアドレス
TBKILL		EQU		0F142H		;KILLコマンドジャンプアドレス
TBSAVE		EQU		0F14BH		;SAVEコマンドジャンプアドレス
TBFILES		EQU		0F14EH		;FILESコマンドジャンプアドレス
MONHL		EQU		0FF34H
MONSP		EQU		0FF36H
SADRS		EQU		0FF3DH
EADRS		EQU		0FF3FH
ACFLGD		EQU		0FF40H      ;オートラン機能ダブルコーテーション検出フラグ
ACFLGC		EQU		0FF41H      ;オートラン機能CLOAD検出フラグ
LBUF		EQU		0FF66H

;PC-8001
PPI_A		EQU		0FCH
;PC-8001mk2
;PPI_A		EQU		07CH

PPI_B		EQU		PPI_A+1
PPI_C		EQU		PPI_A+2
PPI_R		EQU		PPI_A+3

;PC-8001
;8255 PORT アドレス FCH～FFH
;0FCH PORTA 送信データ(下位4ビット)
;0FDH PORTB 受信データ(8ビット)
;PC-8001mk2
;8255 PORT アドレス 7CH～7FH
;7CH PORTA 送信データ(下位4ビット)
;7DH PORTB 受信データ(8ビット)

;
;PC-8001
;0FEH PORTC Bit
;PC-8001mk2
;7EH PORTC Bit

;7 IN  CHK
;6 IN
;5 IN
;4 IN 
;3 OUT
;2 OUT FLG
;1 OUT
;0 OUT
;
;PC-8001
;0FFH コントロールレジスタ
;PC-8001mk2
;7FH コントロールレジスタ



        ORG		6000H

		DB		041H,042H         ;拡張ROM認識コード

		NOP
		JR		INIT              ;POWER ONで8255を初期化、LOAD、SAVE、FILES、KILLのジャンプ先を設定
		NOP
;PC-8001mk2の作法に統一
;		CALL	INIT              ;POWER ONで8255を初期化、LOAD、SAVE、FILES、KILLのジャンプ先を設定
;		RET

;*********** OPENしているファイルから1BYTE読み出し転送 ****************
;5F9EH代替ルーチン
		JP		D_5F9E

;*********** CMT LOAD 直呼び出し (EMI PLAYER用) *****************************
;5F3AH代替ルーチン
		JP		D_5F3A

;*********** MONITOR HOT START  (EMI PLAYER用) ********************
;5C66H代替ルーチン
		JP		MONHOT
		
;**** 8255初期化 ****
;PORTC下位BITをOUTPUT、上位BITをINPUT、PORTBをINPUT、PORTAをOUTPUT
INIT:	LD		A,8AH
		OUT		(PPI_R),A
;出力BITをリセット
		XOR		A                 ;PORTA <- 0
		OUT		(PPI_A),A
		OUT		(PPI_C),A         ;PORTC <- 0

;************** SHIFTキースキャン *****************
		IN		A,(08H)
		AND		40H
;************** Aキースキャン *********************
;		IN		A,(02H)
;		AND		02H
;キースキャンしてSHIFTキー(Aキー)が押されていなければ通常起動
;		RET		NZ

;キースキャンしてSHIFTキー(Aキー)が押されていなければ拡張ROM起動
		RET		Z

;LOAD、SAVE、FILES、KILLのジャンプ先を設定
INI2:	LD		HL,CMDLOAD
		LD		(TBLOAD),HL

		LD		HL,CMDSAVE
		LD		(TBSAVE),HL

		LD		HL,CMDFILES
		LD		(TBFILES),HL

		LD		HL,CMDKILL
		LD		(TBKILL),HL

INI3:	RET

;**** 1BYTE受信 ****
;受信DATAをAレジスタにセットしてリターン
RCVBYTE:
		CALL	F1CHK             ;PORTC BIT7が1になるまでLOOP
		IN		A,(PPI_B)         ;PORTB -> A
		PUSH 	AF
		LD		A,05H
		OUT		(PPI_R),A         ;PORTC BIT2 <- 1
		CALL	F2CHK             ;PORTC BIT7が0になるまでLOOP
		LD		A,04H
		OUT		(PPI_R),A         ;PORTC BIT2 <- 0
		POP 	AF
		RET
		
;**** 1BYTE送信 ****
;Aレジスタの内容をPORTA下位4BITに4BITずつ送信
SNDBYTE:
		PUSH	AF
		RRA
		RRA
		RRA
		RRA
		AND		0FH
		CALL	SND4BIT
		POP		AF
		AND		0FH
		CALL	SND4BIT
		RET

;**** 4BIT送信 ****
;Aレジスタ下位4ビットを送信する
SND4BIT:
		OUT		(PPI_A),A
		LD		A,05H
		OUT		(PPI_R),A          ;PORTC BIT2 <- 1
		CALL	F1CHK             ;PORTC BIT7が1になるまでLOOP
		LD		A,04H
		OUT		(PPI_R),A          ;PORTC BIT2 <- 0
		CALL	F2CHK
		RET
		
;**** BUSYをCHECK(1) ****
; 82H BIT7が1になるまでLOP
F1CHK:	IN		A,(PPI_C)
		AND		80H               ;PORTC BIT7 = 1?
		JR		Z,F1CHK
		RET

;**** BUSYをCHECK(0) ****
; 82H BIT7が0になるまでLOOP
F2CHK:	IN		A,(PPI_C)
		AND		80H               ;PORTC BIT7 = 0?
		JR		NZ,F2CHK
		RET

;************* 代替MONITOR START *************************
MONINI:	LD		(MONHL),HL
		LD		(MONSP),SP
		
;************ (TBLOAD)にCMDLOADがセットされていなければMONBGNへジャンプして通常MONITOR起動 ***************
		LD		HL,(TBLOAD)
		LD		DE,CMDLOAD
		SBC		HL,DE
		JP		NZ,MONBGN

;		PUSH	HL                ;タイトルを表示するとBASICから戻ったときに自動実行が途切れてしまうため削除
;		LD		HL,MONMSG
;		CALL	MSGOUT
;		POP		HL
		
CMD0:	LD		BC,MONERR         ;パラメータエラーをRET Cで戻りる先をセット
		PUSH	BC
CMD1:
		LD		A,'*'
		CALL	CONOUT            ;プロンプト表示
		CALL	DSPCSR
		CALL	LINPUT            ;スクリーンエディットを使いたいために使用、このためCTRL+BではBASICに戻れない
								  ;HLにIBUF-1が入って戻っている LD HL,IBUF-1
CMD2:
		JR		C,MONCTB          ;CTRL+Bの代替、CTRL+CでBASICに復帰
		INC		HL
		LD		A,(HL)
		CP		'*'               ;入力時とスクリーンエディット時でIBUFに入る位置が変わるための対処、「*」ならポインタを進める
		JR		Z,CMD2
		LD		A,(HL)
		CALL	AZLCNV            ;入力文字を大文字へ変換
		CP		'B'
		JR		Z,MONCTB          ;CTRL+Bの代替、BコマンドでもBASICに復帰
		CP		'D'
		JP		Z,STMD            ;Dコマンド
		CP		'S'
		JP		Z,STMW            ;Sコマンド
		CP		'F'
		JP		Z,STLT            ;Fコマンド
		CP		'L'
		JP		Z,MONLOAD         ;Lコマンド
		CP		'W'
		JP		Z,MONSAVE         ;Wコマンド
		CP		'G'
		JR		Z,GOCMD           ;Gコマンド
		LD		A,0F4H
		CALL	SDERR             ;コマンドエラー
		JR		CMD1
		
;MONMSG:	DEFB	0CH,'**PC-8001_SD Monitor **',0DH,0AH,00H

;************************* MONHOTの扱い方を修正、MONERRを移動 2023.5.30 ****************************
;パラメータエラー処理
MONERR:	LD		A,0F6H
		CALL	SDERR
;************************* MONHOTの扱い方を修正 2023.5.30 ****************************
;		JP		CMD1

;*********** MONITOR HOT START  (EMI PLAYER用)  *******************************
;5C66H代替ルーチン
MONHOT:
		LD		SP,(MONSP)        ;スタックポインタを復帰
		CALL	MONCLF
		JR		CMD0

;************ Bコマンド BASIC復帰 ***********************
MONCTB:
;***** 2022.8.10 BUG修正 ***********
		POP		BC                ;パラメータエラー戻り先を破棄
;***********************************
		LD		HL,(MONHL)
		EI
		RET

;************ Gコマンド アドレスxxxxへジャンプ ***************
GOCMD:	INC		HL
		CALL	STFN
		CALL	HLHEX             ;4桁の16進数であればHLにセットして続行
		RET		C
;		JP		C,MONERR
		CALL	MONCLF
		POP		BC
		JP		(HL)              ;HLの示すアドレスにジャンプ

;************ Dコマンド アドレスxxxxからのMEMORYをDUMP **********************
STMD:	INC		HL
		CALL	STFN
		CALL	HLHEX             ;4桁の16進数であればSADRSにセットして続行
		RET		C
;		JP		C,MONERR
		LD		(SADRS),HL        ;SARDS保存

STMD6:	LD		HL,MSG_AD1        ;DUMP TITLE表示
		CALL	MSGOUT
		LD		C,10H             ;16行(128Byte)を表示
STMD7:	LD		HL,(SADRS)        ;アドレス表示
		CALL	MONDHL
		CALL	MONSPC

		
		LD		B,08H             ;一行(8Byte)のデータを16進数表示
STMD0:	CALL	MONDME
		CALL	MONSPC
		CALL	KYSCAN
		CP		1BH               ;表示途中でもESCで打ち切り
		JR		Z,STMD4
		INC		HL
		DEC		B
		JR		NZ,STMD0

		LD		HL,(SADRS)
		LD		B,08H             ;一行(8Byte)のデータをキャラクタ表示
STMD2:	LD		A,(HL)
		CP		20H               ;文字化けに対処 20H未満なら20Hに置き換え
		JR		NC,STMD8
		LD		A,20H
STMD8:	CALL	CONOUT
		CALL	KYSCAN
		CP		1BH               ;表示途中でもESCで打ち切り
		JR		Z,STMD4
		INC		HL
		DEC		B
		JR		NZ,STMD2

		LD		(SADRS),HL
		CALL	MONCLF

		DEC		C
		JR		NZ,STMD7
		
		LD		HL,MSG_AD2        ;入力待ちメッセージ表示
		CALL	MSGOUT
STMD3:	CALL	KYSCAN            ;1文字入力待ち
		AND		A
		JR		Z,STMD3
		CP		1BH               ;ESCで打ち切り
		JR		Z,STMD4
		CALL	AZLCNV
		CP		42H               ;BからBACK
		JR		NZ,STMD5
		LD		HL,(SADRS)
		LD		DE,0100H
		SBC		HL,DE
		LD		(SADRS),HL
STMD5:	JP		STMD6
STMD4:
;************************* MONHOTの扱い方を修正 2023.5.30 ****************************
		JP		MONHOT
;		JP		CMD1

;************ Sコマンド アドレスxxxxからMEMORYに書き込み **********************
STMW:	INC		HL
		CALL	STFN
		CALL	HLHEX             ;4桁の16進数であればHLにセットして続行
		RET		C
;		JP		C,MONERR

STSP1:	LD		A,(DE)
		AND		A
		JR		Z,STMW9           ;アドレスのみなら終了
		CP		20H
		JR		NZ,STMW1
		INC		DE                ;空白は飛ばす
		JR		STSP1

STMW1:
		CALL	TWOHEX
		JR		C,STMW8
		LD		(HL),A            ;2桁の16進数があれば(HL)に書き込み
		INC		HL

STSP2:	LD		A,(DE)
		AND		A               ;一行終了
		JR		Z,STMW8
		CP		20H
		JR		NZ,STMW1
		INC		DE                ;空白は飛ばす
		JR		STSP2

STMW8:	PUSH	HL
		LD		HL,MSG_FDW        ;行頭に'*S '
		CALL	MSGOUT
		POP		HL
		PUSH	HL
		CALL	MONDHL            ;アドレス表示
		CALL	MONSPC
		CALL	LINPUT            ;行入力繰り返し

		POP		DE
		INC		HL
		EX		DE,HL
		JR		STSP1
STMW9:
;************************* MONHOTの扱い方を修正 2023.5.30 ****************************
		JP		MONHOT
;		JP		CMD1

;************ Fコマンド DIRLIST **********************
STLT:	INC		HL
		CALL	STFN              ;検索文字列を送信
		EX		DE,HL
		LD		HL,DEFDIR         ;行頭に'*L 'を付けることでカーソルを移動させリターンで実行できるように
		LD		BC,DEND-DEFDIR
		CALL	DIRLIST           ;DIRLIST本体をコール
		AND		A                 ;00以外ならERROR
		CALL	NZ,SDERR
;************************* MONHOTの扱い方を修正 2023.5.30 ****************************
		JP		MONHOT
;		JP		CMD1


;**** DIRLIST本体 (HL=行頭に付加する文字列の先頭アドレス BC=行頭に付加する文字列の長さ) ****
;****              戻り値 A=エラーコード ****
DIRLIST:
		LD		A,83H             ;DIRLISTコマンド83Hを送信
		CALL	STCD              ;コマンドコード送信
		AND		A                 ;00以外ならERROR
		JP		NZ,DLRET
		
		PUSH	BC
		LD		B,21H             ;ファイルネーム検索文字列33文字分を送信
STLT1:	LD		A,(DE)
		AND		A
		JR		NZ,STLT2
		XOR		A
STLT2:	CALL	AZLCNV            ;大文字に変換
		CP		22H               ;ダブルコーテーション読み飛ばし
		JR		NZ,STLT3
		INC		DE
		JR		STLT1
STLT3:	CALL	SNDBYTE           ;ファイルネーム検索文字列を送信
		INC		DE
		DEC		B
		JR		NZ,STLT1
		POP		BC

		CALL	RCVBYTE           ;状態取得(00H=OK)
		AND		A                 ;00以外ならERROR
		JP		NZ,DLRET

DL1:
		PUSH	HL
		PUSH	BC
		LD		DE,LBUF
		LDIR
		EX		DE,HL
DL2:	CALL	RCVBYTE           ;'00H'を受信するまでを一行とする
		AND		A
		JR		Z,DL3
		CP		0FFH              ;'0FFH'を受信したら終了
		JR		Z,DL4
		CP		0FEH              ;'0FEH'を受信したら一時停止して一文字入力待ち
		JR		Z,DL5
		LD		(HL),A
		INC		HL
		JR		DL2
DL3:	LD		(HL),00H
		LD		HL,LBUF           ;'00H'を受信したら一行分を表示して改行
DL31:	LD		A,(HL)
		AND		A
		JR		Z,DL33
		CALL	CHROUT
		INC		HL
		JR		DL31
DL33:	CALL	MONCLF
		POP		BC
		POP		HL
		JR		DL1
DL4:	CALL	RCVBYTE           ;状態取得(00H=OK)
		POP		BC
		POP		HL
		JR		DLRET

DL5:	PUSH	HL
		LD		HL,MSG_KEY1       ;HIT ANT KEY表示
		CALL	MSGOUT
		LD		HL,(CUSPOS)
		CALL	CSRADR
		LD		A,1EH
		LD		(HL),A
		LD		A,1CH
		CALL	CONOUT
		LD		HL,MSG_KEY2       ;HIT ANT KEY表示
		CALL	MSGOUT
		CALL	MONCLF
		POP		HL
DL6:	CALL	KYSCAN            ;1文字入力待ち
		CALL	AZLCNV
		AND		A
		JR		Z,DL6
		CP		1BH               ;ESCで打ち切り
		JR		Z,DL7
		CP		1EH               ;カーソル↑で打ち切り
		JR		Z,DL7
		CP		42H               ;「B」で前ページ
		JR		Z,DL8
		XOR		A                 ;それ以外で継続
		JR		DL8
;DL9:
;		LD		A,1EH             ;時々Syntax Errorが発生するため廃止
;		CALL	CONOUT
;		LD		A,1EH
;		CALL	CONOUT            ;カーソル↑で打ち切ったときにカーソル2行上へ
DL7:	LD		A,0FFH            ;0FFH中断コードを送信
DL8:	CALL	SNDBYTE
		JP		DL2
		
DLRET:	RET
		

;************ Lコマンド .CMT LOAD *************************
MONLOAD:LD		A,71H            ;Lコマンド71Hを送信
		CALL	STCMD
;************************* MONHOTの扱い方を修正 2023.5.30 ****************************
		JP		NZ,MONHOT
;		JP		NZ,CMD1

		PUSH	HL
; *********** オートラン書き換え用フラグクリア *** 2022.8.21 ********
		XOR		A
		LD		HL,ACFLGD
		LD		(HL),A
		INC		HL
		LD		(HL),A
; ********************************************************
		LD		HL,0118H         ;1文字目、24行目へカーソルを移動
		CALL	CSR
		CALL	MONCLF
		POP		HL
		CALL	RCVBYTE          ;ヘッダー受信
		CP		3AH              ;3AHであれば続行
		JR		Z,MCNLOAD
		LD		HL,MSG_F2        ;3AH以外ならエラー
		CALL	MSGOUT
		CALL	MONCLF
		CALL	DISPBL
;************************* MONHOTの扱い方を修正 2023.5.30 ****************************
		JP		MONHOT
;		JP		CMD1
		
MCNLOAD:LD		HL,MSG_LD        ;LOADING表示
		CALL	MSGOUT

; *********** LOAD中専用のスタックポインタとすることでCLEAR文でSPを変更していなくてもE800H以降に正常にLOAD出来るよう対処 2023.5.30 ********
		LD		SP,0FFFFH

		LD		HL,SADRS+1       ;SADRS取得
		CALL	RCVBYTE
		LD		(HL),A
		DEC		HL
		CALL	RCVBYTE
		LD		(HL),A
		CALL	RCVBYTE          ;チェックサム廃棄
		
		LD		HL,(SADRS)
MCLD1:	CALL	RCVBYTE          ;ヘッダー3AH受信、廃棄
		CALL	RCVBYTE          ;データ長
		AND		A
		JR		Z,MCLD3          ;データ長が0なら終了
		LD		B,A
MCLD2:	CALL	RCVBYTE          ;実データ受信
; ************* オートラン機能の読み替えを追加 ****** 2022.8.21 ************
;		LD		(HL),A
		CALL	AUTOCHK
;****************************************************************
		INC		HL
		DJNZ	MCLD2
		CALL	RCVBYTE          ;チェックサム廃棄
		JR		MCLD1
MCLD3:	CALL	RCVBYTE          ;チェックサム廃棄
		LD		HL,MSG_OK        ;OK表示
		CALL	MSGOUT
;************************* MONHOTの扱い方を修正 2023.5.30 ****************************
		JP		MONHOT           ;SPを復帰してコマンド待ちへ
;		JP		CMD1

; ************ ファンクションキーエリアへの書込みなら書き換え ** 2022.8.21 **
; HL : 書き込みアドレス
; A  : 書き込みデータ
; CTRL+B -> CTRL+C
; CLOAD  -> LOAD
; "xxxx" -> ""
AUTOCHK:PUSH	DE
		PUSH	BC
		EX		DE,HL
		LD		HL,1540H         ;-(EAC0H)
		ADD		HL,DE
		JP		NC,ACRET         ;EAC0H未満なら通常書込み
		LD		HL,14E4H         ;-(EB1BH+1)
		ADD		HL,DE
		JP		C,ACRET          ;EB1CH以上なら通常書込み
		CP		02H
		JR		NZ,ACHK1         ;CTRL+B -> CTRL+C
		LD		A,03H
		JP		ACRET            ;CRTL+Cに書き換えてリターン
		
ACHK1:	LD		B,A
		LD		HL,ACFLGD        ;ダブルコーテーションフラグをCHK
		LD		A,(HL)
		AND		A
		JR		Z,ACHK11         ;フラグOFFなら次のCHKへ
		LD		A,B
		CP		'"'              ;フラグONならダブルコーテーションかCHK
		JR		NZ,ACHK10        ;ダブルコーテーションではないなら書き込まずにリターン
		XOR		A                ;ダブルコーテーションならフラグをリセット
		LD		(HL),A
		JR		ACHK40           ;ダブルコーテーションを書き込んでリターン

ACHK10:	EX		DE,HL
		DEC		HL               ;フラグONでダブルコーテーションでないなら書き込まない。書き込みアドレスもINCしないでリターン
		JP		ACRET2

ACHK11:	LD		A,B
		CP		'"'              ;フラグOFFならダブルコーテーションかCHK
		JR		NZ,ACHK20        ;ダブルコーテーションでないなら次のCHKへ
		LD		A,01H            ;ダブルコーテーションならフラグON
		LD		(HL),A
		XOR		A
		INC		HL
		LD		(HL),A           ;CLOADフラグをリセット
		JR		ACHK40           ;ダブルコーテーションを書き込んでリターン

ACHK20:	LD		HL,ACFLGC        ;CLOADフラグをCHK
		LD		A,(HL)
		CP		00H              ;一致無し
		JR		Z,ACHK30
		CP		01H              ;'C'まで一致
		JR		Z,ACHK31
		CP		02H              ;'L'まで一致
		JR		Z,ACHK32
		CP		03H              ;'0'まで一致
		JR		Z,ACHK33
		LD		A,B              ;'A'まで一致
		CP		'D'
		JR		Z,ACHK39
		CP		'd'
		JR		NZ,ACHK40
ACHK39:	XOR		A                ;'CLOAD'が一致
		LD		(HL),A           ;CLOADフラグをリセット
		EX		DE,HL            ;書き込みポインタを4つ戻して'LOAD'に上書き
		DEC		HL
		DEC		HL
		DEC		HL
		DEC		HL
		LD		A,'L'
		LD		(HL),A
		INC		HL
		LD		A,'O'
		LD		(HL),A
		INC		HL
		LD		A,'A'
		LD		(HL),A
		INC		HL
		LD		A,'D'
		LD		(HL),A
		JR		ACRET2

ACHK30:	LD		A,B
		CP		'C'
		JR		Z,ACHK301
		CP		'c'
		JR		NZ,ACHK41
ACHK301:LD		A,01H            ;'C'が一致
		LD		(HL),A
		JR		ACHK40

ACHK31:	LD		A,B
		CP		'L'
		JR		Z,ACHK311
		CP		'l'
		JR		NZ,ACHK41
ACHK311:LD		A,02H            ;'L'が一致
		LD		(HL),A
		JR		ACHK40

ACHK32:	LD		A,B
		CP		'O'
		JR		Z,ACHK321
		CP		'o'
		JR		NZ,ACHK41
ACHK321:LD		A,03H            ;'O'が一致
		LD		(HL),A
		JR		ACHK40

ACHK33:	LD		A,B
		CP		'A'
		JR		Z,ACHK331
		CP		'a'
		JR		NZ,ACHK41
ACHK331:LD		A,04H            ;'A'が一致
		LD		(HL),A
		
ACHK40:	LD		A,B

ACRET:	EX		DE,HL
		LD		(HL),A           ;取り敢えず書き込み
ACRET2:	POP		BC
		POP		DE
		RET

ACHK41:	XOR		A                ;'CLOAD'と一致しなかったのでフラグをリセットして書き込み
		LD		(HL),A
		JR		ACHK40

;********** 5F9EH READ ONE BYTE FROM CMTの代替 *********
D_5F9E:	LD		A,72H            ;コマンド72Hを送信
		CALL	STCD
		CALL	RCVBYTE          ;1Byteのみ受信
		RET

;**** コマンド、ファイル名送信 (IN:A コマンドコード HL:ファイルネームの先頭)****
STCMD:	INC		HL
		CALL	STFN             ;空白除去
		PUSH	HL
		CALL	STCD             ;コマンドコード送信
		POP		HL
		AND		A                ;00以外ならERROR
		JP		NZ,SDERR
		CALL	STFS             ;ファイルネーム送信
		AND		A                ;00以外ならERROR
		JP		NZ,SDERR
		RET

;************ 5F3AH READ FROM TAPEの代替 (EMI PLAYER用)*******************
D_5F3A:
;************ 連続してAUTO STARTをするためにフラグポイント再設定 (正解なのかは自信なし)************
		LD		HL,FKDEF
		LD		(FKPINT),HL
;**************************************************************************************
		
;ファイル名指定なしとしてMONITOR Lコマンド実行 *********************
		LD		HL,DEFCR-1
		JP		MONLOAD

;************ Wコマンド .CMT SAVE ********************************
MONSAVE:INC		HL
		CALL	STFN
		CALL	HLHEX            ;4桁の16進数であればSADRSにセットして続行
		RET		C
;		JP		C,MONERR
		LD		(SADRS),HL       ;SARDS保存
		EX		DE,HL

		CALL	STFN
		CALL	HLHEX            ;4桁の16進数であればEADRSにセットして続行
		RET		C
;		JP		C,MONERR
		LD		(EADRS),HL       ;EARDS保存

		PUSH	DE
		PUSH	HL
		LD		DE,(SADRS)
		SBC		HL,DE
		POP		HL
		POP		DE
		RET		C
;		JP		C,MONERR         ;EADRSがSADRSより小さければエラー

		EX		DE,HL
		DEC		HL
		
		LD		A,70H            ;コマンド70Hを送信
		CALL	STCMD
;************************* MONHOTの扱い方を修正 2023.5.30 ****************************
		JP		NZ,MONHOT
;		JP		NZ,CMD1

		LD		HL,MSG_WR        ;WRITING表示
		CALL	MSGOUT

		LD		HL,(SADRS)       ;SADRSを送信
		LD		A,L
		CALL	SNDBYTE
		LD		A,H
		CALL	SNDBYTE
		LD		DE,(EADRS)       ;送信する全体バイト数を算出するためにEADRSを送信
		LD		A,E
		CALL	SNDBYTE
		LD		A,D
		CALL	SNDBYTE
MONSV1:	LD		A,(HL)           ;SADRSからEADRSまでを送信
		CALL	SNDBYTE
		LD		A,H
		CP		D
		JR		NZ,MONSV2
		LD		A,L
		CP		E
		JR		Z,MONSV3         ;HL = DE までLOOP
MONSV2:	INC		HL
		JR		MONSV1
MONSV3:	LD		HL,MSG_OK        ;OK表示
		CALL	MSGOUT
;************************* MONHOTの扱い方を修正 2023.5.30 ****************************
		JP		MONHOT
;		JP		CMD1

;**** コマンド送信 (IN:A コマンドコード)****
STCD:	CALL	SNDBYTE          ;Aレジスタのコマンドコードを送信
		CALL	RCVBYTE          ;状態取得(00H=OK)
		RET

;**** HLからの4Byteが16進数を表すアスキーコードであれば16進数に変換してHLに代入 **************
HLHEX:	EX		DE,HL
		LD		HL,0000H
		LD		B,04H
HLHEX1:	LD		A,(DE)
		INC		DE
		CALL	AZLCNV
		CALL	HEXCHK
		JP		C,HLHEX2
		CALL	BINCV4
		DJNZ	HLHEX1
		XOR		A
HLHEX2:	RET

;**** HLからの2Byteが16進数を表すアスキーコードであれば16進数に変換してAに代入 **************
TWOHEX:	PUSH	HL
		LD		HL,0000H
		LD		B,02H
TWHEX1:	LD		A,(DE)
		INC		DE
		CALL	AZLCNV
		CALL	HEXCHK
		JP		C,TWHEX2
		CALL	BINCV4
		DJNZ	TWHEX1
		XOR		A
		LD		A,L
TWHEX2:
		POP		HL
		RET

;****** FILE NAMEが取得できるまでスペース、ダブルコーテーションを読み飛ばし (IN:HL コマンド文字の次の文字 OUT:HL ファイルネームの先頭)*********
STFN:	PUSH	AF
STFN1:	LD		A,(HL)
		CP		20H
		JR		Z,STFN2
		CP		22H
		JR		NZ,STFN3
STFN2:	INC		HL               ;ファイルネームまでスペース読み飛ばし
		JR		STFN1
STFN3:	POP		AF
		RET

STSV2:                           ;ファイルネームの取得に失敗
		LD		HL,MSG_FNAME
		JR		ERRMSG

;**** ファイルネーム送信(IN:HL ファイルネームの先頭) ******
STFS:	LD		B,20H
STFS1:	LD		A,(HL)           ;FNAME送信
		CP		22H
		JR		NZ,STFS2
		INC		HL
		JR		STFS1
STFS2:	CALL	SNDBYTE
		INC		HL
		DEC		B
		JR		NZ,STFS1
		LD		A,0DH
		CALL	SNDBYTE
		CALL	RCVBYTE          ;状態取得(00H=OK)
		RET

;************** エラー内容表示 *****************************
SDERR:
		PUSH	AF
		CP		0F0H
		JR		NZ,ERR3
		LD		HL,MSG_F0        ;SD-CARD INITIALIZE ERROR
		JR		ERRMSG
ERR3:	CP		0F1H
		JR		NZ,ERR4
		LD		HL,MSG_F1        ;NOT FIND FILE
		JR		ERRMSG
ERR4:	CP		0F3H
		JR		NZ,ERR5
		LD		HL,MSG_F3        ;FILE EXIST
		JR		ERRMSG
ERR5:	CP		0F4H
		JR		NZ,ERR6
		LD		HL,MSG_CMD       ;COMMAND FAILED
		JR		ERRMSG
ERR6:	CP		0F6H
		JR		NZ,ERR99
		LD		HL,MSG_FNAME     ;PARAMETER FAILED
		JR		ERRMSG
ERR99:	CALL	MONBHX
		LD		A,D
		CALL	CONOUT
		LD		A,E
		CALL	CONOUT
		LD		HL,MSG99         ;その他ERROR
ERRMSG:	CALL	MSGOUT
		CALL	MONCLF
		CALL	DISPBL
		POP		AF
		RET

;************** BASIC CMT LOAD *********************
CMDLOAD:
		DEC		HL
		LD		A,73H            ;コマンド73Hを送信
		CALL	STCMD
		JP		NZ,RETBC

		LD		HL,0118H         ;1文字目、24行目へカーソルを移動
		CALL	CSR
		CALL	MONCLF
		
		CALL	RCVBYTE          ;ヘッダー受信
		CP		0D3H             ;D3Hでなければエラー
		JR		Z,CMDLD
		LD		HL,MSG_F6        ;NOT BASIC PROGRAM
		CALL	MSGOUT
		CALL	DISPBL
		JP		RETBC
		
CMDLD:	
		LD		HL,FILNAM        ;CMTファイル中に記載のファイルネーム6文字を受信
		LD		B,06H
CMDLD2:	CALL	RCVBYTE
		LD		(HL),A
		INC		HL
		DJNZ	CMDLD2

		LD		HL,MSG_LD        ;LOADING表示
		CALL	MSGOUT

		LD		HL,FILNAM        ;ファイルネーム表示
		LD		DE,IBUF
		LD		BC,0006H
		LDIR
		XOR		A
		LD		(DE),A
		LD		HL,IBUF
		CALL	MSGOUT
		CALL	MONCLF
		
		LD		HL,(BASSRT)      ;BASICプログラム格納開始位置をHLに設定

CMDLD3:	LD		B,0CH            ;00Hを12個連続で受信するまでループ
CMDLD4:	CALL	RCVBYTE
		LD		(HL),A
		INC		HL

		AND		A
		JR		Z,CMDLD5
		JR		CMDLD3
CMDLD5:	DEC		B
		JR		Z,CMDLD6
		JR		CMDLD4

CMDLD6:	LD		BC,0007H         ;HLの位置を7つ戻してBASICプログラム終了位置とする
		SBC		HL,BC
		
		JR		RETBC2           ;BASICプログラムLOAD後処理
		
;********************** BASIC CMT SAVE **********************
CMDSAVE:
		PUSH	HL
		LD		HL,(BASSRT)      ;BASICプログラム格納開始位置をHLに設定
		LD		A,(HL)
		INC		HL
		OR		(HL)
		POP		HL
		JP		Z,CMDSV5         ;BASICプログラムが1行もなければエラー

		DEC		HL
		LD		A,74H            ;コマンド74Hを送信
		CALL	STCMD
		JR		NZ,CMDSV4

		LD		HL,MSG_WR        ;WRITING表示
		CALL	MSGOUT

		CALL	RENUM9           ;BASICプログラムSAVE前処理
		LD		HL,(BASSRT)      ;BASSRTからVARBGN-1までを送信
		LD		A,L
		CALL	SNDBYTE
		LD		A,H
		CALL	SNDBYTE
		LD		DE,(VARBGN)
		DEC		DE
		LD		A,E
		CALL	SNDBYTE
		LD		A,D
		CALL	SNDBYTE
CMDSV1:	LD		A,(HL)
		CALL	SNDBYTE
		LD		A,H
		CP		D
		JR		NZ,CMDSV2
		LD		A,L
		CP		E
		JR		Z,CMDSV3         ;HL = DE までLOOP
CMDSV2:	INC		HL
		JR		CMDSV1
		
CMDSV3:
		LD		HL,MSG_OK        ;OK表示
		CALL	MSGOUT
;2022.8.4  SYNTAX ERROR回避
CMDSV4:	JR		RETBC

;2022.8.4  SYNTAX ERROR回避
CMDSV5:
		CALL	DISPBL
		LD		HL,MSG_F5        ;NO BASIC PROGRAM
		JR		RETBC3

;************ BASIC FILES ********************
CMDFILES:
;2022.7.24 SYNTAX ERROR回避により、廃止
;		PUSH	HL
;		LD		HL,FMSG          ;FILESの後ろにファイル名検索文字を指定すると構文エラーになるため、別行として入力
;		CALL	MSGOUT
;		CALL	LINPUT
;		INC		HL
		CALL	STFN             ;入力文字列取得
		EX		DE,HL
		LD		HL,DEFDIR2       ;行頭に'LOAD 'を付けることでカーソルを移動させリターンで実行できるように
		LD		BC,D2END-DEFDIR2
		CALL	DIRLIST          ;DIRLIST本体をコール
;2022.8.4  SYNTAX ERROR回避
		JR		RETBC
		
;************ BASIC KILL ***************************
CMDKILL:
		DEC		HL
		LD		A,75H            ;コマンド75Hを送信
		CALL	STCMD
		JR		NZ,RETBC         ;ファイル名が送信できなかった。
		CALL	RCVBYTE
		AND		A
		JP		NZ,CMDKL1         ;ファイルが存在しない
		LD		HL,MSG_KL
RETBC3:	CALL	MSGOUT
		CALL	MONCLF

;2022.8.4 SYNTAX ERROR回避 
;FILES SAVE KILLからBASICへ正しい戻り方が判らなかったため、LOAD後処理で戻ることとする。
RETBC:
		LD		HL,(VARBGN)
;LOAD後処理
RETBC2:
		JP		AFTLOAD          ;BASICプログラムLOAD後処理
		
;2022.8.4  SYNTAX ERROR回避
CMDKL1:
		CALL	DISPBL
		LD		HL,MSG_F1        ;NOT FIND FILE
		JR		RETBC3

MSG_LD:
		DB		'LOADING '
DEFCR:	DB		00H

MSG_OK:
		DB		'OK!'
		DB		0DH,0AH,00H

MSG_WR:
		DB		'WRITING '
		DB		00H

MSG_KL:
		DB		'FILE DELETED!'
		DB		00H

MSG_AD1:
		DB		'ADRS +0 +1 +2 +3 +4 +5 +6 +7 01234567'
		DB		0DH,0AH,00H
		
MSG_AD2:
		DB		'NEXT:ANY BACK:B BREAK:ESC'
		DB		0DH,0AH,00H
		
MSG_KEY1:
		DB		'NEXT:ANY BACK:B BREAK:'
		DB		00H
MSG_KEY2:
		DB		' OR ESC'
		DB		00H

MSG_FNAME:
		DB		'PARAMETAR FAILED!'
		DB		00H
		
MSG_CMD:
		DB		'COMMAND FAILED!',0DH,0AH
		DB		' B             : Return Basic',0DH,0AH
		DB		' D nnnn        : Memory Dump',0DH,0AH
		DB		' F x           : Find SD File',0DH,0AH
		DB		' G nnnn        : Exec Program',0DH,0AH
		DB		' L x           : Load From SD',0DH,0AH
		DB		' S nnnn nn..   : Memory Write',0DH,0AH
		DB		' W nnnn nnnn x : Save To SD'
		DB		00H
		
MSG_F0:
		DB		'SD-CARD INITIALIZE ERROR'
		DB		00H
		
MSG_F1:
		DB		'NOT FIND FILE'
		DB		00H
		
MSG_F2:
		DB		'NOT OBJECT FILE'
		DB		00H
		
MSG_F3:
		DB		'FILE EXIST'
		DB		00H
		
MSG_F5:
		DB		'NO PROGRAM!!'
		DB		00H
		
MSG_F6:
		DB		'NOT BASIC PROGRAM'
		DB		0DH,0AH,00H
		
MSG99:
		DB		' ERROR'
		DB		00H
		
MSG_FDW:	DB		'*S'
		DB		00H

DEFDIR:
		DB		'*L '
DEND:

DEFDIR2:
		DB		'LOAD ',22H
D2END:


		ORG		7FFCH

;************* 代替MONITORへジャンプするための設定 *************
		JP		MONINI
		DB		55H
		
		END
