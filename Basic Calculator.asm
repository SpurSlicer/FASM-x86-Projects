format PE console                               ;architecture compilation format
entry main                                      ;this is the what the compiler will look for to start
include 'macro/import32.inc'                    ;this is just a plugin that makes macro asm easier

section 'data' data readable writable           ;this is where our variables are
        intro db 'a = add; s = sub; m = mult; d = div; p = pow: ',0                                 ;,0 = nulspace
        input db '' ,0
        num dw 0,0
        num2 dw 0,0
        getnum db 'Enter num 1: ',0
        getnum2 db 'Enter num 2: ',0
        error_resp db 'Enter in something valid. Try again',10,0
        intro2 db 'Enter in number 2 :))',10,0
        intro2Resp dw 0,0
        result db 'Your result is: ',0
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
                ;intro section
                push intro
                call [printf]
                push input          ;must dereferece numbers here like this
                push s
                call [scanf]
                ;gets first number
                push getnum
                call [printf]
                push num
                push x
                call [scanf]
                ;gets second number
                push getnum2
                call [printf]
                push num2
                push x
                call [scanf]
                cmp [input], 0x64
                je div$
                cmp [input], 0x6D
                je mul$
                cmp [input], 0x61
                je add$
                cmp [input], 0x73
                je sub$
                cmp [input], 0x70
                je pow$
                push error_resp
                call [printf]
                jmp main
       div$:
                mov edx, 0
                mov eax, dword [num]
                mov ecx, dword [num2]
                idiv ecx
                mov edi, eax
                jmp result$
       mul$:
                mov edi, dword [num]
                imul edi, dword [num2]
                jmp result$
       add$:
                mov edi, dword [num]
                add edi, dword [num2]
                jmp result$
       sub$:
                mov edi, dword [num]
                sub edi, dword [num2]
                jmp result$
       pow$:
                mov esi, 1
                mov edi, dword [num]
                loop$:
                cmp esi, dword [num2]
                je result$
                imul edi, dword [num]
                inc esi
                jmp loop$

        result$:
                push result
                call [printf]
                push edi
                push x
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