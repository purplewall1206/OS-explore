[bits 16]
switch_to_pm:
    cli ; 1. disable interrupts
    lgdt [gdt_descriptor]  ; 2. load the DGT descriptor
    mov eax, cr0
    or eax, 0x1  ; 3. set 32-bit mode bit in cr0

    mov cr0, eax
    jmp CODE_SEG:init_pm ;4. far jump by using different segment

[bits 32]
init_pm: ; now in 32bit instructions
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000  ;6.update the stack right at the top of the free space
    mov esp, ebp

    ; mov ebx, BITS32
    ; call print_string_pm ;

    call BEGIN_PM


SWITCH_TO db "switch to pm start", 0
SWITCH_TO1 db "switch to pm 1", 0
BITS32   db  "switch to 32 bits", 0
