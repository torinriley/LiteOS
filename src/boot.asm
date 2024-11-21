[bits 16]
[org 0x7c00]

; === CONSTANTS ===
PRINT_CHAR equ 0x0E  ; BIOS Print Character function
CLEAR_SCREEN equ 0x03 ; BIOS Clear Screen function

; === BOOTLOADER START ===
start:
    call clear_screen     ; Clear the screen

    ; Debug: Print '1' (start)
    mov ah, PRINT_CHAR
    mov al, '1'
    int 0x10

    ; Print "Hello!"
    mov si, hello_message
    call print_string

    ; Debug: Print '2' (after Hello)
    mov ah, PRINT_CHAR
    mov al, '2'
    int 0x10

    ; Print "Welcome to LiteOS"
    mov si, welcome_message
    call print_string

    ; Debug: Print '3' (after Welcome)
    mov ah, PRINT_CHAR
    mov al, '3'
    int 0x10

    ; Print "Detecting System Vitals..."
    mov si, vitals_message
    call print_string

    ; Debug: Print '4' (before memory detection)
    mov ah, PRINT_CHAR
    mov al, '4'
    int 0x10

    ; Display total memory
    call detect_memory

    ; Debug: Print '5' (after memory detection)
    mov ah, PRINT_CHAR
    mov al, '5'
    int 0x10

    ; Hang the CPU in an infinite loop
    jmp $

; === FUNCTIONS ===

; Print a string to the screen
print_string:
    pusha                 ; Save registers
    mov ah, PRINT_CHAR    ; BIOS Teletype function
.next_char:
    lodsb                 ; Load next byte from [SI]
    or al, al             ; Check if null terminator (AL == 0)
    jz .done              ; Exit loop if null
    int 0x10              ; Print the character in AL
    jmp .next_char        ; Loop for next character
.done:
    popa                  ; Restore registers
    ret

; Clear the screen
clear_screen:
    mov ah, CLEAR_SCREEN  ; BIOS Clear Screen function
    mov al, 0x03          ; Text mode 80x25
    int 0x10
    ret

; Detect system memory and display it
detect_memory:
    pusha
    mov ah, 0x88          ; BIOS Get Memory Size function
    int 0x15              ; AX = Total memory in KB
    jc .error             ; If carry flag is set, error occurred
    mov si, mem_message
    call print_string     ; Print "Total Memory: "
    mov ax, cx            ; Load memory size into AX (from BIOS)
    call print_number     ; Print the memory size in KB
    mov si, kb_message
    call print_string     ; Print " KB"
    popa
    ret
.error:
    mov si, error_message
    call print_string
    popa
    ret

; Print a number to the screen
print_number:
    pusha
    xor dx, dx            ; Clear DX (high part of dividend)
    mov bx, 10            ; Divisor: Base 10
.divide:
    div bx                ; Divide AX by BX, remainder in DX
    push dx               ; Save remainder (digit)
    cmp ax, 0             ; Check if quotient is zero
    jne .divide           ; Continue if not zero
.print_digits:
    pop dx                ; Retrieve digit
    add dl, '0'           ; Convert remainder to ASCII
    mov ah, PRINT_CHAR
    mov al, dl
    int 0x10              ; Print digit
    or sp, sp             ; Check if stack is empty
    jnz .print_digits     ; Continue if stack is not empty
    popa
    ret

; === DATA ===
hello_message db "Hello!", 0
welcome_message db 0x0D, 0x0A, "Welcome to LiteOS", 0
vitals_message db 0x0D, 0x0A, "Detecting System Vitals...", 0
mem_message db 0x0D, 0x0A, "Total Memory: ", 0
kb_message db " KB", 0
error_message db 0x0D, 0x0A, "Error detecting memory!", 0

; === BOOT SIGNATURE ===
times 510 - ($ - $$) db 0
dw 0xAA55