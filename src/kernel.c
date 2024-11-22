#include <stdint.h>

// VGA text buffer address
volatile char* video_memory = (volatile char*)0xB8000;

void kernel_main() {
    video_memory[0] = 'H'; // Write 'H' at the first character cell
    video_memory[1] = 0x07; // White text on black background

    while (1) {
        __asm__ __volatile__("hlt");
    }
}
