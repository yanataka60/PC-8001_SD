;************************** SD ACCESS�֘A�T�[�r�X���[�`���e�X�g *******************
ROPEN		EQU		600FH
R1BYTE		EQU		6006H
H_5F3A		EQU		6009H
WAOPEN		EQU		6012H
WNOPEN		EQU		601BH
W1BYTE		EQU		6018H
WCLOSE		EQU		601EH
D_5ED9		EQU		6015H
PRHEX		EQU		5EC5H		;16�i�f�[�^2���\��
MONSPC		EQU		5FD4H		;�X�y�[�X�̕\��

			ORG		0A000H

			PUSH	HL
			PUSH	DE
			PUSH	BC
			PUSH	AF
;********* WNAME�̃t�@�C�����ŐV�K�Ƀt�@�C�����쐬���A01H�`FFH�܂�255Byte�̃f�[�^����������
			LD		HL,WNAME
			CALL	WNOPEN
			LD		B,0FFH
			LD		A,01H
LOP1:		CALL	W1BYTE
			INC		A
			DJNZ	LOP1
			CALL	WCLOSE

;********* WNAME�̃t�@�C�����̃t�@�C����ǂݍ��ݗp�Ƃ��ĊJ���A255Byte�̃f�[�^��ǂݍ��݁A16�i���Ƃ��ĕ\������B
			LD		HL,WNAME
			CALL	ROPEN
			LD		B,0FFH
LOP2:		CALL	R1BYTE
			CALL	PRHEX
			CALL	MONSPC
			DJNZ	LOP2

;********* WNAME�̃t�@�C�����Ńt�@�C�����������ݗp�ɊJ���AFFH�`01H�܂�255Byte�̃f�[�^��ǉ��ŏ�������
			LD		HL,WNAME
			CALL	WAOPEN
			LD		B,0FFH
			LD		A,0FFH
LOP3:		CALL	W1BYTE
			DEC		A
			DJNZ	LOP3
			CALL	WCLOSE
			
;********* WNAME2�̃t�@�C�����ŐV�K�Ƀt�@�C�����쐬���AA000H�`A07AH�܂ł��������f�[�^���@�B��t�H�[�}�b�g�̃t�@�C���Ƃ��č쐬����
			LD		HL,WNAME2
			CALL	WNOPEN
			LD		HL,0A000H
			LD		DE,0A096H
			CALL	D_5ED9

;********* WNAME2�̃t�@�C�����Ńt�@�C�����I�[�v�����A�@�B��t�H�[�}�b�g�̃t�@�C���Ƃ��ă��[�h���Ď��s
			LD		HL,WNAME3
			CALL	ROPEN
			CALL	H_5F3A
			JP		0A100H

WNAME		DB		'SD_WRITE_READ_TEST.DAT',00H
WNAME2		DB		'SD_WRT_DIRECT_TEST.BIN.CMT',00H
WNAME3		DB		'SD_TEST2.BIN.CMT',00H
			END
