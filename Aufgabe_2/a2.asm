org 100h
cpu 8086

jmp START

; Symbolische Konstanten für die Portadressen
SWITCH_PORT equ 0h
LED_PORT equ 0h
SEGMENT_PORT_1 equ 90h
SEGMENT_PORT_2 equ 92h

; Tabelle für die 7-Segment-Darstellung
SEGMENT_TABLE db 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71

START:  IN AL, SWITCH_PORT

        ; Gib den gelesenen Wert auf den LED-Port aus
        OUT LED_PORT, AL

        ; Extrahiere das obere Nibble
        MOV AH, AL
        AND AH, 0x0F
        PUSH ah ;obere nibble auf stack (TEST)

        ; Extrahiere das untere Nibble
        AND AL, 0xF0
        MOV CL, 4
        SHR AL, CL
        add al, ah
        out LED_PORT, al
        mov ah,0

        ;ergebnis aufteilen in nibble
        ;Stack nutzen um beide Nibble zu erzeugen und in AL zu packen -> Ausgabe nacheinander an 7 Segment Anzeige
        ; Extrahiere das obere Nibble
        MOV AH, AL
        AND AH, 0x0F

        ; Extrahiere das untere Nibble
        AND AL, 0xF0
        MOV CL, 4
        SHR AL, CL

        ;nibbleweise ausgeben auf 7seg
        MOV BX, SEGMENT_TABLE
        add bx, ax
        mov al, [bx]
        OUT SEGMENT_PORT_1, al

        SHR AX, CL
        MOV BX, SEGMENT_TABLE
        add bx, ax
        mov al, [bx]
        OUT SEGMENT_PORT_2, al

        ; Endlosschleife
        JMP START