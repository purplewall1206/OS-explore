int my_function() {
    return 0xbeef;
}

// gcc-4.9 -ffreestanding -m32 -c function.c -o function.o
// ld -o function.bin -Ttext 0x0 --oformat binary function.o

// gcc -ffreestanding -m32 -no-pie -fno-pic  -c function.c -o function1.o
// ld -melf_i386  -o function1.bin -Ttext 0x0 --oformat binary function1.o