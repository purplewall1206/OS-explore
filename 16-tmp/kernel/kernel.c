#include "../drivers/ports.h"
#include "../drivers/screen.h"

void main() {
    clear_screen();

    int offset_from_vga = 0;

    char *vga = 0xb8000;
    vga[offset_from_vga] = 'X'; 
    vga[offset_from_vga+1] = 0x0f; /* White text on black background */
    
    kprint_at("MMM", 1, 6);
    // kprint_at("This text spans multiple lines", 75, 10);
    // kprint_at("There is a line\nbreak", 0, 20);
    // // kprint("There is a line\nbreak");
    // kprint_at("What happens when we run out of space?", 45, 24);
}