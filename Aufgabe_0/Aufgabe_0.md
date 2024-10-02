## 1. Thema: Bits und Bytes - Daten im Computer

### a) Zahlensysteme

| Zahl         | Dezimal | Hexadezimal | Dual       | Speicherbedarf |
|--------------|---------|-------------|------------|----------------|
| 0xFF         | 255     | 0xFF        | 11111111   | 1 Byte         |
| 0b00110001   | 49      | 0x31        | 00110001   | 1 Byte         |
| 515          | 515     | 0x203       | 1000000011 | 2 Bytes        |
| -2           | -2      | -0x2        | -10        | 1 Byte         |

- **NIBBLE**: Ein Nibble ist eine Gruppe von 4 Bits. Es ist die Hälfte eines Bytes.
- **WORD**: Ein Word ist eine Gruppe von 16 Bits (2 Bytes). Die Größe eines Words kann jedoch je nach Computerarchitektur variieren.
- **DOUBLE WORD**: Ein Double Word ist eine Gruppe von 32 Bits (4 Bytes).

### b) Arithmetik und Logik

Führen Sie mit folgenden Operanden folgende arithmetische bzw. logische Operationen im Dualsystem durch und geben Sie das Ergebnis hexadezimal an. Geben Sie zusätzlich den Status folgender Flags an: CF, OF, SF, ZF

#### Operationen

| Operand 1 | Operand 2 | Operation | Ergebnis (Dual) | Ergebnis (Hex) | CF | OF | SF | ZF |
|-----------|-----------|-----------|-----------------|----------------|----|----|----|----|
| 8         | 20        | ADD       | 0011 1000       | 0x28           | 0  | 0  | 0  | 0  |
| 8         | 20        | SUB       | 1110 1100       | 0xEC           | 1  | 1  | 1  | 0  |
| -8        | 13        | AND       | 0000 1000       | 0x08           | -  | -  | 0  | 0  |
| -8        | 13        | OR        | 1111 1101       | 0xFD           | -  | -  | 1  | 0  |
| -1        | -1        | ADD       | 1111 1110       | 0xFE           | 1  | 0  | 1  | 0  |
| -1        | -1        | XOR       | 0000 0000       | 0x00           | -  | -  | 0  | 1  |

- **CF (Carry Flag)**: Wird gesetzt, wenn ein Übertrag aus dem höchstwertigen Bit erfolgt (bei Addition) oder ein Übertrag in das höchstwertige Bit erfolgt (bei Subtraktion).
- **OF (Overflow Flag)**: Wird gesetzt, wenn ein Überlauf auftritt, d.h., wenn das Ergebnis einer Operation nicht in das Zielregister passt.
- **SF (Sign Flag)**: Wird gesetzt, wenn das Ergebnis einer Operation negativ ist.
- **ZF (Zero Flag)**: Wird gesetzt, wenn das Ergebnis einer Operation null ist.

### c) Zahlencodes

Stellen Sie den Gruß “Moin!” als ASCII-kodiertes Bitmuster (hexadezimal) dar.

| Zeichen | ASCII (Hex) |
|---------|--------------|
| M       | 0x4D         |
| o       | 0x6F         |
| i       | 0x69         |
| n       | 0x6E         |
| !       | 0x21         |

Der Gruß "Moin!" als ASCII-kodiertes Bitmuster in hexadezimaler Form lautet: `0x4D 0x6F 0x69 0x6E 0x21`. 
