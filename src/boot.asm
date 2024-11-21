bits 16
org 0x7c00

; Print 'H'
mov ah, 0x0E
mov al, 'H'
int 0x10          ; Print 'H'

; Debug: Print '1' to indicate progress
mov al, '1'
int 0x10          ; Print '1'

; Print 'i'
mov al, 'i'
int 0x10          ; Print 'i'

; Debug: Print '2' to indicate progress
mov al, '2'
int 0x10          ; Print '2'

; Halt
cli
hlt

; Pad the bootloader to 510 bytes
times 510-($-$$) db 0

; Boot signature
dw 0xAA55
