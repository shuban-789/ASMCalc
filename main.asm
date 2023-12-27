section .bss
    num1 resd 1 ; reserve for num1
    num2 resd 1 ; reserve for num2
    op resb 1 ; reserve for operation

section .data
    retint db "Output:",0x7
    num1p db "Number 1: ",0xa
    opp db "Operation: ",0xb
    num2p db "Number 2: ",0xa

section .text
    global _start

    _start
    ; Number 1 Prompt
    mov eax,0x4 ; write() syscall
    mov ebx,0x1 ; stdout
    mov ecx,num1p ; store prompt itself
    mov edx,0xa ; store length of this prompt
    int 0x80 ; initiate syscalls

    ; Number 1 Read
    mov eax,0x3 ; read() syscall
    mov ebx,0x0 ; stdin
    mov ecx,num1 ; store to num1
    mov edx,0x4 ; bytes for num1

    ; Operation Prompt
    mov eax,0x4 ; write() syscall
