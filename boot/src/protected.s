[bits 16]

; GDT
; A simple GDT is to have 2 entries that overlap and point to the same
; physical memory : one for the code and one for data
; see http://wiki.osdev.org/Global_Descriptor_Table
gdt_start:

; Empty entry
dd 0
dd 0

gdt_code_entry:
dd 0xFFFF             ; limit[0:15]=0xFFFF base[0:15]=0x0000
db 0x00               ; base[16:23]=0x00
db 10011010b          ; Access byte
db 11001111b          ; limit[16:19]=0xF flags=1100b
db 0x0                ; base[24:31]=0x00

gdt_data_entry:
dd 0xFFFF             ; limit[0:15]=0xFFFF base[0:15]=0x0000
db 0x00               ; base[16:23]=0x00
db 10010010b          ; Access byte
db 11001111b          ; limit[16:19]=0xF flags=1100b
db 0x0                ; base[24:31]=0x00

gdt_end:

gdt_descriptor:
dw gdt_end - gdt_start - 1
dd gdt_start

code_selector equ gdt_code_entry - gdt_start
data_selector equ gdt_data_entry - gdt_start

; Switch to protected mode.
; We need to disable interrupts and setup GDT.
; We also need to flush the CPU pipeline to be sure everything is fine
; It seems useless to check/enable A20 ?
;
; EBX = addr in code to jump to
switch_protected:
cli ; clear interrupts
lgdt [gdt_descriptor] ; set GDT
mov eax, cr0
or eax, 1
mov cr0, eax ; set least bit of CR0 to enable protected mode
jmp code_selector:switch_protected_setup  ; we use a far jump to flush pipeline
                                          ; this also sets CS register

[bits 32]
switch_protected_setup:
mov ax, data_selector
mov ds, ax
mov es, ax
mov fs, ax
mov gs, ax
mov ss, ax
mov ebp, 0x7FFFF  ; see http://wiki.osdev.org/Memory_Map_(x86)

jmp protected_entry

; Print a string to screen in protected mode
; ESI = string to print
protected_print:
mov edi, 0xb8000 ; see http://wiki.osdev.org/Printing_To_Screen
mov ecx, 0

_protected_print_loop:
mov al, [esi+ecx]
cmp al, 0
jz _protected_print_end
mov ebx, ecx
shl ebx, 1
add ebx, edi
mov [ebx], al
add ebx, 1
mov al, 0xF
mov [ebx], al
inc ecx
jmp _protected_print_loop
_protected_print_end:
ret
