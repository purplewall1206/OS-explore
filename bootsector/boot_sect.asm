; A simple boot sector program that loops forever
loop:
    jmp loop

times 510-($-$$) db 0
dw 0xaa55

;nasm -f bin boot_sect.asm -o boot_sect.bin
;qemu-system-x86_64 boot_sect.bin
;这里面的$表示当前指令的地址，$$表示程序的起始地址