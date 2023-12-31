section .bss
    num1 resd 1 ; reserve for num1
    num2 resd 1 ; reserve for num2
    op resb 1 ; reserve for operation

section .data
    retint db "Output:",0x7
    num1p db "Number 1: ",0xa
    opp db "Operation: ",0xb
    num2p db "Number 2: ",0xa
    addx db "+",0x1
    subx db "-",0x1
    multx db "*",0x1
    divx db "/",0x1

section .text
    global _start

    _start

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;       Get Inputs       ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ; Number 1 Prompt
    mov %rax,0x4 ; write() syscall (0x4)
    mov %rdi,0x1 ; stdout (0x1)
    mov %rsi,num1p ; store prompt itself
    mov %rdx,0xa ; store length of this prompt
    int 0x80 ; initiate syscalls

    ; Number 1 Read
    mov %rax,0x3 ; read() syscall (0x3)
    mov %rdi,0x0 ; stdin (0x0)
    mov %rsi,num1 ; store to num1
    mov %rdx,0x4 ; bytes for num1
    int 0x80 ; initiate syscalls

    ; Operation Prompt
    mov %rax,0x4 ; write() syscall (0x4)
    mov %rdi,0x1 ; stdout (0x1)
    mov %rsi,opp ; store prompt itself
    mov %rdx,0xb ; store length of this prompt
    int 0x80 ; initiate syscalls

    ; Operation Read
    mov %rax,0x3 ; read() syscall (0x4)
    mov %rdi,0x0 ; stdin (0x0)
    mov %rsi,opp ; store to op
    mov %rdx,0x1 ; bytes for operator
    int 0x80 ; initiate syscalls

    ; Number 2 Prompt
    mov %rax,0x4 ; write() syscall (0x4)
    mov %rdi,0x1 ; stdout (0x1)
    mov %rsi,num2p ; store prompt itself
    mov %rdx,0xa ; store length of this prompt
    int 0x80 ; initiate syscalls

    ; Number 2 Read
    mov %rax,0x3 ; read() syscall (0x3)
    mov %rdi,0x0 ; stdin (0x0)
    mov %rsi,num2 ; store to num1
    mov %rdx,0x4 ; bytes for num1
    int 0x80 ; initiate syscalls

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;        Calculate       ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
