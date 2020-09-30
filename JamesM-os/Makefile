SOURCES=boot.o

CFLAGS= -nostdlib -nostdinc -fno-builtin -fno-stack-protector -m32 -Wall -g -no-pie -fno-pic 
LDFLAGS=-Tlink.ld -m elf_i386
ASFLAGS=-felf -F dwarf -g

all:	$(SOURCES) link

clean:
		-rm *.o kernel

link:
		ld $(LDFLAGS) -o kernel $(SOURCES)

.s.o:
		nasm $(ASFLAGS) $<