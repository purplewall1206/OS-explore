#include "../drivers/screen.h"
#include "../cpu/isr.h"
#include "../cpu/idt.h"
#include "../cpu/timer.h"
#include "../drivers/keyboard.h"
#include "kernel.h"
#include "../libc/string.h"

void main() {
    clear_screen();
    isr_install();
    // __asm__ __volatile__("int $2");
    // __asm__ __volatile__("int $3");
    // asm volatile("sti");
    // init_timer(50);

    // init_keyboard();
    kprint("Type something, it will go through the kernel\n"
        "Type END to halt the CPU\n> ");
}

void user_input(char *input) {
    if (strcmp(input, "END") == 0) {
        kprint("Stopping the CPU.Bye\n");
        asm volatile("hlt");
    }
    kprint("You said: ");
    kprint(input);
    kprint("\n> ");
}