        global      main
        extern      puts
        section     .text
main:
        push    rdi
        push    rsi
        sub     rsp, 8

        mov     rdi, [rsi]
        call    puts

        add     rsp, 8
        pop     rsi
        pop     rdi

        add     rsi, 8                  ; point to next argument
        dec     rdi                     ; count down
        jnz     main                    ; if not done counting keep going

        ret
; On entry, rdi will contain argc and rsi will contain argv.
; nasm -felf64 echo.asm && gcc -no-pie echo.o && ./a.out dog 22 -zzz "hi there"
