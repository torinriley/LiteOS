#include "framebuffer.h"

void framebuffer_draw_pixel(int x, int y, uint32_t color) {
    // Calculate the memory location of the pixel
    uint32_t* framebuffer = (uint32_t*)FRAMEBUFFER_BASE;
    framebuffer[y * FRAMEBUFFER_WIDTH + x] = color;
}

void framebuffer_clear(uint32_t color) {
    uint32_t* framebuffer = (uint32_t*)FRAMEBUFFER_BASE;
    for (int y = 0; y < FRAMEBUFFER_HEIGHT; y++) {
        for (int x = 0; x < FRAMEBUFFER_WIDTH; x++) {
            framebuffer[y * FRAMEBUFFER_WIDTH + x] = color;
        }
    }
}

void framebuffer_init() {
    // Framebuffer initialization code (if needed)
    // For most QEMU setups, the framebuffer is pre-initialized, so this may be empty
}

