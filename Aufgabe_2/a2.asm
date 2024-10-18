; SBC-86 Testprogramm zur Ausgabe auf 7-Segment-Anzeigen und LEDs

; Symbolische Konstanten
SWITCH_PORT    EQU 0x00
LED_PORT       EQU 0x00
SEGMENT_PORT_1 EQU 0x90
SEGMENT_PORT_2 EQU 0x92

; 7-Segment-Darstellungen für Hexadezimalziffern 0-F
SEGMENT_TABLE:
    DB 0x3F ; 0
    DB 0x06 ; 1
    DB 0x5B ; 2
    DB 0x4F ; 3
    DB 0x66 ; 4
    DB 0x6D ; 5
    DB 0x7D ; 6
    DB 0x07 ; 7
    DB 0x7F ; 8
    DB 0x6F ; 9
    DB 0x77 ; A
    DB 0x7C ; B
    DB 0x39 ; C
    DB 0x5E ; D
    DB 0x79 ; E
    DB 0x71 ; F

START:
    ; Initialisierung
    MOV DX, SWITCH_PORT
    IN AL, DX
    MOV DX, LED_PORT
    OUT DX, AL

    ; Lese Schalterwert
    MOV DX, SWITCH_PORT
    IN AL, DX

    ; Ausgabe auf LEDs
    MOV DX, LED_PORT
    OUT DX, AL

    ; Teile den Wert in zwei Nibbles
    MOV AH, AL
    SHR AH, 4
    AND AL, 0x0F

    ; Addiere die beiden Nibbles
    ADD AL, AH

    ; Ausgabe des Ergebnisses auf LEDs
    MOV DX, LED_PORT
    OUT DX, AL

    ; Konvertiere das Ergebnis in 7-Segment-Darstellung
    MOV AH, AL
    AND AH, 0x0F
    MOV BX, SEGMENT_TABLE
    MOV BL, AH
    MOV AH, [BX]

    ; Ausgabe auf 7-Segment-Anzeigen
    MOV DX, SEGMENT_PORT_1
    OUT DX, AH

    ; Nächstes Nibble
    SHR AL, 4
    MOV BL, AL
    MOV AH, [BX]

    ; Ausgabe auf 7-Segment-Anzeigen
    MOV DX, SEGMENT_PORT_2
    OUT DX, AH

    ; Endlosschleife
    JMP START

END START