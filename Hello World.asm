format PE console                               ;fasm console formatter
entry main                                      ;tells the computer to start at pointer "main"

include 'macro/import32.inc'                    ;imports multipurpose macro assembler

section 'data' data readable writeable
        msg db "Hello world!",10,0
        num db 'how are you :)',10,0
        p db "pause>nul",10,0                   ;this pauses until a key is pressed in the batch

section '.code' code readable executable        ;shows where the code starts
        main:                                   ;main pointer
                push ebp                        ;sets up the stack
                mov ebp, esp                    ;sets up the stack
                sub ebp, 1
                mov dword [esp], msg
                call [printf]
                mov dword [esp], p
                call [system]
                mov dword [esp], num
                call [printf]
                mov dword [esp], p
                call [system]
                mov dword [esp], 0
                call [exit]

section '.idata' import data readable           ;declares imported data section from import32
        library msvcrt, 'msvcrt.dll'            ;downloads a .dll library
        import msvcrt,\                         ;imports said library
        printf, 'printf',\                      ;declares external function printf
        system, 'system',\                      ;declares external function system
        getchar, 'getchar',\                    ;declares external function getchar
        exit,'exit'                             ;declares external function exit

