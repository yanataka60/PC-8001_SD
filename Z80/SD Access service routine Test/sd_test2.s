;************************** SD ACCESS�֘A�T�[�r�X���[�`���e�X�g *******************
MSGOUT		EQU		52EDH		;������̏o��2

			ORG		0A100H
		
			LD		HL,MSG
			CALL	MSGOUT
			POP		AF
			POP		BC
			POP		DE
			POP		HL
			
			RET

MSG:		DEFB	0DH,0AH,'SD TEST OK',0DH,0AH,00H
			END
