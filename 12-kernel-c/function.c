int my_function() {
    return 0xbeef;
}

// gcc-4.9 -ffreestanding -m32 -c function.c -o function.o
// ld -melf_i386 -o function.bin -Ttext 0x0 --oformat binary function.o

// gcc -ffreestanding -m32 -no-pie -fno-pic  -c function.c -o function1.o
// ld -melf_i386  -o function1.bin -Ttext 0x0 --oformat binary function1.o

// ndisasm -b 32 function.bin

// diff -s  function.disasm function1.disasm 
// 檔案 function.disasm 和 function1.disasm 相同