# ARM Assembly

https://developer.arm.com/documentation/dui0473/m/overview-of-the-assembler/about-the-arm-compiler-toolchain-assemblers?utm_source=chatgpt.com

Documenation: https://apt.cs.manchester.ac.uk/ftp/pub/apt/peve/PEVE05/Slides/


## 1. Start

- Overview Computer 

![alt text](image.png)

![alt text](image-1.png)

- Section

![alt text](image-2.png)

- Lệnh 

![alt text](image-3.png)

## 1.1. Thanh ghi của vi xử lý ARM-Cotex M4

**Link: https://tapit.vn/co-ban-ve-cau-truc-va-tinh-nang-vi-xu-ly-arm-cortex-mx/** 

![alt text](image-4.png)

- Không thể giao tiếp với các thanh ghi này bằng ngôn ngữ C -> phải sử dụng ngôn ngữ assembly

## 1.2. First

![alt text](image-5.png)

-> thay đổi các thanh ghi R0, R1, R2

- AREA: đánh dấu bắt đầu của 1 section, tên sextion

- ENTRY: đánh dấu lệnh đầu tiên được thực thi

## 2. Kiểu dữ liệu, keyword hay gặp, so sánh GCC và KeilC

![alt text](image-6.png)

![alt text](image-7.png)

### Khai báo KeilC so với GCC

![alt text](image-8.png)

### Keyword hay gặp

![alt text](image-9.png)

## 3. Lệnh MOV và ADD trong Assembly

- MOV: gán giá trị thanh ghi

- ADD: cộng giá trị thanh ghi

## 4. Khai báo biến, trừ, nhân

```c
BASE    EQU 0x203
Hello   DCB "Hellodcuong", 0
VarByte DCB 2,3,4,5
Var32   DCD 2,100,-100
Var16   DCW 100,300,20
p       SPACE 200
f       FILL 20,0xFF,1
Bin     DCB 2_01010100
A       DCB 0x48           ; ho?c 'H'
CH      DCB 'A'

```
| Tên biến  | Kiểu  | Dữ liệu                 | Dung lượng |
| --------- | ----- | ----------------------- | ---------- |
| `Hello`   | DCB   | Chuỗi `"Hellodcuong\0"` | 12 bytes   |
| `VarByte` | DCB   | 2, 3, 4, 5              | 4 bytes    |
| `Var32`   | DCD   | 2, 100, -100            | 12 bytes   |
| `Var16`   | DCW   | 100, 300, 20            | 6 bytes    |
| `p`       | SPACE | (trống)                 | 200 bytes  |
| `f`       | FILL  | 0xFF x 20               | 20 bytes   |
| `Bin`     | DCB   | 0x54                    | 1 byte     |
| `A`       | DCB   | 0x48 (ASCII 'H')        | 1 byte     |
| `CH`      | DCB   | 0x41 (ASCII 'A')        | 1 byte     |


```c

        AREA MYDATA, DATA, READWRITE
BASE    EQU 0x203
Hello   DCB "Hellodcuong", 0
VarByte DCB 2,3,4,5
Var32   DCD 2,100,-100
Var16   DCW 100,300,20
p       SPACE 200
f       FILL 20,0xFF,1
Bin     DCB 2_01010100
A       DCB 0x48           ; ho?c 'H'
CH      DCB 'A'
        
		AREA MYCODE, CODE, READONLY
        ENTRY
        EXPORT __main

__main
	MOV R1, #10
	MOV R2, #2
	MOV R3, #1
	
	; Tru
	SUB R1, #5   ; R1 = R1 -5
	SUB R1, R2  ; R1 = R1 - R2
	SUBS R1,R2,R3  ; R1 = R2 - R3   SUBS
	
	; Nhaan
	MUL R1,R2  ; R1 = R1 x R2
	MUL R1,R2,R3  ; R1 = R2 x R3
	
	; Nhan to hop
	MLA R1,R2,R3,R4   ; R1 = (R2xR3) + R4
	MLS R1,R2,R3,R4   ; R1 = R4 - (R2xR3)
	RSB R1,R2,#3	; R1 = -R2 + 3
STOP    B STOP
        END


```

## 5. Dịch bit trái, phải (LSL, LSR), ROTATE FOR

- **ROTATE FOR: xoay bit**, tương tự mấy thanh ghi Shift Register trong STM32

```c
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
```

![alt text](image-10.png)

## 6. Clear bit field vaf insert bit field

**Insert Bit Field**

![alt text](image-11.png)

```c
LDR R0, =0x12341234     ; R0 = 0x12341234 = 0001 0010 0011 0100 0001 0010 0011 0100
LDR R1, =0xFFFFFFFF     ; R1 = 0xFFFFFFFF = 1111 1111 1111 1111 1111 1111 1111 1111

BFI R1, R0, #4, #8
```
- Lệnh này có nghĩa: lấy 8 bit thấp nhất của R0 (tức là 0x34 = 00110100), rồi chép vào vị trí từ bit 4 đến bit 11 của R1.

**Clear Bit Field BFC**

![alt text](image-12.png)
![alt text](image-13.png)

## 7. Bit wise trong ARM Assembly

![alt text](image-14.png)

## 8. Load LDR & Store STR

### Cách dữ liệu 32-bit (word) được lưu trữ trong bộ nhớ theo kiểu Little Endian
![alt text](image-15.png)

- Ngược lại với **Big Endian**, thứ tự byte little endian lưu trữ LSB ở địa chỉ nhỏ nhất và MSB ở địa chỉ lớn nhất. Điều này có nghĩa là thứ tự byte là từ phải sang trái, với byte ít quan trọng nhất trước.

### LDR & STR, load register & store register 
![alt text](image-16.png)

### STR: lưu giá trị từ một thanh ghi vào bộ nhớ

`STR <Nguồn>, [<Đích>]
`

```c
MOV R0, #0x12345678   ; Gán giá trị vào R0
LDR R1, =0x20000000   ; R1 trỏ tới địa chỉ bộ nhớ
STR R0, [R1]          ; Lưu giá trị trong R0 vào địa chỉ 0x20000000

```

![alt text](image-17.png)

### LDR: đẩy giá trị của vùng nhớ vào thanh ghi

`LDRH r11, [r0]`: lưu 16 bit của vùng nhớ vào thanh ghi

![alt text](image-18.png)

```c

        AREA MYCODE, CODE, READONLY
        ENTRY
        EXPORT __main
			
; Khai bao du lieu
st      DCD 1, 2, 3, 4, 5

; Code
__main	
		LDR R1, st
		LDR R1, =st
        LDR R3, =4
        LDR R2, [R1]
        LDR R2, [R1, R3]
        LDR R2, [R1, #4]
        LDR R8, =0x8000300

        LDR R0, =0xABCDABCD
        LDR R1, =0x2000100
        STR R0, [R1]

STOP    B STOP
        END

```

![alt text](image-19.png)

### Ví dụ STR: lưu giá trị thanh ghi vào RAM

### 1. Cộng trước lưu sau

![alt text](image-20.png)

- r0: nguồn dữ liệu (giá trị sẽ được ghi)

- [r1, #12]: địa chỉ đích là nội dung thanh ghi cộng thêm 12 byte offset, 0x200 + 0xC = 0x20C

### 2. Lưu trước cộng sau
![alt text](image-21.png)