# Konstanten für die Verwendung in den Regeln
CC = gcc
ASM = nasm
CFLAGS =  -m32 -Wall -Wextra -pedantic
ASMFLAGS = -f elf
LDFLAGS = -no-pie -m32

# Linken der Objektdateien (C und Assembler) --> Ausführbare Datei
a5: a5.o a5_asm.o
	$(CC) $(LDFLAGS) -o a5 a5.o a5_asm.o

# Objektdatei der C-Datei bauen
a5.o: a5.c
	$(CC) $(CFLAGS) -c a5.c

# Objektdatei der Assembler-Datei bauen
a5_asm.o: assembler.asm
	$(ASM) $(ASMFLAGS) -o a5_asm.o assembler.asm

# Clean-Ziel zum Entfernen der erzeugten Dateien
clean:
	rm -f a5 a5.o a5_asm.o