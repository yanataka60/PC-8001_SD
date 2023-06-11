;************************** SD ACCESS関連サービスルーチンテスト *******************
ROPEN		EQU		600FH
R1BYTE		EQU		6006H
H_5F3A		EQU		6009H
WAOPEN		EQU		6012H
WNOPEN		EQU		601BH
W1BYTE		EQU		6018H
WCLOSE		EQU		601EH
D_5ED9		EQU		6015H
PRHEX		EQU		5EC5H		;16進データ2桁表示
MONSPC		EQU		5FD4H		;スペースの表示

			ORG		0A000H

			PUSH	HL
			PUSH	DE
			PUSH	BC
			PUSH	AF
;********* WNAMEのファイル名で新規にファイルを作成し、01H～FFHまで255Byteのデータを書き込む
			LD		HL,WNAME
			CALL	WNOPEN
			LD		B,0FFH
			LD		A,01H
LOP1:		CALL	W1BYTE
			INC		A
			DJNZ	LOP1
			CALL	WCLOSE

;********* WNAMEのファイル名のファイルを読み込み用として開き、255Byteのデータを読み込み、16進数として表示する。
			LD		HL,WNAME
			CALL	ROPEN
			LD		B,0FFH
LOP2:		CALL	R1BYTE
			CALL	PRHEX
			CALL	MONSPC
			DJNZ	LOP2

;********* WNAMEのファイル名でファイルを書き込み用に開き、FFH～01Hまで255Byteのデータを追加で書き込む
			LD		HL,WNAME
			CALL	WAOPEN
			LD		B,0FFH
			LD		A,0FFH
LOP3:		CALL	W1BYTE
			DEC		A
			DJNZ	LOP3
			CALL	WCLOSE
			
;********* WNAME2のファイル名で新規にファイルを作成し、A000H～A07AHまでもメモリデータを機械語フォーマットのファイルとして作成する
			LD		HL,WNAME2
			CALL	WNOPEN
			LD		HL,0A000H
			LD		DE,0A096H
			CALL	D_5ED9

;********* WNAME2のファイル名でファイルをオープンし、機械語フォーマットのファイルとしてロードして実行
			LD		HL,WNAME3
			CALL	ROPEN
			CALL	H_5F3A
			JP		0A100H

WNAME		DB		'SD_WRITE_READ_TEST.DAT',00H
WNAME2		DB		'SD_WRT_DIRECT_TEST.BIN.CMT',00H
WNAME3		DB		'SD_TEST2.BIN.CMT',00H
			END
