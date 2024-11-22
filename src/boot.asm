[bits 16]
[org 0x7c00]

KERNEL_OFFSET equ 0x1000  ; Address to load the kernel
SECTOR_COUNT equ 4        ; Number of sectors to read

start:
    ; Print "Booting..."
    mov ah, 0x0E
    mov al, 'B'
    int 0x10
    mov al, 'o'
    int 0x10
    mov al, 'o'
    int 0x10
    mov al, 't'
    int 0x10
    mov al, '!'
    int 0x10

    ; Load kernel from disk
    mov bx, KERNEL_OFFSET  ; Load address
    mov dh, SECTOR_COUNT   ; Number of sectors
    mov dl, [BOOT_DRIVE]   ; Boot drive
    call disk_load

    ; Jump to the kernel
    jmp KERNEL_OFFSET

disk_load:
    pushab
    mov ah, 0x02           ; BIOS read sectors function
    mov al, dh             ; Number of sectors to read
    mov ch, 0x00           ; Cylinder 0
    mov cl, 0x02           ; Sector 2 (start of kernel)
    mov dh, 0x00           ; Head 0
    int 0x13               ; BIOS disk interrupt
    jc disk_error          ; Handle errors
    popa
    ret

disk_error:
    mov ah, 0x0E
    mov al, 'E'
    int 0x10
    hlt

BOOT_DRIVE db 0
times 510 - ($ - $$) db 0
dw 0xAA55
