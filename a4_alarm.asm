	org 100h
	cpu 8086

	jmp start

; Variablen

status	db 0			; Statusbyte

; Konstanten
intab7		equ 3ch		; Adresse Interrupttabelle Lichttaster
intab0		equ 20h		; Adresse Interrupttabelle Timerkanal 1
eoi		equ 20h			; End of Interrupt
clrscr		equ 0		; Clear Screen
ascii		equ 2		; Funktion ASCIIZ-Stringausgabe
getkey		equ 1		; Funktion auf Tastatureingabe warten
conin		equ 5		; Console IN
conout		equ 6		; Console OUT
ppi_ctl		equ 0b6h	; Steuerkanal PPI (Parallelinterface)
ppi_a		equ 0b0h	; Kanal A PPI
ppi_b		equ 0b2h	; Kanal B PPI
ppi_c		equ 0b4h	; Kanal C PPI
ocw_2_3		equ 0c0h	; PIC (Interruptcontroller), OCW2,3
ocw_1		equ 0c2h	; PIC (Interruptcontroller), OCW1
icw_1		equ 0c0h	; PIC (Interruptcontroller), ICW1
icw_2_4		equ 0c2h	; PIC (Interruptcontroller), ICW2,4
pitc		equ 0a6h	; Steuerkanal PIT (Intervaltimer)
pit1		equ 0a2h	; Kanal 1 PIT
pit2		equ 0a4h	; Kanal 2 PIT
leds		equ 0		; LED Port
schalter	equ 0		; Schalterport
keybs		equ 80h		; SBC-86 Tastatur
sseg7		equ 9eh		; Segmentanzeige 7
tc		equ 0			; Zeitkonstante (1,8432 MHz Takt)

start:	

; Initialisierungen (Display, LEDs, Alarm aus etc.) erfolgen hier

;	........
;	........

	call init		; Initialisierung PIT (Kanal 1), PPI, PIC
				; und Interruptsystem

; Hintergrundprogramm

again:	

; Der hier einzufügende Programmcode wird immer dann ausgeführt, wenn
; die Interruptserviceroutinen nicht laufen (Hintergrundprogramm).
; Das wäre z.B. die Abfrage der Tastatur, die Manipulation der Statusbits und 
; die Ausgabe an das Display und die LEDs.

	jmp again


init:	cli			; Interrupts aus

; PIT-Init.

	mov al, 01110110b	; Kanal 1, Mode 3, 16-Bit ZK
	out pitc, al		; Steuerkanal
	mov al, tc & 0ffh	; Low-Teil Zeitkonstante
	out pit1, al
	mov al, tc >> 8		; High-Teil Zeitkonstante
	out pit1, al

; PPI-Init.
	mov al, 10001011b	; PPI A/B/C Mode0, A Output, sonst Input
	out ppi_ctl, al
	jmp short $+2		; I/O-Delay
	mov al, 0		; LEDs aus (high aktiv)
	out ppi_a, al
	
; PIC-Init.
	mov al, 00010011b	; ICW1, ICW4 benötigt, Bit 2 egal, 
				; Flankentriggerung
	out icw_1, al
	jmp short $+2		; I/O-Delay
	mov al, 00001000b	; ICW2, auf INT 8 gemapped
	out icw_2_4, al
	jmp short $+2		; I/O-Delay
	mov al, 00010001b	; ICW4, MCS-86, EOI, non-buffered,
				; fully nested
	out icw_2_4, al
	jmp short $+2		; I/O-Delay
	mov al, 01111110b	; Kanal 0 + 7 am PIC demaskieren
				; PIT K1 und Lichttaster
	out ocw_1, al
	
; Interrupttabelle init.	
	mov word [intab7], isr_lt	; Interrupttabelle (Lichttaster) 
					; initialisieren (Offset)
	mov [intab7 + 2], cs		; (Segmentadresse)
	mov word [intab0], isr_timer	; Interrupttabelle (Timer) 
					; initialisieren (Offset)
	mov [intab0 + 2], cs		; (Segmentadresse)
	
	sti				; ab jetzt Interrupts
	ret

isr_lt:
	push ax

; Interruptservice Reflexlichttaster:
; Hier ist z.B. der Programmcode einzufügen, um Statusbits zu manipulieren.
; Der gemeinsame Ausgang aus der ISR ist "isr1".

isr1:
	mov al, eoi		; EOI an PIC
	out ocw_2_3, al		; OCW
	pop ax
	iret

isr_timer:
	push ax

; Interruptservice Timer Kanal 1:
; Hier ist z.B. der Programmcode einzufügen, um Statusbits abzufragen und
; den Lautsprecher anzusteuern. Ausgänge sind auch lesbar!
; Der gemeinsame Ausgang aus der ISR ist "isr2".

isr2:
	mov al, eoi		; EOI an PIC
	out ocw_2_3, al		; OCW
	pop ax
	iret
 
