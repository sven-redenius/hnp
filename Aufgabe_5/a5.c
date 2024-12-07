#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//Funktion die in Assembler geschrieben wurde
extern unsigned short addsub(int op1, int op2, char what, int *res);

/**
 * Gibt die Flags aus
 * @param flags Flags die ausgegeben werden sollen
 * @return void
 */
void print_flags(unsigned short flags) {
    printf("Flags:\n");
    printf("O D I T S Z A P C\n");
    for (int i = 11; i >= 0; i--) {
        printf("%d ", (flags >> i) & 1);
        }
    printf("\n");
    }
    

    /**
     * Main Funktion
     * @param argc Anzahl der Argumente
     * @param argv Argumente
     */
    int main(int argc, char *argv[]) {
    //Prüfen ob genug Argumente übergeben wurden
    if (argc != 4) {
        fprintf(stderr, "Nutzen Sie folgendes Format: ./a5 <Operand1> +/- <Operand2>\n");
        return 1;
    }

    //Argumente in Variablen speichern
    int op1 = atoi(argv[1]);
    int op2 = atoi(argv[3]);
    char what = argv[2][0];
    int res = 0;
    unsigned short flags = addsub(op1, op2, what, &res);

    //Ausgabe
    print_flags(flags);

    printf("\nErgebnis und Operanden Signed:\n");
    printf("%d %c %d = %d (Ergebnis ist %s!)\n", op1, what, op2, res, (flags & 0x800) ? "falsch" : "richtig");

    printf("\nErgebnis und Operanden Unsigned:\n");
    printf("%u %c %u = %u (Ergebnis ist %s!)\n", (unsigned char)op1, what, (unsigned char)op2, (unsigned char)res, (flags & 0x800) ? "falsch" : "richtig");

    return 0;
}
