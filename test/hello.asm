    global   _start

    section  .text
_start:   mov       rax, 1                  ; system call for write
          mov       rdi, 1                  ; file handle 1 is stdout
          mov       rsi, message            ; address of string to output
          mov       rdx, 13                 ; number of bytes
          syscall                           ; invoke operating system to do the write

        mov rax, _start
        mov rax, [_start]
        mov rax, message
        mov rax, [message]


          mov       rax, 60                 ; system call for exit
          xor       rdi, rdi                ; exit code 0
          syscall                           ; invoke operating system to exit


    section .data
message db    0x55,0x56,0x57 ,'hello',13,10,'$',10

; nasm -felf64 hello.asm && ld hello.o && ./a.out