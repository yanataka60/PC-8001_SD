;2022.7.24 FILES��SYNTAX ERROR�ƂȂ鎖�ۂ�����ASERCH FILE�ƕ����Ă���d�l���폜
;2022.7.25 FILES�����L�[�őł��؂����Ƃ����XSyntax Error���������邽��2�s�߂�������p�~
;2022.8.4  BASIC�߂莞��Syntax Error�΍���C��
;2022.8.14 MONITOR G�R�}���h��POP BC�������Ă����̂Œǉ��B
;          mk2�p�Ɠ���
;            �g��ROM�F���R�[�h��041H,042H,00H�Ƃ����B
;            SHIFT�L�[�������Ȃ���N�����邱�ƂŊg��ROM��L���ɂ��邩�I���ł���悤�ɂ����B(mk2�p)
;            mk2�ɂ����Ă�files�Asave�Akill�R�}���h��SyntaxError���o�Ȃ��悤�ɏC��
;2022.8.21 MONITOR L�R�}���h�œǂݍ��ݎ��Ƀt�@���N�V�����L�[�G���A�ł����CTRL+B�ACLOAD��SD�p�ɏ���������悤�ɂ���
;2023.5.30 MONHOT�̈��������C���AMONERR���ړ�
;          LOAD����p�̃X�^�b�N�|�C���^�Ƃ��邱�Ƃ�CLEAR����SP��ύX���Ă��Ȃ��Ă�E800H�ȍ~�ɐ����LOAD�o����悤�Ώ�
;2023.6.10 SD�A�N�Z�X�T�[�r�X���[�`����ǉ��B5F3AH��փ��[�`�����������B
;          PC-8001_SD�̑��݃`�F�b�N�Ƃ���$6000����$41,$42,$00,$18,$1C,$00,$C3�܂ł��Œ�B
;2023.9.10 N-BASIC 1.0�𔻕ʂ���MON�ŏ�����

CONOUT		EQU		0257H		;CRT�ւ�1�o�C�g�o��
DISPBL		EQU		0350H		;�x���R�[�h�̏o��
CSR			EQU		03A9H		;�J�[�\���̈ړ�
CSRADR		EQU		03F3H		;�L�����N�^���W->VRAM�A�h���X�ϊ�
DSPCSR		EQU		0BE2H		;�J�[�\���\���̊J�n
KYSCAN		EQU		0FACH		;���A���^�C���E�L�[�{�[�h�E�X�L���j���O
BASVER		EQU		1850H		;N-BASIC Version����
LINPUT		EQU		1B7EH		;�X�N���[���E�G�f�B�^
AFTLOAD		EQU		1F8BH		;BASIC�e�L�X�g�̏I���A�h���X�ݒ�
CHROUT		EQU		40A6H		;�f�o�C�X�ւ�1�o�C�g�o��
MSGOUT		EQU		52EDH		;������̏o��2
RENUM9		EQU		5B86H		;BASIC�v���O����SAVE�O����
MONBGN		EQU		5C3CH		;MONITOR�J�n�A�h���X
HEXCHK		EQU		5E39H		;16�i�R�[�h�E�`�F�b�N
BINCV4		EQU		5E4BH		;16�i�R�[�h����o�C�i���`���ւ̕ϊ�
MONBHX		EQU		5E83H		;8�r�b�g���l����16�i�R�[�h�ւ̕ϊ�
MONDME		EQU		5EBDH		;16�i�f�[�^2���\��
MONDHL		EQU		5EC0H		;16�i4���\��
AZLCNV		EQU		5FC1H		;������->�啶���ϊ�
MONCLF		EQU		5FCAH		;CR�R�[�h�y��LF�R�[�h�̕\��
MONSPC		EQU		5FD4H		;�X�y�[�X�̕\��

CUSPOS		EQU		0EA63H		;�J�[�\���ʒu
FKDEF		EQU		0EAC0H		;AUTO START �L�[��`�ꏊ�����l
BASSRT		EQU		0EB54H		;�v���O�����e�L�X�g�J�n�ʒu
IBUF		EQU		0EC96H		;�L�[���̓o�b�t�@
FKPINT		EQU		0EDC0H		;�L�[�|�C���^
FILNAM		EQU		0EF3EH		;���݃��[�h���t�@�C���l�[��
VARBGN		EQU		0EFA0H		;�ϐ��̈�̎n�܂�A�h���X
TBLOAD		EQU		0F139H		;LOAD�R�}���h�W�����v�A�h���X
TBKILL		EQU		0F142H		;KILL�R�}���h�W�����v�A�h���X
TBSAVE		EQU		0F14BH		;SAVE�R�}���h�W�����v�A�h���X
TBFILES		EQU		0F14EH		;FILES�R�}���h�W�����v�A�h���X
MONHL		EQU		0FF34H
MONSP		EQU		0FF36H
SADRS		EQU		0FF3DH
EADRS		EQU		0FF3FH
ACFLGD		EQU		0FF40H      ;�I�[�g�����@�\�_�u���R�[�e�[�V�������o�t���O
ACFLGC		EQU		0FF41H      ;�I�[�g�����@�\CLOAD���o�t���O
LBUF		EQU		0FF66H

;PC-8001
PPI_A		EQU		0FCH
;PC-8001mk2
;PPI_A		EQU		07CH

PPI_B		EQU		PPI_A+1
PPI_C		EQU		PPI_A+2
PPI_R		EQU		PPI_A+3

;PC-8001
;8255 PORT �A�h���X FCH�`FFH
;0FCH PORTA ���M�f�[�^(����4�r�b�g)
;0FDH PORTB ��M�f�[�^(8�r�b�g)
;PC-8001mk2
;8255 PORT �A�h���X 7CH�`7FH
;7CH PORTA ���M�f�[�^(����4�r�b�g)
;7DH PORTB ��M�f�[�^(8�r�b�g)

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
;0FFH �R���g���[�����W�X�^
;PC-8001mk2
;7FH �R���g���[�����W�X�^



        ORG		6000H

		DB		041H,042H         ;�g��ROM�F���R�[�h

		NOP
		JR		INIT              ;POWER ON��8255���������ALOAD�ASAVE�AFILES�AKILL�̃W�����v���ݒ�
		NOP
;PC-8001mk2�̍�@�ɓ���
;		CALL	INIT              ;POWER ON��8255���������ALOAD�ASAVE�AFILES�AKILL�̃W�����v���ݒ�
;		RET

;*********** OPEN���Ă���t�@�C������1BYTE�ǂݏo���]�� ****************
;5F9EH��փ��[�`��
;A <- �ǂݏo���ꂽ�f�[�^
;     �ǂݍ��ݗp�Ƃ���OPEN���Ă���t�@�C������1BYTE�ǂݏo��
		JP		D_5F9E

;*********** CMT LOAD ���Ăяo�� (EMI PLAYER�p) *****************************
;5F3AH��փ��[�`��
;     �ǂݏo���I�[�v������Ă���t�@�C������@�B��t�H�[�}�b�g�ŕۑ�����Ă���@�B���ǂݏo���B
;     ����I�� CF=0�A�ُ�I�� CF=1
		JP		H_5F3A

;*********** MONITOR HOT START  (EMI PLAYER�p) ********************
;5C66H��փ��[�`��
		JP		MONHOT

;*********** SD READ OPEN *****************************
;HL <- DOS_FILENAME�擪�A�h���X
;      HL���W�X�^������DOS_FILENAME�œǂݍ��ݗp�t�@�C�����I�[�v��
;      DOS_FILENAME��32�����܂ŁA�Ō��00H�����邱�ƁB
;      �t���O���W�X�^�ȊO�̃��W�X�^�͕ω����Ȃ��B
;      ����I�� CF=0�A�ُ�I�� CF=1
		JP		ROPEN

;*********** SD WRITE APPEND OPEN ****************************
;HL <- DOS_FILENAME�擪�A�h���X
;      HL���W�X�^������DOS_FILENAME�Œǉ��������ݗp�Ƃ��ăt�@�C�����I�[�v��
;      DOS_FILENAME��32�����܂ŁA�Ō��00H�����邱�ƁB
;      �t���O���W�X�^�ȊO�̃��W�X�^�͕ω����Ȃ��B
;      ����I�� CF=0�A�ُ�I�� CF=1
		JP		WAOPEN

;*********** SD WRITE ���Ăяo�� 5ED9H��� ***************************
;HL <- �������݊J�n�A�h���X
;DE <- �������ݏI���A�h���X
;      �����ݗp�ŃI�[�v������Ă���t�@�C���ɏ������݊J�n�A�h���X����
;      �������ݏI���A�h���X�܂ł̃��������e���@�B��t�H�[�}�b�g�ŏ��o���A�N���[�Y����B
;      ����I�� CF=0�A�ُ�I�� CF=1
		JP		D_5ED9

;*********** SD WRITE 1BYTE 5F2FH��� ***************************
;A <- �������݃f�[�^
;     �����ݗp�ŃI�[�v������Ă���t�@�C����A���W�X�^�̃f�[�^��ǉ������݂���B
;     �t���O���W�X�^�ȊO�̃��W�X�^�͕ω����Ȃ��B
;     ����I�� CF=0�A�ُ�I�� CF=1
		JP		D_5F2F

;*********** SD WRITE NEW OPEN ****************************
;HL <- DOS_FILENAME�擪�A�h���X
;      HL���W�X�^������DOS_FILENAME�ŏ������ݗp�Ƃ��ĐV���Ƀt�@�C�����I�[�v���B
;      ������DOS_FILENAME�̃t�@�C��������ꍇ�͍폜�����̂��ɃI�[�v������B
;      DOS_FILENAME��32�����܂ŁA�Ō��00H�����邱�ƁB
;      �t���O���W�X�^�ȊO�̃��W�X�^�͕ω����Ȃ��B
;      ����I�� CF=0�A�ُ�I�� CF=1
		JP		WNOPEN

;*********** SD WRITE CLOSE ****************************
;      �����ݗp�t�@�C�����N���[�Y����B
;      �t���O���W�X�^�ȊO�̃��W�X�^�͕ω����Ȃ��B
;      ����I�� CF=0�A�ُ�I�� CF=1
		JP		WCLOSE

;**** 8255������ ****
;PORTC����BIT��OUTPUT�A���BIT��INPUT�APORTB��INPUT�APORTA��OUTPUT
INIT:	LD		A,8AH
		OUT		(PPI_R),A
;�o��BIT�����Z�b�g
		XOR		A                 ;PORTA <- 0
		OUT		(PPI_A),A
		OUT		(PPI_C),A         ;PORTC <- 0

;************** SHIFT�L�[�X�L���� *****************
		IN		A,(08H)
		AND		40H
;************** A�L�[�X�L���� *********************
;		IN		A,(02H)
;		AND		02H
;�L�[�X�L��������SHIFT�L�[(A�L�[)��������Ă��Ȃ���Βʏ�N��
;		RET		NZ

;�L�[�X�L��������SHIFT�L�[(A�L�[)��������Ă��Ȃ���Ίg��ROM�N��
		RET		Z

;LOAD�ASAVE�AFILES�AKILL�̃W�����v���ݒ�
INI2:	LD		HL,CMDLOAD
		LD		(TBLOAD),HL

		LD		HL,CMDSAVE
		LD		(TBSAVE),HL

		LD		HL,CMDFILES
		LD		(TBFILES),HL

		LD		HL,CMDKILL
		LD		(TBKILL),HL

INI3:	RET

;**** 1BYTE��M ****
;��MDATA��A���W�X�^�ɃZ�b�g���ă��^�[��
RCVBYTE:
		CALL	F1CHK             ;PORTC BIT7��1�ɂȂ�܂�LOOP
		IN		A,(PPI_B)         ;PORTB -> A
		PUSH 	AF
		LD		A,05H
		OUT		(PPI_R),A         ;PORTC BIT2 <- 1
		CALL	F2CHK             ;PORTC BIT7��0�ɂȂ�܂�LOOP
		LD		A,04H
		OUT		(PPI_R),A         ;PORTC BIT2 <- 0
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
		OUT		(PPI_A),A
		LD		A,05H
		OUT		(PPI_R),A          ;PORTC BIT2 <- 1
		CALL	F1CHK             ;PORTC BIT7��1�ɂȂ�܂�LOOP
		LD		A,04H
		OUT		(PPI_R),A          ;PORTC BIT2 <- 0
		CALL	F2CHK
		RET
		
;**** BUSY��CHECK(1) ****
; 82H BIT7��1�ɂȂ�܂�LOP
F1CHK:	IN		A,(PPI_C)
		AND		80H               ;PORTC BIT7 = 1?
		JR		Z,F1CHK
		RET

;**** BUSY��CHECK(0) ****
; 82H BIT7��0�ɂȂ�܂�LOOP
F2CHK:	IN		A,(PPI_C)
		AND		80H               ;PORTC BIT7 = 0?
		JR		NZ,F2CHK
		RET

;************* ���MONITOR START *************************
MONINI:	LD		(MONHL),HL
		LD		(MONSP),SP
		
;************* N-BASICV1.0���� ***************************
		LD		A,(BASVER)
		CP		30H
		JR		Z,VER0
;************ (TBLOAD)��CMDLOAD���Z�b�g����Ă��Ȃ����MONBGN�փW�����v���Ēʏ�MONITOR�N�� ***************
		LD		HL,(TBLOAD)
		LD		DE,CMDLOAD
		SBC		HL,DE
		JP		NZ,MONBGN
		JR		VER1

VER0:
;************ N-BASICV1.0�p SHIFT�L�[��������Ă��Ȃ����PC-8001_SD���g�p�\�ɐݒ�A������Ă����MONBGN�փW�����v���Ēʏ�MONITOR�N�� ***************
		CALL	INIT
		JP		Z,MONBGN

VER1:
;		PUSH	HL                ;�^�C�g����\�������BASIC����߂����Ƃ��Ɏ������s���r�؂�Ă��܂����ߍ폜
;		LD		HL,MONMSG
;		CALL	MSGOUT
;		POP		HL
		
CMD0:	LD		BC,MONERR         ;�p�����[�^�G���[��RET C�Ŗ߂�����Z�b�g
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

;************************* MONHOT�̈��������C���AMONERR���ړ� 2023.5.30 ****************************
;�p�����[�^�G���[����
MONERR:	LD		A,0F6H
		CALL	SDERR
;************************* MONHOT�̈��������C�� 2023.5.30 ****************************
;		JP		CMD1

;*********** MONITOR HOT START  (EMI PLAYER�p)  *******************************
;5C66H��փ��[�`��
MONHOT:
		LD		SP,(MONSP)        ;�X�^�b�N�|�C���^�𕜋A
		CALL	MONCLF
		JR		CMD0

;************ B�R�}���h BASIC���A ***********************
MONCTB:
;***** 2022.8.10 BUG�C�� ***********
		POP		BC                ;�p�����[�^�G���[�߂���j��
;***********************************
		LD		HL,(MONHL)
		EI
		RET

;************ G�R�}���h �A�h���Xxxxx�փW�����v ***************
GOCMD:	INC		HL
		CALL	STFN
		CALL	HLHEX             ;4����16�i���ł����HL�ɃZ�b�g���đ��s
		RET		C
;		JP		C,MONERR
		CALL	MONCLF
		POP		BC
		JP		(HL)              ;HL�̎����A�h���X�ɃW�����v

;************ D�R�}���h �A�h���Xxxxx�����MEMORY��DUMP **********************
STMD:	INC		HL
		CALL	STFN
		CALL	HLHEX             ;4����16�i���ł����SADRS�ɃZ�b�g���đ��s
		RET		C
;		JP		C,MONERR
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
		AND		A
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
STMD4:
;************************* MONHOT�̈��������C�� 2023.5.30 ****************************
		JP		MONHOT
;		JP		CMD1

;************ S�R�}���h �A�h���Xxxxx����MEMORY�ɏ������� **********************
STMW:	INC		HL
		CALL	STFN
		CALL	HLHEX             ;4����16�i���ł����HL�ɃZ�b�g���đ��s
		RET		C
;		JP		C,MONERR

STSP1:	LD		A,(DE)
		AND		A
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
		AND		A               ;��s�I��
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
STMW9:
;************************* MONHOT�̈��������C�� 2023.5.30 ****************************
		JP		MONHOT
;		JP		CMD1

;************ F�R�}���h DIRLIST **********************
STLT:	INC		HL
		CALL	STFN              ;����������𑗐M
		EX		DE,HL
		LD		HL,DEFDIR         ;�s����'*L '��t���邱�ƂŃJ�[�\�����ړ��������^�[���Ŏ��s�ł���悤��
		LD		BC,DEND-DEFDIR
		CALL	DIRLIST           ;DIRLIST�{�̂��R�[��
		AND		A                 ;00�ȊO�Ȃ�ERROR
		CALL	NZ,SDERR
;************************* MONHOT�̈��������C�� 2023.5.30 ****************************
		JP		MONHOT
;		JP		CMD1


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
		AND		A
		JR		NZ,STLT2
		XOR		A
STLT2:	CALL	AZLCNV            ;�啶���ɕϊ�
		CP		22H               ;�_�u���R�[�e�[�V�����ǂݔ�΂�
		JR		NZ,STLT3
		INC		DE
		JR		STLT1
STLT3:	CALL	SNDBYTE           ;�t�@�C���l�[������������𑗐M
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
		AND		A
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
		AND		A
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
		AND		A
		JR		Z,DL6
		CP		1BH               ;ESC�őł��؂�
		JR		Z,DL7
		CP		1EH               ;�J�[�\�����őł��؂�
		JR		Z,DL7
		CP		42H               ;�uB�v�őO�y�[�W
		JR		Z,DL8
		XOR		A                 ;����ȊO�Ōp��
		JR		DL8
;DL9:
;		LD		A,1EH             ;���XSyntax Error���������邽�ߔp�~
;		CALL	CONOUT
;		LD		A,1EH
;		CALL	CONOUT            ;�J�[�\�����őł��؂����Ƃ��ɃJ�[�\��2�s���
DL7:	LD		A,0FFH            ;0FFH���f�R�[�h�𑗐M
DL8:	CALL	SNDBYTE
		JP		DL2
		
DLRET:	RET
		

;************ L�R�}���h .CMT LOAD *************************
MONLOAD:LD		A,71H            ;L�R�}���h71H�𑗐M
		CALL	STCMD
;************************* MONHOT�̈��������C�� 2023.5.30 ****************************
		JP		NZ,MONHOT
;		JP		NZ,CMD1

		PUSH	HL
; *********** �I�[�g�������������p�t���O�N���A *** 2022.8.21 ********
		XOR		A
		LD		HL,ACFLGD
		LD		(HL),A
		INC		HL
		LD		(HL),A
; ********************************************************
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
		CALL	DISPBL
;************************* MONHOT�̈��������C�� 2023.5.30 ****************************
		JP		MONHOT
;		JP		CMD1
		
MCNLOAD:LD		HL,MSG_LD        ;LOADING�\��
		CALL	MSGOUT

; *********** LOAD����p�̃X�^�b�N�|�C���^�Ƃ��邱�Ƃ�CLEAR����SP��ύX���Ă��Ȃ��Ă�E800H�ȍ~�ɐ����LOAD�o����悤�Ώ� 2023.5.30 ********
		LD		SP,0FFFFH

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
		AND		A
		JR		Z,MCLD3          ;�f�[�^����0�Ȃ�I��
		LD		B,A
MCLD2:	CALL	RCVBYTE          ;���f�[�^��M
; ************* �I�[�g�����@�\�̓ǂݑւ���ǉ� ****** 2022.8.21 ************
;		LD		(HL),A
		CALL	AUTOCHK
;****************************************************************
		INC		HL
		DJNZ	MCLD2
		CALL	RCVBYTE          ;�`�F�b�N�T���p��
		JR		MCLD1
MCLD3:	CALL	RCVBYTE          ;�`�F�b�N�T���p��
		LD		HL,MSG_OK        ;OK�\��
		CALL	MSGOUT
;************************* MONHOT�̈��������C�� 2023.5.30 ****************************
		JP		MONHOT           ;SP�𕜋A���ăR�}���h�҂���
;		JP		CMD1

; ************ �t�@���N�V�����L�[�G���A�ւ̏����݂Ȃ珑������ ** 2022.8.21 **
; HL : �������݃A�h���X
; A  : �������݃f�[�^
; CTRL+B -> CTRL+C
; CLOAD  -> LOAD
; "xxxx" -> ""
AUTOCHK:PUSH	DE
		PUSH	BC
		EX		DE,HL
		LD		HL,1540H         ;-(EAC0H)
		ADD		HL,DE
		JP		NC,ACRET         ;EAC0H�����Ȃ�ʏ폑����
		LD		HL,14E4H         ;-(EB1BH+1)
		ADD		HL,DE
		JP		C,ACRET          ;EB1CH�ȏ�Ȃ�ʏ폑����
		CP		02H
		JR		NZ,ACHK1         ;CTRL+B -> CTRL+C
		LD		A,03H
		JP		ACRET            ;CRTL+C�ɏ��������ă��^�[��
		
ACHK1:	LD		B,A
		LD		HL,ACFLGD        ;�_�u���R�[�e�[�V�����t���O��CHK
		LD		A,(HL)
		AND		A
		JR		Z,ACHK11         ;�t���OOFF�Ȃ玟��CHK��
		LD		A,B
		CP		'"'              ;�t���OON�Ȃ�_�u���R�[�e�[�V������CHK
		JR		NZ,ACHK10        ;�_�u���R�[�e�[�V�����ł͂Ȃ��Ȃ珑�����܂��Ƀ��^�[��
		XOR		A                ;�_�u���R�[�e�[�V�����Ȃ�t���O�����Z�b�g
		LD		(HL),A
		JR		ACHK40           ;�_�u���R�[�e�[�V��������������Ń��^�[��

ACHK10:	EX		DE,HL
		DEC		HL               ;�t���OON�Ń_�u���R�[�e�[�V�����łȂ��Ȃ珑�����܂Ȃ��B�������݃A�h���X��INC���Ȃ��Ń��^�[��
		JP		ACRET2

ACHK11:	LD		A,B
		CP		'"'              ;�t���OOFF�Ȃ�_�u���R�[�e�[�V������CHK
		JR		NZ,ACHK20        ;�_�u���R�[�e�[�V�����łȂ��Ȃ玟��CHK��
		LD		A,01H            ;�_�u���R�[�e�[�V�����Ȃ�t���OON
		LD		(HL),A
		XOR		A
		INC		HL
		LD		(HL),A           ;CLOAD�t���O�����Z�b�g
		JR		ACHK40           ;�_�u���R�[�e�[�V��������������Ń��^�[��

ACHK20:	LD		HL,ACFLGC        ;CLOAD�t���O��CHK
		LD		A,(HL)
		CP		00H              ;��v����
		JR		Z,ACHK30
		CP		01H              ;'C'�܂ň�v
		JR		Z,ACHK31
		CP		02H              ;'L'�܂ň�v
		JR		Z,ACHK32
		CP		03H              ;'0'�܂ň�v
		JR		Z,ACHK33
		LD		A,B              ;'A'�܂ň�v
		CP		'D'
		JR		Z,ACHK39
		CP		'd'
		JR		NZ,ACHK40
ACHK39:	XOR		A                ;'CLOAD'����v
		LD		(HL),A           ;CLOAD�t���O�����Z�b�g
		EX		DE,HL            ;�������݃|�C���^��4�߂���'LOAD'�ɏ㏑��
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
ACHK301:LD		A,01H            ;'C'����v
		LD		(HL),A
		JR		ACHK40

ACHK31:	LD		A,B
		CP		'L'
		JR		Z,ACHK311
		CP		'l'
		JR		NZ,ACHK41
ACHK311:LD		A,02H            ;'L'����v
		LD		(HL),A
		JR		ACHK40

ACHK32:	LD		A,B
		CP		'O'
		JR		Z,ACHK321
		CP		'o'
		JR		NZ,ACHK41
ACHK321:LD		A,03H            ;'O'����v
		LD		(HL),A
		JR		ACHK40

ACHK33:	LD		A,B
		CP		'A'
		JR		Z,ACHK331
		CP		'a'
		JR		NZ,ACHK41
ACHK331:LD		A,04H            ;'A'����v
		LD		(HL),A
		
ACHK40:	LD		A,B

ACRET:	EX		DE,HL
		LD		(HL),A           ;��芸������������
ACRET2:	POP		BC
		POP		DE
		RET

ACHK41:	XOR		A                ;'CLOAD'�ƈ�v���Ȃ������̂Ńt���O�����Z�b�g���ď�������
		LD		(HL),A
		JR		ACHK40

;********** 5F9EH READ ONE BYTE FROM CMT�̑�� *********
D_5F9E:	LD		A,72H            ;�R�}���h72H�𑗐M
		CALL	STCD
		CALL	RCVBYTE          ;1Byte�̂ݎ�M
		RET

;********** SD READ OPEN *******************************
ROPEN:	PUSH	HL
		PUSH	DE
		PUSH	BC
		PUSH	AF
		LD		A,76H            ;�R�}���h76H�𑗐M
		CALL	STCD
		AND		A
		JR		NZ,ERRRET
		CALL	STFS             ;�t�@�C���l�[���𑗐M

OKRET:	XOR		A                ;����I�� �t���O�����Z�b�g��A�S���W�X�^���A
		POP		BC
		LD		A,B
		POP		BC
		POP		DE
		POP		HL
		RET

ERRRET:	POP		AF               ;�ُ�I�� �S���W�X�^���A��ACF=1
		POP		BC
		POP		DE
		POP		HL
		SCF
		RET

;********** SD WRITE APPEND OPEN *******************************
WAOPEN:	PUSH	HL
		PUSH	DE
		PUSH	BC
		PUSH	AF
		LD		A,77H            ;�R�}���h77H�𑗐M
		CALL	STCD
		AND		A
		JR		NZ,ERRRET
		CALL	STFS             ;�t�@�C���l�[���𑗐M
		JR		OKRET

;*********** SD WRITE ���Ăяo�� 5ED9H��� ***************************
D_5ED9:	PUSH	DE
		LD		(SADRS),HL       ;SARDS�ۑ�
		LD		(EADRS),DE       ;EARDS�ۑ�
		LD		A,7AH            ;�R�}���h7AH�𑗐M
		CALL	STCD
		AND		A
		JR		NZ,D_5ED9V5

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
D_5ED9V1:
		LD		A,(HL)           ;SADRS����EADRS�܂ł𑗐M
		CALL	SNDBYTE
		LD		A,H
		CP		D
		JR		NZ,D_5ED9V2
		LD		A,L
		CP		E
		JR		Z,D_5ED9V3       ;HL = DE �܂�LOOP
D_5ED9V2:
		INC		HL
		JR		D_5ED9V1
D_5ED9V3:
		CALL	RCVBYTE          ;��Ԏ擾(00H=OK)
		INC		HL
		POP		DE
		XOR		A
		RET
D_5ED9V5:
		POP		DE
		XOR		A
		SCF
		RET
;********** SD WRITE 1BYTE 5F2FH��� *********
D_5F2F:	PUSH	HL
		PUSH	DE
		PUSH	BC
		PUSH	AF
		LD		A,78H            ;�R�}���h78H�𑗐M
		CALL	STCD
		AND		A
		JR		NZ,ERRRET
		POP		AF
		PUSH	AF
		CALL	SNDBYTE          ;1Byte�̂ݑ��M
		CALL	RCVBYTE          ;��Ԏ擾(00H=OK)
		AND		A
		JR		NZ,ERRRET
		JR		OKRET

;********** SD WRITE NEW OPEN *******************************
WNOPEN:	PUSH	HL
		PUSH	DE
		PUSH	BC
		PUSH	AF
		LD		A,79H            ;�R�}���h79H�𑗐M
		CALL	STCD
		AND		A
		JR		NZ,ERRRET
		CALL	STFS             ;�t�@�C���l�[���𑗐M
		JP		OKRET

;********** SD WRITE CLOSE *******************************
WCLOSE:	PUSH	HL
		PUSH	DE
		PUSH	BC
		PUSH	AF
		LD		A,7BH            ;�R�}���h7BH�𑗐M
		CALL	STCD
		AND		A
		JP		NZ,ERRRET
		JP		OKRET

;**** �R�}���h�A�t�@�C�������M (IN:A �R�}���h�R�[�h HL:�t�@�C���l�[���̐擪)****
STCMD:	INC		HL
		CALL	STFN             ;�󔒏���
		PUSH	HL
		CALL	STCD             ;�R�}���h�R�[�h���M
		POP		HL
		AND		A                ;00�ȊO�Ȃ�ERROR
		JP		NZ,SDERR
		CALL	STFS             ;�t�@�C���l�[�����M
		AND		A                ;00�ȊO�Ȃ�ERROR
		JP		NZ,SDERR
		RET

;****2023.6.10 H_5F3A�Ƃ������Ƃŕs�v�ƂȂ��� ****************************
;************ 5F3AH READ FROM TAPE�̑�� (EMI PLAYER�p)*******************
;D_5F3A:
;************ �A������AUTO START�����邽�߂Ƀt���O�|�C���g�Đݒ� (�����Ȃ̂��͎��M�Ȃ�)************
;		LD		HL,FKDEF
;		LD		(FKPINT),HL
;**************************************************************************************
;		
;�t�@�C�����w��Ȃ��Ƃ���MONITOR L�R�}���h���s *********************
;		LD		HL,DEFCR-1
;		JP		MONLOAD

;************ 5F3AH READ FROM TAPE�̑�� (�ėp)*******************
H_5F3A:	LD		HL,DEFCR-1       ;�t�@�C�����w��Ȃ�
		LD		A,71H            ;L�R�}���h71H�𑗐M
		CALL	STCMD
		JP		NZ,ERRRET

		CALL	RCVBYTE          ;�w�b�_�[��M
		CP		3AH              ;3AH�ł���Α��s
		JR		Z,H_5V1
		JP		ERRRET
		
H_5V1:	LD		HL,SADRS+1       ;SADRS�擾
		CALL	RCVBYTE
		LD		(HL),A
		DEC		HL
		CALL	RCVBYTE
		LD		(HL),A
		CALL	RCVBYTE          ;�`�F�b�N�T���p��
		
		LD		HL,(SADRS)
H_5V2:	CALL	RCVBYTE          ;�w�b�_�[3AH��M�A�p��
		CALL	RCVBYTE          ;�f�[�^��
		AND		A
		JR		Z,H_5V4          ;�f�[�^����0�Ȃ�I��
		LD		B,A
H_5V3:	CALL	RCVBYTE          ;���f�[�^��M
		LD		(HL),A
		INC		HL
		DJNZ	H_5V3
		CALL	RCVBYTE          ;�`�F�b�N�T���p��
		JR		H_5V2
H_5V4:	CALL	RCVBYTE          ;�`�F�b�N�T���p��
		RET
H_5V5:	SCF
		RET
;************ W�R�}���h .CMT SAVE ********************************
MONSAVE:INC		HL
		CALL	STFN
		CALL	HLHEX            ;4����16�i���ł����SADRS�ɃZ�b�g���đ��s
		RET		C
;		JP		C,MONERR
		LD		(SADRS),HL       ;SARDS�ۑ�
		EX		DE,HL

		CALL	STFN
		CALL	HLHEX            ;4����16�i���ł����EADRS�ɃZ�b�g���đ��s
		RET		C
;		JP		C,MONERR
		LD		(EADRS),HL       ;EARDS�ۑ�

		PUSH	DE
		PUSH	HL
		LD		DE,(SADRS)
		SBC		HL,DE
		POP		HL
		POP		DE
		RET		C
;		JP		C,MONERR         ;EADRS��SADRS��菬������΃G���[

		EX		DE,HL
		DEC		HL
		
		LD		A,70H            ;�R�}���h70H�𑗐M
		CALL	STCMD
;************************* MONHOT�̈��������C�� 2023.5.30 ****************************
		JP		NZ,MONHOT
;		JP		NZ,CMD1

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
;************************* MONHOT�̈��������C�� 2023.5.30 ****************************
		JP		MONHOT
;		JP		CMD1

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

;****** FILE NAME���擾�ł���܂ŃX�y�[�X�A�_�u���R�[�e�[�V������ǂݔ�΂� (IN:HL �R�}���h�����̎��̕��� OUT:HL �t�@�C���l�[���̐擪)*********
STFN:	PUSH	AF
STFN1:	LD		A,(HL)
		CP		20H
		JR		Z,STFN2
		CP		22H
		JR		NZ,STFN3
STFN2:	INC		HL               ;�t�@�C���l�[���܂ŃX�y�[�X�ǂݔ�΂�
		JR		STFN1
STFN3:	POP		AF
		RET

STSV2:                           ;�t�@�C���l�[���̎擾�Ɏ��s
		LD		HL,MSG_FNAME
		JR		ERRMSG

;**** �t�@�C���l�[�����M(IN:HL �t�@�C���l�[���̐擪) ******
STFS:	LD		B,20H
STFS1:	LD		A,(HL)           ;FNAME���M
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
ERR6:	CP		0F6H
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
		CALL	DISPBL
		POP		AF
		RET

;************** BASIC CMT LOAD *********************
CMDLOAD:
		DEC		HL
		LD		A,73H            ;�R�}���h73H�𑗐M
		CALL	STCMD
		JP		NZ,RETBC

		LD		HL,0118H         ;1�����ځA24�s�ڂփJ�[�\�����ړ�
		CALL	CSR
		CALL	MONCLF
		
		CALL	RCVBYTE          ;�w�b�_�[��M
		CP		0D3H             ;D3H�łȂ���΃G���[
		JR		Z,CMDLD
		LD		HL,MSG_F6        ;NOT BASIC PROGRAM
		CALL	MSGOUT
		CALL	DISPBL
		JP		RETBC
		
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
		XOR		A
		LD		(DE),A
		LD		HL,IBUF
		CALL	MSGOUT
		CALL	MONCLF
		
		LD		HL,(BASSRT)      ;BASIC�v���O�����i�[�J�n�ʒu��HL�ɐݒ�

CMDLD3:	LD		B,0CH            ;00H��12�A���Ŏ�M����܂Ń��[�v
CMDLD4:	CALL	RCVBYTE
		LD		(HL),A
		INC		HL

		AND		A
		JR		Z,CMDLD5
		JR		CMDLD3
CMDLD5:	DEC		B
		JR		Z,CMDLD6
		JR		CMDLD4

CMDLD6:	LD		BC,0007H         ;HL�̈ʒu��7�߂���BASIC�v���O�����I���ʒu�Ƃ���
		SBC		HL,BC
		
		JR		RETBC2           ;BASIC�v���O����LOAD�㏈��
		
;********************** BASIC CMT SAVE **********************
CMDSAVE:
		PUSH	HL
		LD		HL,(BASSRT)      ;BASIC�v���O�����i�[�J�n�ʒu��HL�ɐݒ�
		LD		A,(HL)
		INC		HL
		OR		(HL)
		POP		HL
		JP		Z,CMDSV5         ;BASIC�v���O������1�s���Ȃ���΃G���[

		DEC		HL
		LD		A,74H            ;�R�}���h74H�𑗐M
		CALL	STCMD
		JR		NZ,CMDSV4

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
;2022.8.4  SYNTAX ERROR���
CMDSV4:	JR		RETBC

;2022.8.4  SYNTAX ERROR���
CMDSV5:
		CALL	DISPBL
		LD		HL,MSG_F5        ;NO BASIC PROGRAM
		JR		RETBC3

;************ BASIC FILES ********************
CMDFILES:
;2022.7.24 SYNTAX ERROR����ɂ��A�p�~
;		PUSH	HL
;		LD		HL,FMSG          ;FILES�̌��Ƀt�@�C���������������w�肷��ƍ\���G���[�ɂȂ邽�߁A�ʍs�Ƃ��ē���
;		CALL	MSGOUT
;		CALL	LINPUT
;		INC		HL
		CALL	STFN             ;���͕�����擾
		EX		DE,HL
		LD		HL,DEFDIR2       ;�s����'LOAD '��t���邱�ƂŃJ�[�\�����ړ��������^�[���Ŏ��s�ł���悤��
		LD		BC,D2END-DEFDIR2
		CALL	DIRLIST          ;DIRLIST�{�̂��R�[��
;2022.8.4  SYNTAX ERROR���
		JR		RETBC
		
;************ BASIC KILL ***************************
CMDKILL:
		DEC		HL
		LD		A,75H            ;�R�}���h75H�𑗐M
		CALL	STCMD
		JR		NZ,RETBC         ;�t�@�C���������M�ł��Ȃ������B
		CALL	RCVBYTE
		AND		A
		JP		NZ,CMDKL1         ;�t�@�C�������݂��Ȃ�
		LD		HL,MSG_KL
RETBC3:	CALL	MSGOUT
		CALL	MONCLF

;2022.8.4 SYNTAX ERROR��� 
;FILES SAVE KILL����BASIC�֐������߂��������Ȃ��������߁ALOAD�㏈���Ŗ߂邱�ƂƂ���B
RETBC:
		LD		HL,(VARBGN)
;LOAD�㏈��
RETBC2:
		JP		AFTLOAD          ;BASIC�v���O����LOAD�㏈��
		
;2022.8.4  SYNTAX ERROR���
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

;************* ���MONITOR�փW�����v���邽�߂̐ݒ� *************
		JP		MONINI
		DB		55H
		
		END
