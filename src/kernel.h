#ifndef FRAMEBUFFER_H
#define FRAMEBUFFER_H

#include <stdint.h>

// Framebuffer base address (for ARM VersatilePB platform)
#define FRAMEBUFFER_BASE 0x10000000

// Framebuffer resolution
#define FRAMEBUFFER_WIDTH  640
#define FRAMEBUFFER_HEIGHT 480

// Function to initialize the framebuffer (if needed)
void framebuffer_init();

// Function to draw a single pixel
void framebuffer_draw_pixel(int x, int y, uint32_t color);

// Function to clear the screen
void framebuffer_clear(uint32_t color);

#endif // FRAMEBUFFER_H
