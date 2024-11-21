ENTRY(kernel_main)

SECTIONS
{
    . = 0x100000; /* Kernel loaded at 1MB */

    .text : {
        *(.text) /* Code section */
    }

    .rodata : {
        *(.rodata) /* Read-only data */
    }

    .data : {
        *(.data) /* Initialized data */
    }

    .bss : {
        *(COMMON)
        *(.bss) /* Uninitialized data */
        . = ALIGN(4);
    }
}
