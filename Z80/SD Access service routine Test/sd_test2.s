;************************** SD ACCESS関連サービスルーチンテスト *******************
MSGOUT		EQU		52EDH		;文字列の出力2

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
