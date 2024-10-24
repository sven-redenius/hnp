cpu 8086
org 100h

; Symbolische Konstanten für die Portadressen
SWITCH_PORT equ 0h
LED_PORT equ 0h
SEGMENT_PORT_1 equ 90h
SEGMENT_PORT_2 equ 92h

; Tabelle für die 7-Segment-Darstellung
SEGMENT_TABLE db 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71

START:
    ; Lese den Schalter-Port
    IN AL, SWITCH_PORT

    ; Gib den gelesenen Wert auf den LED-Port aus
    OUT LED_PORT, AL

    ; Extrahiere das untere Nibble
    MOV AH, AL
    AND AH, 0x0F

    ; Extrahiere das obere Nibble
    SHR AL, 4
    AND AL, 0x0F

    ; Addiere die beiden Nibbles
    ADD AL, AH

    ; Gib das Ergebnis auf den LED-Port aus
    OUT LED_PORT, AL

    ; Konvertiere das Ergebnis in 7-Segment-Darstellung
    MOV AH, AL
    AND AH, 0x0F
    MOV BX, SEGMENT_TABLE
    MOV BL, AH
    MOV AH, [BX]

    ; Ausgabe auf 7-Segment-Anzeigen (ganz rechts)
    MOV DX, SEGMENT_PORT_1
    OUT DX, AH

    ; Nächstes Nibble
    SHR AL, 4
    MOV BL, AL
    MOV AH, [BX]

    ; Ausgabe auf 7-Segment-Anzeigen (2. von rechts)
    MOV DX, SEGMENT_PORT_2
    OUT DX, AH

    ; Endlosschleife
    JMP START

END START