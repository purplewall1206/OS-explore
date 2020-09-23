#include "util.h"
#include "../drivers/screen.h"
#include "../cpu/isr.h"
#include "../cpu/idt.h"
#include "../cpu/timer.h"
#include "../drivers/keyboard.h"

void main() {
    clear_screen();
    isr_install();
    // __asm__ __volatile__("int $2");
    // __asm__ __volatile__("int $3");
    asm volatile("sti");
    init_timer(50);

    init_keyboard();
}