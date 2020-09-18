C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)
# Nice syntax for file extension replacement
OBJ = ${C_SOURCES:.c=.o}


CC = gcc
GDB = gdb

CFLAGS = -g -m32 -no-pie -fno-pic 

os-image.bin: boot/bootsect.bin kernel.bin
	cat $^ > os-image.bin

kernel.bin: boot/kernel_entry.o ${OBJ}
	ld -melf_i386 -o $@ -Ttext 0x1000 $^ --oformat binary

kernel.elf: boot/kernel_entry.o ${OBJ}
	ld -melf_i386 -o $@ -Ttext 0x1000 $^

run: os-image.bin
	qemu-system-x86_64 -m 1G -fda os-image.bin

debug: os-image.bin kernel.elf
	qemu-system-x86_64 -s -S -fda os-image.bin & 
	${GDB} -ex "target remote localhost:1234" -ex "symbol-file kernel.elf" -ex "break *0x7c00"

%.o: %.asm
	nasm $< -f elf -o $@

%.bin: %.asm
	nasm $< -f bin -o $@

clean:
	rm -rf *.bin *.dis *.o os-image.bin *.elf
	rm -rf kernel/*.o boot/*.bin drivers/*.o boot/*.o

