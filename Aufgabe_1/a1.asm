		org 100h
		cpu 8086

		jmp START

BYTE1	db 32 ; belegt 1 Byte
TEXT1	db 'Hardwarenahes Programmieren' ; belegt 30 Bytes
		times 4 db 0,'1' ;times 4 belegt 4 Bytes mit 0 und '1'
WORT1	dw 1,2,3,4,1234 ; belegt 10 Bytes, da 2 Byte pro Wert
		dd 1234h ; belegt 4 Bytes

START:	mov bx, BYTE1
WDH:	mov al, [bx]
		out 0, al
		inc bx
		jmp WDH

