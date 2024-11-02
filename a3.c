/**
 * @file a3.c
 * Sie haben bei der Arbeit mit dem SBC-Debugger ein Speicherabbild (Memorydump) zur Programmanalyse kennengelernt. 
 * Eine vergleichbare Funktionalität wollen wir nun auf dem PC zur Ausgabe eines Speicherabbildes auf der Konsole realisieren. 
 * Schreiben Sie hierzu ein Programm mit einer C-Funktion, die als Parameter einen Zeiger auf “unsigned char” sowie die Anzahl 
 * der auszugebenden Zeilen (zu je 16 Zeichen) erhält. 
 * Der Speicherinhalt soll sowohl hexadezimal ( printf("%02x ", *ptr); ) als auch (wo möglich) als druckbares ASCII-Zeichen 
 * ausgegeben werden. Jede Zeile soll mit einer durch 16 teilbaren Speicheradresse beginnen. Funktionsdeklaration:
 * void memdump(unsigned char *string, int zeilen)
 * 
 * Als Test für das Speicherabbild soll eine Zeichenkette dienen, die auf der Kommandozeile als Parameter des Programms übergeben wird. 
 * Dazu sollte die main-Funktion folgendermaßen deklariert sein:
 * int main(int argc, char **argv)
 * 
 * Erstellen Sie nun eine Kopie der Zeichenkette auf dem Heap und schreiben Sie eine weitere Funktion, 
 * die in der Kopie ein gesuchtes Zeichen durch ein anderes ersetzt. Das zu suchende und zu ersetztende Zeichen, 
 * sowie die Anzahl auszugebender Dump-Zeilen, seien weitere Parameter des Programms. 
 * Außerdem soll die Funktion sowohl die Anzahl der ausgetauschten Zeichen als auch die letzte Adresse zurückliefern, 
 * auf der das Zeichen getauscht wurde:
 * int memreplace(char *string, char cin, char cout, char **caddr)
 * 
 * Informieren Sie sich hierzu über malloc(), free() und strcpy(). Denken Sie daran, den allozierten Speicher auch wieder freizugeben.
 * Übersetzen Sie Ihr Programm beispielsweise über folgende Kommandozeile und entfernen Sie evtl. auftretende Warnungen des Compilers:
 * gcc -Wall -Wextra -pedantic -o a3 a3.c
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
/**
 * Gibt ein Speicherabbild des übergebenen Strings aus.
 *
 * @param string Zeiger auf den Speicher, der abgebildet werden soll.
 * @param zeilen Anzahl der auszugebenden Zeilen, jede Zeile enthält 16 Bytes.
 */
void memdump(unsigned char *string, int zeilen) {
    // Header ausgeben
    printf("\033[31mADDR \t \t00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F  0123456789ABCDEF\n");
    
    // Über jede Zeile iterieren
    for (int i = 0; i < zeilen * 16; i += 16) {
        // Speicheradresse ausgeben
        printf("\033[0m%p\t", (void *)(string + i));
        
        // Hexadezimale Werte des Speicherinhalts ausgeben
        for (int j = 0; j < 16; j++) {
            printf("%02x ", string[i + j]);
        }
        
        // Leerzeichen als Trennzeichen ausgeben
        printf(" ");
        
        // ASCII-Darstellung des Speicherinhalts ausgeben
        for (int j = 0; j < 16; j++) {
            unsigned char ch = string[i + j];
            printf("%c", (ch >= 32 && ch <= 126) ? ch : '.');
        }
        
        // Neue Zeile am Ende jeder Zeile ausgeben
        printf("\n");
    }
}
/**
 * Gibt ein Speicherabbild des übergebenen Strings aus und hebt geänderte Zeichen hervor.
 *
 * @param string Zeiger auf den Speicher, der abgebildet werden soll.
 * @param original Zeiger auf den ursprünglichen Speicher, um Änderungen zu erkennen.
 * @param zeilen Anzahl der auszugebenden Zeilen, jede Zeile enthält 16 Bytes.
 */
void memdump_highlight(unsigned char *string, unsigned char *original, int zeilen) {
    // Header ausgeben
    printf("\033[31mADDR \t \t00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F  0123456789ABCDEF\n");
    
    // Über jede Zeile iterieren
    for (int i = 0; i < zeilen * 16; i += 16) {
        // Speicheradresse ausgeben
        printf("\033[0m%p\t", (void *)(string + i));
        
        // Hexadezimale Werte des Speicherinhalts ausgeben
        for (int j = 0; j < 16; j++) {
            if (string[i + j] != original[i + j]) {
                // Geänderte Zeichen in grüner Farbe ausgeben
                printf("\033[32m%02x \033[0m", string[i + j]);
            } else {
                printf("%02x ", string[i + j]);
            }
        }
        
        // Leerzeichen als Trennzeichen ausgeben
        printf(" ");
        
        // ASCII-Darstellung des Speicherinhalts ausgeben
        for (int j = 0; j < 16; j++) {
            unsigned char ch = string[i + j];
            if (string[i + j] != original[i + j]) {
                // Geänderte Zeichen in grüner Farbe ausgeben
                printf("\033[32m%c\033[0m", (ch >= 32 && ch <= 126) ? ch : '.');
            } else {
                printf("%c", (ch >= 32 && ch <= 126) ? ch : '.');
            }
        }
        
        // Neue Zeile am Ende jeder Zeile ausgeben
        printf("\n");
    }
}


/**
 * Ersetzt alle Vorkommen eines Zeichens in einem String durch ein anderes Zeichen.
 *
 * @param string Der zu durchsuchende und zu ersetzende String.
 * @param cin Das zu suchende Zeichen.
 * @param cout Das zu ersetzende Zeichen.
 * @param caddr Zeiger auf die Adresse des letzten ersetzten Zeichens.
 * @return Die Anzahl der ersetzten Zeichen.
 */
int memreplace(char *string, char cin, char cout, char **caddr) {
    int count = 0; // Zähler für die Anzahl der ersetzten Zeichen
    char *last_addr = NULL; // Zeiger auf die letzte Adresse, an der das Zeichen ersetzt wurde
    
    // Über den gesamten String iterieren
    for (char *p = string; *p != '\0'; p++) {
        // Wenn das aktuelle Zeichen dem zu suchenden Zeichen entspricht
        if (*p == cin) {
            *p = cout; // Ersetze das Zeichen
            last_addr = p; // Speichere die Adresse des ersetzten Zeichens
            count++; // Erhöhe den Zähler
        }
    }
    
    *caddr = last_addr; // Setze die Adresse des letzten ersetzten Zeichens
    return count; // Gib die Anzahl der ersetzten Zeichen zurück
}

/**
 * Hauptfunktion des Programms.
 *
 * @param argc Anzahl der übergebenen Argumente.
 * @param argv Array der übergebenen Argumente.
 * @return 0 bei Erfolg, 1 bei Fehlern.
 */

int main(int argc, char **argv) {
    if (argc != 5) {
        fprintf(stderr, "Usage: %s <string> <cin> <cout> <zeilen>\n", argv[0]);
        return 1;
    }

    char *input = argv[1];
    char cin = argv[2][0];
    char cout = argv[3][0];
    int zeilen = atoi(argv[4]);

    size_t length = strlen(input) + 1; // Länge der Zeichenkette inklusive Nullterminator
    char *heap_copy = (char *)malloc(length); // Speicher auf dem Heap allozieren

    // Überprüfen, ob die Speicherallokation erfolgreich war
    if (!heap_copy) {
        perror("Failed to allocate memory");
        return 1;
    }
    strcpy(heap_copy, input); // Zeichenkette auf den Heap kopieren

    printf("Laenge der Zeichenkette (inkl. \\0): %zu Byte(s)\n", length);
    printf("Ersetzen: '%c' mit '%c'\n", cin, cout);

    char *last_address = NULL;
    int replacements = memreplace(heap_copy, cin, cout, &last_address); // Zeichen ersetzen

    printf("Das Suchzeichen wurde %d mal gefunden und ersetzt,\n", replacements);
    if (last_address) {
        printf("das letzte Mal an Addr. %p\n", (void *)last_address);
    }

    printf("\nOriginal Speicherabbild:\n");
    memdump((unsigned char *)input, zeilen); // Speicherabbild des Originalstrings ausgeben

    //printf("\nSpeicherabbild nach Ersetzung:\n");
    //memdump((unsigned char *)heap_copy, zeilen); // Speicherabbild des modifizierten Strings ausgeben

    printf("\nSpeicherabbild nach Ersetzung (geänderte Zeichen hervorgehoben):\n");
    memdump_highlight((unsigned char *)heap_copy, (unsigned char *)input, zeilen); // Speicherabbild des modifizierten Strings mit Hervorhebung der geänderten Zeichen ausgeben

    free(heap_copy); // Allokierten Speicher freigeben
    return 0;
}