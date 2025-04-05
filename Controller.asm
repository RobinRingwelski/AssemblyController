section .data
    menu db "Simple Controller:", 10
         db "[o] Turn ON device", 10
         db "[f] Turn OFF device", 10
         db "[q] Quit", 10, 0

    on_msg db "Device is now ON.", 10, 0
    off_msg db "Device is now OFF.", 10, 0
    quit_msg db "Exiting controller...", 10, 0
    invalid_msg db "Invalid input. Try again.", 10, 0

section .bss
    input resb 1

section .text
    global _start

_start:
main_loop:
    ; Print menu
    mov eax, 4          ; sys_write
    mov ebx, 1          ; stdout
    mov ecx, menu
    mov edx, 80
    int 0x80

    ; Read user input
    mov eax, 3          ; sys_read
    mov ebx, 0          ; stdin
    mov ecx, input
    mov edx, 1
    int 0x80

    ; Compare input
    mov al, [input]
    cmp al, 'o'
    je turn_on
    cmp al, 'f'
    je turn_off
    cmp al, 'q'
    je quit
    jmp invalid_input

turn_on:
    mov eax, 4
    mov ebx, 1
    mov ecx, on_msg
    mov edx, 20
    int 0x80
    jmp main_loop

turn_off:
    mov eax, 4
    mov ebx, 1
    mov ecx, off_msg
    mov edx, 21
    int 0x80
    jmp main_loop

invalid_input:
    mov eax, 4
    mov ebx, 1
    mov ecx, invalid_msg
    mov edx, 27
    int 0x80
    jmp main_loop

quit:
    mov eax, 4
    mov ebx, 1
    mov ecx, quit_msg
    mov edx, 26
    int 0x80

    ; Exit program
    mov eax, 1          ; sys_exit
    xor ebx, ebx
    int 0x80