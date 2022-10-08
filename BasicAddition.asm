format PE console                               ;architecture compilation format
entry main                                      ;this is the what the compiler will look for to start
include 'macro/import32.inc'                    ;this is just a plugin that makes macro asm easier

section 'data' data readable writable           ;this is where our variables are
        intro db 'Enter in number 1 :)',10,0                                 ;,0 = nulspace
        introResp dw 0 ,0
        intro2 db 'Enter in number 2 :))',10,0
        intro2Resp dw 0,0
        p db 'pause>nul',10,0                         ;,10 = newline
        x db '%x' ,0
        s db '%s' ,0
        sf db '',0,0,0,0,0,0,0,0,0
        res db 'Yay!', 0
        res_sad db ':(', 0




        ;more vars here

section '.code' code readable executable        ;this is where execution will start
        main:
                push ebp
                mov ebp, esp
                push intro
                call [printf]
                push introResp          ;must dereferece numbers here like this
                push x
                call [scanf]
                push intro2
                push s
                call [printf]
                push intro2Resp          ;must dereferece numbers here like this
                push x
                call [scanf]
                mov ecx, dword [intro2Resp]
                add ecx, dword [introResp]
                ;prints the answer
                push ecx
                push x
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
