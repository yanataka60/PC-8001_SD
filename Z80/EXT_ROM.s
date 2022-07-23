CONOUT		EQU		0257H
CSR			EQU		03A9H
CSRADR		EQU		03F3H
DSPCSR		EQU		0BE2H
KYSCAN		EQU		0FACH
LINPUT		EQU		1B7EH
AFTLOAD		EQU		1F8BH
CHROUT		EQU		40A6H
MSGOUT		EQU		52EDH
RENUM9		EQU		5B86H
HEXCHK		EQU		5E39H
BINCV4		EQU		5E4BH
MONBHX		EQU		5E83H
MONDME		EQU		5EBDH
MONDHL		EQU		5EC0H
AZLCNV		EQU		5FC1H
MONCLF		EQU		5FCAH
MONSPC		EQU		5FD4H

CUSPOS		EQU		0EA63H
BASSRT		EQU		0EB54H
IBUF		EQU		0EC96H
FILNAM		EQU		0EF3EH
VARBGN		EQU		0EFA0H
TBLOAD		EQU		0F139H
TBKILL		EQU		0F142H
TBSAVE		EQU		0F14BH
TBFILES		EQU		0F14EH
MONHL		EQU		0FF34H
MONSP		EQU		0FF36H
SADRS		EQU		0FF3DH
EADRS		EQU		0FF41H
LBUF		EQU		0FF66H


;8255 PORT アドレス FCH～FFH
;0FCH PORTA 送信データ(下位4ビット)
;0FDH PORTB 受信データ(8ビット)
;
;0FEH PORTC Bit
;7 IN  CHK
;6 IN
;5 IN
;4 IN 
;3 OUT
;2 OUT FLG
;1 OUT
;0 OUT
;
;0FFH コントロールレジスタ


        ORG		6000H

		DB		041H,042H         ;拡張ROM認識コード

		CALL	INIT              ;POWER ONで8255を初期化、LOAD、SAVE、FILES、KILLのジャンプ先を設定
		RET

;*********** OPENしているファイルから1BYTE読み出し転送 ****************
;5F9EH代替ルーチン
		JP		D_5F9E

;**** 8255初期化 ****
;PORTC下位BITをOUTPUT、上位BITをINPUT、PORTBをINPUT、PORTAをOUTPUT
INIT:	LD		A,8AH
		OUT		(0FFH),A
;出力BITをリセット
		XOR		A                 ;PORTA <- 0
		OUT		(0FCH),A
		OUT		(0FEH),A          ;PORTC <- 0

;LOAD、SAVE、FILES、KILLのジャンプ先を設定
		LD		HL,CMDLOAD
		LD		(TBLOAD),HL

		LD		HL,CMDSAVE
		LD		(TBSAVE),HL

		LD		HL,CMDFILES
		LD		(TBFILES),HL

		LD		HL,CMDKILL
		LD		(TBKILL),HL

		RET

;**** 1BYTE受信 ****
;受信DATAをAレジスタにセットしてリターン
RCVBYTE:
		CALL	F1CHK             ;PORTC BIT7が1になるまでLOOP
		IN		A,(0FDH)          ;PORTB -> A
		PUSH 	AF
		LD		A,05H
		OUT		(0FFH),A          ;PORTC BIT2 <- 1
		CALL	F2CHK             ;PORTC BIT7が0になるまでLOOP
		LD		A,04H
		OUT		(0FFH),A          ;PORTC BIT2 <- 0
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
		OUT		(0FCH),A
		LD		A,05H
		OUT		(0FFH),A          ;PORTC BIT2 <- 1
		CALL	F1CHK             ;PORTC BIT7が1になるまでLOOP
		LD		A,04H
		OUT		(0FFH),A          ;PORTC BIT2 <- 0
		CALL	F2CHK
		RET
		
;**** BUSYをCHECK(1) ****
; 82H BIT7が1になるまでLOP
F1CHK:	IN		A,(0FEH)
		AND		80H               ;PORTC BIT7 = 1?
		JR		Z,F1CHK
		RET

;**** BUSYをCHECK(0) ****
; 82H BIT7が0になるまでLOOP
F2CHK:	IN		A,(0FEH)
		AND		80H               ;PORTC BIT7 = 0?
		JR		NZ,F2CHK
		RET

;************* 代替MONITOR START *************************
MONINI:	LD		(MONHL),HL
		LD		(MONSP),SP
		
;		PUSH	HL                ;タイトルを表示するとBASICから戻ったときに自動実行が途切れてしまうため削除
;		LD		HL,MONMSG
;		CALL	MSGOUT
;		POP		HL
		
		LD		BC,MONERR         ;BASICに戻るときPOPしているのでお約束らしい
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

;************ Bコマンド BASIC復帰 ***********************
MONCTB:	POP		BC
		LD		HL,(MONHL)
		EI
		RET

;************ Gコマンド アドレスxxxxへジャンプ ***************
GOCMD:	INC		HL
		CALL	STFN
		CALL	HLHEX             ;4桁の16進数であればHLにセットして続行
		JP		C,MONERR
		JP		(HL)              ;HLの示すアドレスにジャンプ

;パラメータエラー処理
MONERR:	LD		A,0F6H
		CALL	SDERR
		JP		CMD1

;************ Dコマンド アドレスxxxxからのMEMORYをDUMP **********************
STMD:	INC		HL
		CALL	STFN
		CALL	HLHEX             ;4桁の16進数であればSADRSにセットして続行
		JP		C,MONERR
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
STMD4:	JP		CMD1

;************ Sコマンド アドレスxxxxからMEMORYに書き込み **********************
STMW:	INC		HL
		CALL	STFN
		CALL	HLHEX             ;4桁の16進数であればHLにセットして続行
		JP		C,MONERR

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
STMW9:	JP		CMD1

;************ Fコマンド DIRLIST **********************
STLT:	INC		HL
		CALL	STFN              ;検索文字列を送信
		EX		DE,HL
		LD		HL,DEFDIR         ;行頭に'*L 'を付けることでカーソルを移動させリターンで実行できるように
		LD		BC,DEND-DEFDIR
		CALL	DIRLIST           ;DIRLIST本体をコール
		AND		A                 ;00以外ならERROR
		CALL	NZ,SDERR
		JP		CMD1


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
		CALL	SNDBYTE           ;ファイルネーム検索文字列を送信
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
		JR		Z,DL9
		CP		42H               ;「B」で前ページ
		JR		Z,DL8
		XOR		A                 ;それ以外で継続
		JR		DL8
DL9:	LD		A,1EH
		CALL	CONOUT
		LD		A,1EH
		CALL	CONOUT            ;カーソル↑で打ち切ったときにカーソル2行上へ
DL7:	LD		A,0FFH            ;0FFH中断コードを送信
DL8:	CALL	SNDBYTE
		JP		DL2
		
DLRET:	RET
		

;************ Lコマンド .CMT LOAD *************************
MONLOAD:LD		A,71H            ;Lコマンド71Hを送信
		CALL	STCMD
		JP		NZ,CMD1

		PUSH	HL
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
		JP		CMD1
		
MCNLOAD:LD		HL,MSG_LD        ;LOADING表示
		CALL	MSGOUT

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
		LD		(HL),A
		INC		HL
		DJNZ	MCLD2
		CALL	RCVBYTE          ;チェックサム廃棄
		JR		MCLD1
MCLD3:	CALL	RCVBYTE          ;チェックサム廃棄
		LD		HL,MSG_OK        ;OK表示
		CALL	MSGOUT
		JP		CMD1

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
		JR		NZ,STCMD2
		CALL	STFS             ;ファイルネーム送信
		AND		A                ;00以外ならERROR
		JP		NZ,STCMD2
		RET
STCMD2:	CALL	SDERR
SRCMD3:	RET

;************ Wコマンド .CMT SAVE ********************************
MONSAVE:INC		HL
		CALL	STFN
		CALL	HLHEX            ;4桁の16進数であればSADRSにセットして続行
		JP		C,MONERR
		LD		(SADRS),HL       ;SARDS保存
		EX		DE,HL

		CALL	STFN
		CALL	HLHEX            ;4桁の16進数であればEADRSにセットして続行
		JP		C,MONERR
		LD		(EADRS),HL       ;EARDS保存

		PUSH	DE
		PUSH	HL
		LD		DE,(SADRS)
		SBC		HL,DE
		POP		HL
		POP		DE
		JP		C,MONERR         ;EADRSがSADRSより小さければエラー

		EX		DE,HL
		DEC		HL
		
		LD		A,70H            ;コマンド70Hを送信
		CALL	STCMD
		JP		NZ,CMD1

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
		JP		CMD1

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

;****** FILE NAMEが取得できるまでスペースを読み飛ばし (IN:HL コマンド文字の次の文字 OUT:HL ファイルネームの先頭)*********
STFN:	PUSH	AF
STFN1:	LD		A,(HL)
		CP		20H
		JR		NZ,STFN2
		INC		HL               ;ファイルネームまでスペース読み飛ばし
		JR		STFN1
STFN2:	POP		AF
		RET

STSV2:                           ;ファイルネームの取得に失敗
		LD		HL,MSG_FNAME
		JR		ERRMSG

;**** ファイルネーム送信(IN:HL ファイルネームの先頭) ******
STFS:	LD		B,20H
STFS1:	LD		A,(HL)           ;FNAME送信
		CALL	SNDBYTE
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
ERR6:	CP		0F5H
		JR		NZ,ERR7
		LD		HL,MSG_F5        ;NO BASIC PROGRAM
		JR		ERRMSG
ERR7:	CP		0F6H
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
		POP		AF
		RET

;************** BASIC CMT LOAD *********************
CMDLOAD:
		LD		A,73H            ;コマンド73Hを送信
		CALL	STCMD
		JR		NZ,CMDLD8

		LD		HL,0118H         ;1文字目、24行目へカーソルを移動
		CALL	CSR
		CALL	MONCLF
		
		CALL	RCVBYTE          ;ヘッダー受信
		CP		0D3H             ;D3Hでなければエラー
		JR		Z,CMDLD
		LD		HL,MSG_F6        ;NOT BASIC PROGRAM
		CALL	MSGOUT
		CALL	MONCLF
		RET
		
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
		
		JP		AFTLOAD          ;BASICプログラムLOAD後処理
CMDLD8:
		RET
		
;********************** BASIC CMT SAVE **********************
CMDSAVE:
		PUSH	HL
		LD		HL,(BASSRT)      ;BASICプログラム格納開始位置をHLに設定
		LD		A,(HL)
		INC		HL
		OR		(HL)
		POP		HL
		LD		A,0F5H           ;BASICプログラムが1行もなければエラー
		JP		Z,SDERR

		LD		A,74H            ;コマンド74Hを送信
		CALL	STCMD
		JR		NZ,CMDSV3

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
		RET

;************ BASIC FILES ********************
CMDFILES:
		PUSH	HL
		LD		HL,FMSG          ;FILESの後ろにファイル名検索文字を指定すると構文エラーになるため、別行として入力
		CALL	MSGOUT
		CALL	LINPUT
		INC		HL
		CALL	STFN             ;入力文字列取得
		EX		DE,HL
		LD		HL,DEFDIR2       ;行頭に'LOAD 'を付けることでカーソルを移動させリターンで実行できるように
		LD		BC,D2END-DEFDIR2
		CALL	DIRLIST          ;DIRLIST本体をコール
		POP		HL
		RET
		
;************ BASIC KILL ***************************
CMDKILL:
		LD		A,75H            ;コマンド75Hを送信
		CALL	STCMD
		JR		NZ,CMDKL4        ;ファイル名が送信できなかった。
		CALL	RCVBYTE
		AND		A
		JR		NZ,CMDKL3        ;ファイルが存在しない
		LD		HL,MSG_KL
		CALL	MSGOUT
		JR		CMDKL4
CMDKL3:	CALL	SDERR
CMDKL4:
		RET
		
FMSG	DEFB	'FILE SEARCH:',00H

MSG_LD:
		DB		'LOADING '
		DB		00H

MSG_OK:
		DB		'OK!'
		DB		0DH,0AH,00H

MSG_WR:
		DB		'WRITING '
		DB		00H

MSG_KL:
		DB		'FILE DELETED!'
		DB		0DH,0AH,00H

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
		DB		00H
		
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
