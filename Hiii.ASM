format PE console                               ;architecture compilation format
entry main                                      ;this is the what the compiler will look for to start
include 'macro/import32.inc'                    ;this is just a plugin that makes macro asm easier

section 'data' data readable writable           ;this is where our variables are
        var db 'Hi',10,0                                 ;,0 = nulspace
        var2 db 'How are you?',10,0
        p db 'pause>nul',10,0                         ;,10 = newline
        s db '%s' ,0
        sf db '',0,0,0,0,0,0,0,0,0
        res db 'Yay!', 0
        res_sad db ':(', 0

        ;more vars here

section '.code' code readable executable        ;this is where execution will start
        main:
                push ebp
                mov ebp, esp
                push sf
                push s
                call [scanf]
                cmp word [sf], 0x78
                je result$
                push res_sad
                call [printf]
                push p
                call [system]
                call [exit]

        result$:
                push res
                call [printf]
                push p
                call [system]
                call [exit]
                ;retn would be here


section '.idata' import data readable           ;declares imported data section from import32
        library msvcrt, 'msvcrt.dll'            ;downloads a .dll library
        import msvcrt,\                         ;imports said library
        printf, 'printf',\                      ;declares external function printf
        system, 'system',\                      ;declares external function system
        scanf, 'scanf',\                        ;declares external function scanf
        exit,'exit'