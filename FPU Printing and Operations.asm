format PE console                               ;architecture compilation format
entry main                                      ;this is the what the compiler will look for to start
include 'macro/import32.inc'                    ;this is just a plugin that makes macro asm easier

section 'data' data readable writable           ;this is where our variables are
        p db 'pause>nul',10,0                         ;,10 = newline
        f db '%f',10,0


        ;more vars here

section '.code' code readable executable        ;this is where execution will start
        main:
                push ebp
                mov esp, ebp


                call [exit]

section '.idata' import data readable           ;declares imported data section from import32
        library msvcrt, 'msvcrt.dll'            ;downloads a .dll library
        import msvcrt,\                         ;imports said library
        printf, 'printf',\                      ;declares external function printf
        system, 'system',\                      ;declares external function system
        scanf, 'scanf',\                        ;declares external function scanf
        exit,'exit'
