format PE console                               ;fasm console formatter
entry main                                      ;tells the computer to start at pointer "main"

include 'macro/import32.inc'                    ;imports multipurpose macro assembler

section 'data' data readable writeable
        msg1 db 'Hello!',10,0
        msg2 db 'Want to test cmp [y/n]? ',0
        y db 'y',0
        n db 'n',0
        yresp db 'you said y!',10,0
        nresp db 'you said n!',10,0
        exiting db 'exiting...',10,0
        p db 'pause>nul',10,0                   ;this pauses until a key is pressed in the batch

section '.code' code readable executable        ;shows where the code starts
        main:                                   ;main pointer
                push ebp                        ;sets up the stack
                mov ebp, esp                    ;sets up the stack
                sub ebp, 4
                mov edx, y
                mov dword [esp], msg1
                call [printf]
                mov dword [esp], p
                call [system]
                mov dword [esp], msg2
                call [printf]
                mov dword [esp], 0
                jmp conditional$
        conditional$:
                ;testing
                call [getchar]
                and eax, edx
                cmp ebx, 0
                jmp end$
                mov dword [esp], nresp
                call[printf]
                mov dword [esp], p
                call [system]
                ;no more testing
                jmp end$
        end$:
                mov dword [esp], exiting
                call [printf]
                mov dword [esp], p
                call [system]
                call[exit]

section '.idata' import data readable           ;declares imported data section from import32
        library msvcrt, 'msvcrt.dll'            ;downloads a .dll library
        import msvcrt,\                         ;imports said library
        printf, 'printf',\                      ;declares external function printf
        system, 'system',\                      ;declares external function system
        getchar, 'getchar',\                    ;declares external function getchar
        putchar, 'putchar',\
        exit,'exit'                             ;declares external function exit
