        global  main    
        extern  printf
        extern  puts
        extern  atoi

        section .text

main:
        push    r12
        push    r13
        push    r14

        cmp     rdi,3           ; mush have exactly two arguments
        jne     error1
        
        mov     r12, rsi        ;argv

; We will use ecx to count down form the exponent to zero, esi to hold the
; value of the base, and eax to hold the running product.

        mov     rdi, [r12+16]   ;argv[2]
        call    atoi
        cmp     eax, 0
        jl      error2
        mov     r13d, eax       ; y in r13d

        mov     rdi, [r12+8]    ;argv
        call    atoi
        mov     r14d, eax       ; x in r14d

        mov     eax, 1

check:
        test    r13d, r13d
        jz      gotit
        imul    eax, r14d
        dec     r13d
        jmp     check

gotit:  
        mov     rdi, answer
        movsxd  rsi, eax
        xor     rax, rax
        call    printf
        jmp     done

error1:
        mov     edi, badArgumentCount
        call    puts
        jmp     done

error2:
        mov     edi, negativeExponent
        call    puts

done:
        pop     r14
        pop     r13
        pop     r12
        ret

answer:
        db      "%d", 10, 0
badArgumentCount:
        db      "Requires exactly two arguments", 10, 0
negativeExponent:
        db      "The exponent may not be negative", 10, 0

; nasm -felf64 power.asm && gcc -no-pie -o power power.o
