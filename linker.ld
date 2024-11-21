ENTRY(kernel_main)

SECTIONS {
    . = 0x1000; /* Kernel starts at memory address 0x1000 */

    .text : {
        *(.text)       /* Code section */
    }

    .rodata : {
        *(.rodata*)    /* Read-only data section */
    }

    .data : {
        *(.data)       /* Initialized data section */
    }

    .bss : {
        *(COMMON)      /* Uninitialized data section */
        *(.bss)
    }
}