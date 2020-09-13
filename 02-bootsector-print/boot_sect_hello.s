.global _start

.text
.code16
_start:
mov $0x0e, %ah
mov $'H', %al
int $0x10
mov $'E', %al
int $0x10
mov $'L', %al
int $0x10
int $0x10
mov $'O', %al
int $0x10

jmp .

.space 510-(.-_start)
.word 0xaa55
// gcc -Wl,--oformat=binary -Wl,-Ttext=0x7c00 -Wl,--build-id=none -nostartfiles -nostdlib -m32 -o boot_sect_hello.bin boot_sect_hello.s
