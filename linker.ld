ENTRY(kernel_main)

SECTIONS {
    . = 0x100000; /* Kernel starts at 1 MB */

    .text : {
        *(.text) /* Code section */
    }

    .data : {
        *(.data) /* Initialized data */
    }

    .bss : {
        *(.bss)  /* Uninitialized data */
        . = ALIGN(4);
    }
}