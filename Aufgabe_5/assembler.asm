section .text
global addsub

addsub:
    push ebp            ; Speichere den aktuellen Wert von EBP auf dem Stack
    mov ebp, esp        ; Setze EBP auf den aktuellen Wert von ESP (neuer Stackrahmen)

    mov eax, [ebp+8]    ; Lade den ersten Operand (op1) in EAX
    mov ebx, [ebp+12]   ; Lade den zweiten Operand (op2) in EBX
    mov ecx, [ebp+16]   ; Lade das Operationszeichen ('+' oder '-') in ECX
    mov edx, [ebp+20]   ; Lade die Adresse des Ergebnis-Variables in EDX

    cmp byte [ecx], '+' ; Vergleiche das Operationszeichen mit '+'
    je do_add           ; Wenn es '+' ist, springe zu do_add
    cmp byte [ecx], '-' ; Vergleiche das Operationszeichen mit '-'
    je do_sub           ; Wenn es '-' ist, springe zu do_sub

    ; Wenn das Operationszeichen weder '+' noch '-' ist, ist die Operation ungültig
    ; Setze das Ergebnis auf 0 und beende die Funktion
    mov eax, 0
    jmp done

do_add:
    add al, bl          ; Führe die Addition der unteren 8 Bits von EAX und EBX durch
    jmp finish          ; Springe zu finish

do_sub:
    sub al, bl          ; Führe die Subtraktion der unteren 8 Bits von EAX und EBX durch

finish:
    mov [edx], eax      ; Speichere das Ergebnis (untere 8 Bits von EAX) in der Ergebnis-Variable
    pushfd              ; Speichere das Flag-Register auf dem Stack
    pop eax             ; Lade das Flag-Register in EAX
    and eax, 0x8D5      ; Maskiere die relevanten Flags (OF, DF, IF, TF, SF, ZF, AF, PF, CF)
    movzx eax, ax       ; Erweitere die unteren 16 Bits von EAX auf 32 Bits

done:
    pop ebp             ; Stelle den ursprünglichen Wert von EBP wieder her
    ret                 ; Kehre zur aufrufenden Funktion zurück

section .note.GNU-stack
    db 0