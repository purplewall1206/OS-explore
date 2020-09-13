default:
	gcc -Wl,--oformat=binary -Wl,-Ttext=0x7c00 -Wl,--build-id=none -nostartfiles -nostdlib -m32 -o boot_sect_memory.bin boot_sect_memory.s

qemu:
	qemu-system-x86_64 boot_sect_memory.bin