//
// Created by Torin Etheridge on 11/20/24.
//

#ifndef KERNAL_H
#define KERNAL_H
#include <stdint.h>
#endif //KERNAL_H

extern "C" [[gnu::section(".multiboot")]]
const uint32_t multiboot_header[4] = {
    0x1BADB002,                      // Magic number
    0x00,                            // Flags
    (uint32_t)(0 - (0x1BADB002 + 0)) // Checksum: sum of all 3 fields must equal 0
};
