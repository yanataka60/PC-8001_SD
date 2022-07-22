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


;8255 PORT �A�h���X FCH�`FFH
;0FCH PORTA ���M�f�[�^(����4�r�b�g)
;0FDH PORTB ��M�f�[�^(8�r�b�g)
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
;0FFH �R���g���[�����W�X�^


        ORG		6000H

		DB		041H,042H         ;�g��ROM�F���R�[�h

		CALL	INIT              ;POWER ON��8255���������ALOAD�ASAVE�AFILES�AKILL�̃W�����v���ݒ�
		RET

;*********** OPEN���Ă���t�@�C������1BYTE�ǂݏo���]�� ****************
;5F9EH��փ��[�`��
		JP		D_5F9E

;**** 8255������ ****
;PORTC����BIT��OUTPUT�A���BIT��INPUT�APORTB��INPUT�APORTA��OUTPUT
INIT:	LD		A,8AH
		OUT		(0FFH),A
;�o��BIT�����Z�b�g
		LD		A,00H             ;PORTA <- 0
		OUT		(0FCH),A
		OUT		(0FEH),A          ;PORTC <- 0

;LOAD�ASAVE�AFILES�AKILL�̃W�����v���ݒ�
		LD		HL,CMDLOAD
		LD		(TBLOAD),HL

		LD		HL,CMDSAVE
		LD		(TBSAVE),HL

		LD		HL,CMDFILES
		LD		(TBFILES),HL

		LD		HL,CMDKILL
		LD		(TBKILL),HL

		RET

;**** 1BYTE��M ****
;��MDATA��A���W�X�^�ɃZ�b�g���ă��^�[��
RCVBYTE:
		CALL	F1CHK             ;PORTC BIT7��1�ɂȂ�܂�LOOP
		IN		A,(0FDH)          ;PORTB -> A
		PUSH 	AF
		LD		A,05H
		OUT		(0FFH),A          ;PORTC BIT2 <- 1
		CALL	F2CHK             ;PORTC BIT7��0�ɂȂ�܂�LOOP
		LD		A,04H
		OUT		(0FFH),A          ;PORTC BIT2 <- 0
		POP 	AF
		RET
		
;**** 1BYTE���M ****
;A���W�X�^�̓��e��PORTA����4BIT��4BIT�����M
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

;**** 4BIT���M ****
;A���W�X�^����4�r�b�g�𑗐M����
SND4BIT:
		OUT		(0FCH),A
		LD		A,05H
		OUT		(0FFH),A          ;PORTC BIT2 <- 1
		CALL	F1CHK             ;PORTC BIT7��1�ɂȂ�܂�LOOP
		LD		A,04H
		OUT		(0FFH),A          ;PORTC BIT2 <- 0
		CALL	F2CHK
		RET
		
;**** BUSY��CHECK(1) ****
; 82H BIT7��1�ɂȂ�܂�LOP
F1CHK:	IN		A,(0FEH)
		AND		80H               ;PORTC BIT7 = 1?
		JR		Z,F1CHK
		RET

;**** BUSY��CHECK(0) ****
; 82H BIT7��0�ɂȂ�܂�LOOP
F2CHK:	IN		A,(0FEH)
		AND		80H               ;PORTC BIT7 = 0?
		JR		NZ,F2CHK
		RET

;************* ���MONITOR START *************************
MONINI:	LD		(MONHL),HL
		LD		(MONSP),SP
		
;		PUSH	HL                ;�^�C�g����\�������BASIC����߂����Ƃ��Ɏ������s���r�؂�Ă��܂����ߍ폜
;		LD		HL,MONMSG
;		CALL	MSGOUT
;		POP		HL
		
		LD		BC,MONERR         ;BASIC�ɖ߂�Ƃ�POP���Ă���̂ł��񑩂炵��
		PUSH	BC
CMD1:
		LD		A,'*'
		CALL	CONOUT            ;�v�����v�g�\��
		CALL	DSPCSR
		CALL	LINPUT            ;�X�N���[���G�f�B�b�g���g���������߂Ɏg�p�A���̂���CTRL+B�ł�BASIC�ɖ߂�Ȃ�
								  ;HL��IBUF-1�������Ė߂��Ă��� LD HL,IBUF-1
CMD2:
		JR		C,MONCTB          ;CTRL+B�̑�ցACTRL+C��BASIC�ɕ��A
		INC		HL
		LD		A,(HL)
		CP		'*'               ;���͎��ƃX�N���[���G�f�B�b�g����IBUF�ɓ���ʒu���ς�邽�߂̑Ώ��A�u*�v�Ȃ�|�C���^��i�߂�
		JR		Z,CMD2
		LD		A,(HL)
		CALL	AZLCNV            ;���͕�����啶���֕ϊ�
		CP		'B'
		JR		Z,MONCTB          ;CTRL+B�̑�ցAB�R�}���h�ł�BASIC�ɕ��A
		CP		'D'
		JP		Z,STMD            ;D�R�}���h
		CP		'S'
		JP		Z,STMW            ;S�R�}���h
		CP		'F'
		JP		Z,STLT            ;F�R�}���h
		CP		'L'
		JP		Z,MONLOAD         ;L�R�}���h
		CP		'W'
		JP		Z,MONSAVE         ;W�R�}���h
		CP		'G'
		JR		Z,GOCMD           ;G�R�}���h
		LD		A,0F4H
		CALL	SDERR             ;�R�}���h�G���[
		JR		CMD1
		
;MONMSG:	DEFB	0CH,'**PC-8001_SD Monitor **',0DH,0AH,00H

;************ B�R�}���h BASIC���A ***********************
MONCTB:	POP		BC
		LD		HL,(MONHL)
		EI
		RET

;************ G�R�}���h �A�h���Xxxxx�փW�����v ***************
GOCMD:	INC		HL
		CALL	STFN
		CALL	HLHEX             ;4����16�i���ł����HL�ɃZ�b�g���đ��s
		JP		C,MONERR
		JP		(HL)              ;HL�̎����A�h���X�ɃW�����v

;�p�����[�^�G���[����
MONERR:	LD		A,0F6H
		CALL	SDERR
		JP		CMD1

;************ D�R�}���h �A�h���Xxxxx�����MEMORY��DUMP **********************
STMD:	INC		HL
		CALL	STFN
		CALL	HLHEX             ;4����16�i���ł����SADRS�ɃZ�b�g���đ��s
		JP		C,MONERR
		LD		(SADRS),HL        ;SARDS�ۑ�

STMD6:	LD		HL,MSG_AD1        ;DUMP TITLE�\��
		CALL	MSGOUT
		LD		C,10H             ;16�s(128Byte)��\��
STMD7:	LD		HL,(SADRS)        ;�A�h���X�\��
		CALL	MONDHL
		CALL	MONSPC

		
		LD		B,08H             ;��s(8Byte)�̃f�[�^��16�i���\��
STMD0:	CALL	MONDME
		CALL	MONSPC
		CALL	KYSCAN
		CP		1BH               ;�\���r���ł�ESC�őł��؂�
		JR		Z,STMD4
		INC		HL
		DEC		B
		JR		NZ,STMD0

		LD		HL,(SADRS)
		LD		B,08H             ;��s(8Byte)�̃f�[�^���L�����N�^�\��
STMD2:	LD		A,(HL)
		CP		20H               ;���������ɑΏ� 20H�����Ȃ�20H�ɒu������
		JR		NC,STMD8
		LD		A,20H
STMD8:	CALL	CONOUT
		CALL	KYSCAN
		CP		1BH               ;�\���r���ł�ESC�őł��؂�
		JR		Z,STMD4
		INC		HL
		DEC		B
		JR		NZ,STMD2

		LD		(SADRS),HL
		CALL	MONCLF

		DEC		C
		JR		NZ,STMD7
		
		LD		HL,MSG_AD2        ;���͑҂����b�Z�[�W�\��
		CALL	MSGOUT
STMD3:	CALL	KYSCAN            ;1�������͑҂�
		CP		00H
		JR		Z,STMD3
		CP		1BH               ;ESC�őł��؂�
		JR		Z,STMD4
		CALL	AZLCNV
		CP		42H               ;B����BACK
		JR		NZ,STMD5
		LD		HL,(SADRS)
		LD		DE,0100H
		SBC		HL,DE
		LD		(SADRS),HL
STMD5:	JP		STMD6
STMD4:	JP		CMD1

;************ S�R�}���h �A�h���Xxxxx����MEMORY�ɏ������� **********************
STMW:	INC		HL
		CALL	STFN
		CALL	HLHEX             ;4����16�i���ł����HL�ɃZ�b�g���đ��s
		JP		C,MONERR

STSP1:	LD		A,(DE)
		CP		00H
		JR		Z,STMW9           ;�A�h���X�݂̂Ȃ�I��
		CP		20H
		JR		NZ,STMW1
		INC		DE                ;�󔒂͔�΂�
		JR		STSP1

STMW1:
		CALL	TWOHEX
		JR		C,STMW8
		LD		(HL),A            ;2����16�i���������(HL)�ɏ�������
		INC		HL

STSP2:	LD		A,(DE)
		CP		00H               ;��s�I��
		JR		Z,STMW8
		CP		20H
		JR		NZ,STMW1
		INC		DE                ;�󔒂͔�΂�
		JR		STSP2

STMW8:	PUSH	HL
		LD		HL,MSG_FDW        ;�s����'*S '
		CALL	MSGOUT
		POP		HL
		PUSH	HL
		CALL	MONDHL            ;�A�h���X�\��
		CALL	MONSPC
		CALL	LINPUT            ;�s���͌J��Ԃ�

		POP		DE
		INC		HL
		EX		DE,HL
		JR		STSP1
STMW9:	JP		CMD1

;************ F�R�}���h DIRLIST **********************
STLT:	INC		HL
		CALL	STFN              ;����������𑗐M
		EX		DE,HL
		LD		HL,DEFDIR         ;�s����'*L '��t���邱�ƂŃJ�[�\�����ړ��������^�[���Ŏ��s�ł���悤��
		LD		BC,DEND-DEFDIR
		CALL	DIRLIST           ;DIRLIST�{�̂��R�[��
		AND		A                 ;00�ȊO�Ȃ�ERROR
		CALL	NZ,SDERR
		JP		CMD1


;**** DIRLIST�{�� (HL=�s���ɕt�����镶����̐擪�A�h���X BC=�s���ɕt�����镶����̒���) ****
;****              �߂�l A=�G���[�R�[�h ****
DIRLIST:
		LD		A,83H             ;DIRLIST�R�}���h83H�𑗐M
		CALL	STCD              ;�R�}���h�R�[�h���M
		AND		A                 ;00�ȊO�Ȃ�ERROR
		JP		NZ,DLRET
		
		PUSH	BC
		LD		B,21H             ;�t�@�C���l�[������������33�������𑗐M
STLT1:	LD		A,(DE)
		CP		00H
		JR		NZ,STLT2
		LD		A,00H
STLT2:	CALL	AZLCNV            ;�啶���ɕϊ�
		CALL	SNDBYTE           ;�t�@�C���l�[������������𑗐M
		INC		DE
		DEC		B
		JR		NZ,STLT1
		POP		BC

		CALL	RCVBYTE           ;��Ԏ擾(00H=OK)
		AND		A                 ;00�ȊO�Ȃ�ERROR
		JP		NZ,DLRET

DL1:
		PUSH	HL
		PUSH	BC
		LD		DE,LBUF
		LDIR
		EX		DE,HL
DL2:	CALL	RCVBYTE           ;'00H'����M����܂ł���s�Ƃ���
		CP		00H
		JR		Z,DL3
		CP		0FFH              ;'0FFH'����M������I��
		JR		Z,DL4
		CP		0FEH              ;'0FEH'����M������ꎞ��~���Ĉꕶ�����͑҂�
		JR		Z,DL5
		LD		(HL),A
		INC		HL
		JR		DL2
DL3:	LD		(HL),00H
		LD		HL,LBUF           ;'00H'����M�������s����\�����ĉ��s
DL31:	LD		A,(HL)
		CP		00H
		JR		Z,DL33
		CALL	CHROUT
		INC		HL
		JR		DL31
DL33:	CALL	MONCLF
		POP		BC
		POP		HL
		JR		DL1
DL4:	CALL	RCVBYTE           ;��Ԏ擾(00H=OK)
		POP		BC
		POP		HL
		JR		DLRET

DL5:	PUSH	HL
		LD		HL,MSG_KEY1       ;HIT ANT KEY�\��
		CALL	MSGOUT
		LD		HL,(CUSPOS)
		CALL	CSRADR
		LD		A,1EH
		LD		(HL),A
		LD		A,1CH
		CALL	CONOUT
		LD		HL,MSG_KEY2       ;HIT ANT KEY�\��
		CALL	MSGOUT
		CALL	MONCLF
		POP		HL
DL6:	CALL	KYSCAN            ;1�������͑҂�
		CALL	AZLCNV
		CP		00H
		JR		Z,DL6
		CP		1BH               ;ESC�őł��؂�
		JR		Z,DL7
		CP		1EH               ;�J�[�\�����őł��؂�
		JR		Z,DL9
		CP		42H               ;�uB�v�őO�y�[�W
		JR		Z,DL8
		LD		A,00H             ;����ȊO�Ōp��
		JR		DL8
DL9:	LD		A,1EH
		CALL	CONOUT
		LD		A,1EH
		CALL	CONOUT            ;�J�[�\�����őł��؂����Ƃ��ɃJ�[�\��2�s���
DL7:	LD		A,0FFH            ;0FFH���f�R�[�h�𑗐M
DL8:	CALL	SNDBYTE
		JP		DL2
		
DLRET:	RET
		

;************ L�R�}���h .CMT LOAD *************************
MONLOAD:LD		A,71H            ;L�R�}���h71H�𑗐M
		CALL	STCMD
		JP		NZ,CMD1

		PUSH	HL
		LD		HL,0118H         ;1�����ځA24�s�ڂփJ�[�\�����ړ�
		CALL	CSR
		CALL	MONCLF
		POP		HL
		CALL	RCVBYTE          ;�w�b�_�[��M
		CP		3AH              ;3AH�ł���Α��s
		JR		Z,MCNLOAD
		LD		HL,MSG_F2        ;3AH�ȊO�Ȃ�G���[
		CALL	MSGOUT
		CALL	MONCLF
		JP		CMD1
		
MCNLOAD:LD		HL,MSG_LD        ;LOADING�\��
		CALL	MSGOUT

		LD		HL,SADRS+1       ;SADRS�擾
		CALL	RCVBYTE
		LD		(HL),A
		DEC		HL
		CALL	RCVBYTE
		LD		(HL),A
		CALL	RCVBYTE          ;�`�F�b�N�T���p��
		
		LD		HL,(SADRS)
MCLD1:	CALL	RCVBYTE          ;�w�b�_�[3AH��M�A�p��
		CALL	RCVBYTE          ;�f�[�^��
		CP		00H
		JR		Z,MCLD3          ;�f�[�^����0�Ȃ�I��
		LD		B,A
MCLD2:	CALL	RCVBYTE          ;���f�[�^��M
		LD		(HL),A
		INC		HL
		DJNZ	MCLD2
		CALL	RCVBYTE          ;�`�F�b�N�T���p��
		JR		MCLD1
MCLD3:	CALL	RCVBYTE          ;�`�F�b�N�T���p��
		LD		HL,MSG_OK        ;OK�\��
		CALL	MSGOUT
		JP		CMD1

;********** 5F9EH READ ONE BYTE FROM CMT�̑�� *********
D_5F9E:	LD		A,72H            ;�R�}���h72H�𑗐M
		CALL	STCD
		CALL	RCVBYTE          ;1Byte�̂ݎ�M
		RET

;**** �R�}���h�A�t�@�C�������M (IN:A �R�}���h�R�[�h HL:�t�@�C���l�[���̐擪)****
STCMD:	INC		HL
		CALL	STFN             ;�󔒏���
		PUSH	HL
		CALL	STCD             ;�R�}���h�R�[�h���M
		POP		HL
		AND		A                ;00�ȊO�Ȃ�ERROR
		JR		NZ,STCMD2
		CALL	STFS             ;�t�@�C���l�[�����M
		AND		A                ;00�ȊO�Ȃ�ERROR
		JP		NZ,STCMD2
		RET
STCMD2:	CALL	SDERR
SRCMD3:	RET

;************ W�R�}���h .CMT SAVE ********************************
MONSAVE:INC		HL
		CALL	STFN
		CALL	HLHEX            ;4����16�i���ł����SADRS�ɃZ�b�g���đ��s
		JP		C,MONERR
		LD		(SADRS),HL       ;SARDS�ۑ�
		EX		DE,HL

		CALL	STFN
		CALL	HLHEX            ;4����16�i���ł����EADRS�ɃZ�b�g���đ��s
		JP		C,MONERR
		LD		(EADRS),HL       ;EARDS�ۑ�

		PUSH	DE
		PUSH	HL
		LD		DE,(SADRS)
		SBC		HL,DE
		POP		HL
		POP		DE
		JP		C,MONERR         ;EADRS��SADRS��菬������΃G���[

		EX		DE,HL
		DEC		HL
		
		LD		A,70H            ;�R�}���h70H�𑗐M
		CALL	STCMD
		JP		NZ,CMD1

		LD		HL,MSG_WR        ;WRITING�\��
		CALL	MSGOUT

		LD		HL,(SADRS)       ;SADRS�𑗐M
		LD		A,L
		CALL	SNDBYTE
		LD		A,H
		CALL	SNDBYTE
		LD		DE,(EADRS)       ;���M����S�̃o�C�g�����Z�o���邽�߂�EADRS�𑗐M
		LD		A,E
		CALL	SNDBYTE
		LD		A,D
		CALL	SNDBYTE
MONSV1:	LD		A,(HL)           ;SADRS����EADRS�܂ł𑗐M
		CALL	SNDBYTE
		LD		A,H
		CP		D
		JR		NZ,MONSV2
		LD		A,L
		CP		E
		JR		Z,MONSV3         ;HL = DE �܂�LOOP
MONSV2:	INC		HL
		JR		MONSV1
MONSV3:	LD		HL,MSG_OK        ;OK�\��
		CALL	MSGOUT
		JP		CMD1

;**** �R�}���h���M (IN:A �R�}���h�R�[�h)****
STCD:	CALL	SNDBYTE          ;A���W�X�^�̃R�}���h�R�[�h�𑗐M
		CALL	RCVBYTE          ;��Ԏ擾(00H=OK)
		RET

;**** HL�����4Byte��16�i����\���A�X�L�[�R�[�h�ł����16�i���ɕϊ�����HL�ɑ�� **************
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

;**** HL�����2Byte��16�i����\���A�X�L�[�R�[�h�ł����16�i���ɕϊ�����A�ɑ�� **************
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

;****** FILE NAME���擾�ł���܂ŃX�y�[�X��ǂݔ�΂� (IN:HL �R�}���h�����̎��̕��� OUT:HL �t�@�C���l�[���̐擪)*********
STFN:	PUSH	AF
STFN1:	LD		A,(HL)
		CP		20H
		JR		NZ,STFN2
		INC		HL               ;�t�@�C���l�[���܂ŃX�y�[�X�ǂݔ�΂�
		JR		STFN1
STFN2:	POP		AF
		RET

STSV2:                           ;�t�@�C���l�[���̎擾�Ɏ��s
		LD		HL,MSG_FNAME
		JR		ERRMSG

;**** �t�@�C���l�[�����M(IN:HL �t�@�C���l�[���̐擪) ******
STFS:	LD		B,20H
STFS1:	LD		A,(HL)           ;FNAME���M
		CALL	SNDBYTE
		INC		HL
		DEC		B
		JR		NZ,STFS1
		LD		A,0DH
		CALL	SNDBYTE
		CALL	RCVBYTE          ;��Ԏ擾(00H=OK)
		RET

;************** �G���[���e�\�� *****************************
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
		LD		HL,MSG99         ;���̑�ERROR
ERRMSG:	CALL	MSGOUT
		CALL	MONCLF
		POP		AF
		RET

;************** BASIC CMT LOAD *********************
CMDLOAD:
		LD		A,73H            ;�R�}���h73H�𑗐M
		CALL	STCMD
		JR		NZ,CMDLD8

		LD		HL,0118H         ;1�����ځA24�s�ڂփJ�[�\�����ړ�
		CALL	CSR
		CALL	MONCLF
		
		CALL	RCVBYTE          ;�w�b�_�[��M
		CP		0D3H             ;D3H�łȂ���΃G���[
		JR		Z,CMDLD
		RET
		
CMDLD:	
		LD		HL,FILNAM        ;CMT�t�@�C�����ɋL�ڂ̃t�@�C���l�[��6��������M
		LD		B,06H
CMDLD2:	CALL	RCVBYTE
		LD		(HL),A
		INC		HL
		DJNZ	CMDLD2

		LD		HL,MSG_LD        ;LOADING�\��
		CALL	MSGOUT

		LD		HL,FILNAM        ;�t�@�C���l�[���\��
		LD		DE,IBUF
		LD		BC,0006H
		LDIR
		LD		A,00H
		LD		(DE),A
		LD		HL,IBUF
		CALL	MSGOUT
		CALL	MONCLF
		
		LD		HL,(BASSRT)      ;BASIC�v���O�����i�[�J�n�ʒu��HL�ɐݒ�

CMDLD3:	LD		B,0CH            ;00H��12�A���Ŏ�M����܂Ń��[�v
CMDLD4:	CALL	RCVBYTE
		LD		(HL),A
		INC		HL

		CP		00H
		JR		Z,CMDLD5
		JR		CMDLD3
CMDLD5:	DEC		B
		JR		Z,CMDLD6
		JR		CMDLD4

CMDLD6:	LD		BC,0007H         ;HL�̈ʒu��7�߂���BASIC�v���O�����I���ʒu�Ƃ���
		SBC		HL,BC
		
		JP		AFTLOAD          ;BASIC�v���O����LOAD�㏈��
CMDLD8:
		RET
		
;********************** BASIC CMT SAVE **********************
CMDSAVE:
		PUSH	HL
		LD		HL,(BASSRT)      ;BASIC�v���O�����i�[�J�n�ʒu��HL�ɐݒ�
		LD		A,(HL)
		INC		HL
		OR		(HL)
		POP		HL
		LD		A,0F5H           ;BASIC�v���O������1�s���Ȃ���΃G���[
		JP		Z,SDERR

		LD		A,74H            ;�R�}���h74H�𑗐M
		CALL	STCMD
		JR		NZ,CMDSV3

		LD		HL,MSG_WR        ;WRITING�\��
		CALL	MSGOUT

		CALL	RENUM9           ;BASIC�v���O����SAVE�O����
		LD		HL,(BASSRT)      ;BASSRT����VARBGN-1�܂ł𑗐M
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
		JR		Z,CMDSV3         ;HL = DE �܂�LOOP
CMDSV2:	INC		HL
		JR		CMDSV1
		
CMDSV3:
		LD		HL,MSG_OK        ;OK�\��
		CALL	MSGOUT
		RET

;************ BASIC FILES ********************
CMDFILES:
		PUSH	HL
		LD		HL,FMSG          ;FILES�̌��Ƀt�@�C���������������w�肷��ƍ\���G���[�ɂȂ邽�߁A�ʍs�Ƃ��ē���
		CALL	MSGOUT
		CALL	LINPUT
		INC		HL
		CALL	STFN             ;���͕�����擾
		EX		DE,HL
		LD		HL,DEFDIR2       ;�s����'LOAD '��t���邱�ƂŃJ�[�\�����ړ��������^�[���Ŏ��s�ł���悤��
		LD		BC,D2END-DEFDIR2
		CALL	DIRLIST          ;DIRLIST�{�̂��R�[��
		POP		HL
		RET
		
;************ BASIC KILL ***************************
CMDKILL:
		LD		A,75H            ;�R�}���h75H�𑗐M
		CALL	STCMD
		JR		NZ,CMDKL4        ;�t�@�C���������M�ł��Ȃ������B
		CALL	RCVBYTE
		JR		NZ,CMDKL3        ;�t�@�C�������݂��Ȃ�
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

;************* ���MONITOR�փW�����v���邽�߂̐ݒ� *************
		JP		MONINI
		DB		55H
		
		END
