; Konstanten
LED_PORT equ 0h ; Portadresse der LED-Gruppe
SWITCH_PORT equ 0h ; Portadresse des Schalters
DISPLAY_0 equ 90h ; Adresse der 7-Segmentanzeige (ganz rechts)
DISPLAY_1 equ 92h 
DISPLAY_2 equ 94h
DISPLAY_3 equ 96h
DISPLAY_4 equ 98h
DISPLAY_5 equ 9ah
DISPLAY_6 equ 9ch
DISPLAY_7 equ 9eh ; Adresse der 7-Segmentanzeige (ganz links)  

;gibt den Text "Hallo" auf der 7-Segmentanzeige aus
START: 
    mov lw 0x48 ; H
    mov wf DISPLAY_0
    mov lw 0x61 ; a
    mov wf DISPLAY_1
    mov lw 0x6c ; l
    mov wf DISPLAY_2
    mov lw 0x6c ; l
    mov wf DISPLAY_3
    mov lw 0x6f ; o
    mov wf DISPLAY_4
    mov lw 0x20 ; Leerzeichen
    mov wf DISPLAY_5
    mov lw 0x20 ; Leerzeichen
    mov wf DISPLAY_6
    mov lw 0x20 ; Leerzeichen
    mov wf DISPLAY_7
    goto START
    end  

