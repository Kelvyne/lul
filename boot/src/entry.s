[org 0x7c00]

[bits 16]
; Load kernel code

; Switch to protected mode
jmp switch_protected

[bits 32]
protected_entry:
mov esi, BONJOUR_STR
call protected_print

jmp $

; Switch to long mode

%include "protected.s"

BONJOUR_STR db 'Bonjour', 0


; switch to kernel execution
times 510 - ($-$$) db 0
dw 0xAA55
