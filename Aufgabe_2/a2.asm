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
    mov al, 0x48 ; H
    mov [DISPLAY_0], al
    mov al, 0x61 ; a
    mov [DISPLAY_1], al
    mov al, 0x6c ; l
    mov [DISPLAY_2], al
    mov al, 0x6c ; l
    mov [DISPLAY_3], al
    mov al, 0x6f ; o
    mov [DISPLAY_4], al
    mov al, 0x20 ; Leerzeichen
    mov [DISPLAY_5], al
    mov al, 0x20 ; Leerzeichen
    mov [DISPLAY_6], al
    mov al, 0x20 ; Leerzeichen
    mov [DISPLAY_7], al
    jmp START
    

