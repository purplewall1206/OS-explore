C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)
# Nice syntax for file extension replacement
OBJ = ${C_SOURCES:.c=.o}


CC = gcc
GDB = gdb

CFLAGS =  -ffreestanding -fno-stack-protector -z execstack -m32 -no-pie -fno-pic 
LDFLAGS=  -melf_i386

os-image.bin: boot/bootsect.bin kernel.bin
	cat $^ > os-image.bin

kernel.bin: boot/kernel_entry.o ${OBJ}
	ld ${LDFLAGS} -o $@ -Ttext 0x1000 $^ --oformat binary

kernel.elf: boot/kernel_entry.o ${OBJ}
	ld ${LDFLAGS} -o $@ -Ttext 0x1000 $^

run: os-image.bin
	qemu-system-x86_64  -fda os-image.bin

debug: os-image.bin kernel.elf
	qemu-system-x86_64 -s -S -fda os-image.bin & 
	${GDB} -ex "target remote localhost:1234" -ex "symbol-file kernel.elf" -ex "break *0x7c00" -ex "break main" -ex "c" -ex "c" 

%.o: %.asm
	nasm $< -f elf -o $@

%.o: %.c ${HEADERS}
	${CC} ${CFLAGS} -c $< -o $@

%.bin: %.asm
	nasm $< -f bin -o $@

clean:
	rm -rf *.bin *.dis *.o os-image.bin *.elf
	rm -rf kernel/*.o boot/*.bin drivers/*.o boot/*.o

