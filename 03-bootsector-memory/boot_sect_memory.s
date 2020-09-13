

.global _start

.data
// the_secret: .ascii "X" 如果在这里定义，那么后面无法显示X

.text
.code16
_start:

mov $0x0e, %ah


mov $'1', %al
int $0x10
mov the_secret, %al
// 此处对应的取地址指令是 mov $the_secret, %al 或 lea the_secret，%al 但是这两个任何一个都没办法通过编译，比较诡异
int $0x10


mov $'2', %al
int $0x10
mov (the_secret), %al
int $0x10


mov $'3', %al
int $0x10
mov the_secret, %bx
add $0x7c00, %bx
mov (%bx), %al
int $0x10

mov $'4', %al
int $0x10
mov 0x7c2d, %al
int $0x10

jmp .

the_secret: .ascii "X"

.space 510-(.-_start)
.word 0xaa55

// 1X2X3 4符号
// 1@2@3X4X
