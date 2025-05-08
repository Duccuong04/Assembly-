; Khai bao vung ma lenh
	AREA MYCODE, CODE, READONLY
	ENTRY
	EXPORT __main
		
; Khai bao du lieu
;value DCD 123
	
; code
__main
	
	MOV R1,#1
	MOV R0,#0
	MOV R2,#1
	
	CMP R0,R2
	BEQ Bangnhau
	BNE Khaunhau
	MOV R2,#99

Bangnhau
	MOV R2,#100
	
Khacnhau
	MOV R2,#90
	
STOP
	B STOP
	END