; Khai bao vung ma lenh
	AREA MYCODE, CODE, READONLY
	ENTRY
	EXPORT __main
		
; Khai bao du lieu
;value DCD 123
	
; code
__main
	
	LDR R0, =0x12341234
	LDR r1, =0xFFFFFFFF
	
	BFI R1,R0,#4,#8 ; insert 8 bit cua thanh ghi R0 vao vi tri thu tu cua thanh ghi R1
	
	LDR R0, =0x000000FF
	BFC R0,#4,#4		; clear 4 bit tu vi tri bit thu tu trong R0	;	0x0000000F
STOP
	B STOP
	END