.global _start

.text
.code16
_start:
    jmp .

.space 510-(.-_start)
.word 0xaa55

;gcc -Wl,--oformat=binary -Wl,-Ttext=0x7c00 -Wl,--build-id=none -nostartfiles -nostdlib -m32 -o boot.bin boot.s
; [Calculating padding length with GAS AT&T directives for a boot sector?]
; (https://stackoverflow.com/questions/47859273/calculating-padding-length-with-gas-att-directives-for-a-boot-sector)

