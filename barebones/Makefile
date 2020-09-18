default:
	as --32 boot.s -o boot.o
	gcc -m32 -no-pie -fno-pic -z execstack -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
	gcc -m32 -T linker.ld -o myos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

run:
	qemu-system-x86_64 -kernel myos.bin