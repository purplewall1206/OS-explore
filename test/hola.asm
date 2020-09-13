        global  main
        extern puts

        section  .text
main:
        mov  rdi, message
        call puts
        ret

message:
        db   "Hola, mundo", 0 ; Note strings must be terminated with 0 in C

; nasm -felf64 hola.asm && gcc -no-pie hola.o && ./a.out
