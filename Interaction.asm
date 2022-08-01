format PE console                               ;fasm console formatter
entry main                                      ;tells the computer to start at pointer "main"

include 'macro/import32.inc'                    ;imports multipurpose macro assembler

section 'data' data readable writeable
        msg1 db 'Hello!',10,0
        msg2 db 'Want to test cmp [y/x]? ',0
        n db 'n',0
        resp db '' ,0
        formatin db '%c',0
        yresp db 'you said y!',10,0
        nresp db 'you said something other than y!',10,0
        exiting db 'exiting...',10,0
        p db 'pause>nul',10,0                   ;this pauses until a key is pressed in the batch

section '.code' code readable executable        ;shows where the code starts
        main:                                   ;main pointer
                push ebp                        ;sets up the stack
                mov ebp, esp                    ;sets up the stack
                sub ebp, 1
                mov dword [esp], msg1
                call [printf]
                mov dword [esp], p
                call [system]
                mov dword [esp], msg2
                call [printf]
                add esp, 8
                jmp conditional$
        conditional$:
                ;testing
                push resp
                push formatin
                call [scanf]
                mov ecx, resp
                cmp byte [ecx], 0x79
                je end$
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
        scanf, 'scanf',\                        ;declares external function scanf
        exit,'exit'                             ;declares external function exit
