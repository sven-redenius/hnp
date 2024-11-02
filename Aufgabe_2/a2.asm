org 100h
cpu 8086

jmp START

; Symbolische Konstanten für die Portadressen
SWITCH_PORT equ 0h
LED_PORT equ 0h
SEGMENT_PORT_1 equ 90h ; Rechtes Segment Display
SEGMENT_PORT_2 equ 92h

; Tabelle für die 7-Segment-Darstellung
SEGMENT_TABLE db 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71

START:  in AL, SWITCH_PORT

        ; Gib den gelesenen Wert auf den LED-Port aus
        out LED_PORT, AL

        ; Extrahiere das untere Nibble
        mov AH, AL
        and AH, 0x0F    

        ; Extrahiere das obere Nibble
        mov CL, 4
        shr AL, CL

        ; addiere werte
        add AL, AH

        ; addierter wert ausgeben
        out LED_PORT, AL

        ; Extrahiere das untere Nibble
        mov AH, AL
        and AH, 0x0F

        ; Extrahiere das obere Nibble
        shr AL, CL

        ; nibbleweise ausgeben auf 7seg

        ; obere Nibble ausgeben
        mov BX, SEGMENT_TABLE
        xlat
        out SEGMENT_PORT_2, AL

        ; untere Nibble ausgeben
        mov AL, AH        
        xlat
        out SEGMENT_PORT_1, AL

        ; Endlosschleife
        jmp START