; Khai bao vung ma lenh
	AREA MYCODE, CODE, READONLY
	ENTRY
	EXPORT __main
		
; Khai bao du lieu
;value DCD 123
	
; code
__main

	MOV R2,#2
	MOV R1,#1
	
	LSL R1,#2		// R1 << 2
	LSR R2,#1       // R2 >> 1
	
	MOV R1,#2 00101110
	ROR R2,R1,#1 ; Dich phai R1
	
STOP
	B STOP
	END