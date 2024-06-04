section .bss
    num1 resd 1        ; reserve for num1
    num2 resd 1        ; reserve for num2
    op resb 1          ; reserve for operation
    result resd 1      ; reserve for result

section .data
    retint db "Output:", 0x7, 0
    num1p db "Number 1: ", 0xa, 0
    opp db "Operation: ", 0xb, 0
    num2p db "Number 2: ", 0xa, 0
    addx db "+", 0x1, 0
    subx db "-", 0x1, 0
    multx db "*", 0x1, 0
    divx db "/", 0x1, 0

section .text
    global _start

_start:

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;       Get Inputs       ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ; Number 1 Prompt
    mov rax, 0x1         ; write() syscall (0x1)
    mov rdi, 0x1         ; stdout (0x1)
    mov rsi, num1p       ; store prompt itself
    mov rdx, 0xa         ; store length of this prompt
    syscall              ; initiate syscall

    ; Number 1 Read
    mov rax, 0x0         ; read() syscall (0x0)
    mov rdi, 0x0         ; stdin (0x0)
    mov rsi, num1        ; store to num1
    mov rdx, 0x4         ; bytes for num1
    syscall              ; initiate syscall

    ; Operation Prompt
    mov rax, 0x1         ; write() syscall (0x1)
    mov rdi, 0x1         ; stdout (0x1)
    mov rsi, opp         ; store prompt itself
    mov rdx, 0xb         ; store length of this prompt
    syscall              ; initiate syscall

    ; Operation Read
    mov rax, 0x0         ; read() syscall (0x0)
    mov rdi, 0x0         ; stdin (0x0)
    mov rsi, op          ; store to op
    mov rdx, 0x1         ; bytes for operator
    syscall              ; initiate syscall

    ; Number 2 Prompt
    mov rax, 0x1         ; write() syscall (0x1)
    mov rdi, 0x1         ; stdout (0x1)
    mov rsi, num2p       ; store prompt itself
    mov rdx, 0xa         ; store length of this prompt
    syscall              ; initiate syscall

    ; Number 2 Read
    mov rax, 0x0         ; read() syscall (0x0)
    mov rdi, 0x0         ; stdin (0x0)
    mov rsi, num2        ; store to num2
    mov rdx, 0x4         ; bytes for num2
    syscall              ; initiate syscall

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;        Calculate       ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    movzx eax, byte [op] ; Store bytes of op into eax register
    cmp eax, '+'
    je add_func
    cmp eax, '-'
    je subtract_func
    cmp eax, '*'
    je multiply_func
    cmp eax, '/'
    je divide_func

add_func:
    mov eax, dword [num1]
    mov ebx, dword [num2]
    add eax, ebx
    mov dword [result], eax
    jmp output_result

subtract_func:
    mov eax, dword [num1]
    mov ebx, dword [num2]
    sub eax, ebx
    mov dword [result], eax
    jmp output_result

multiply_func:
    mov eax, dword [num1]
    mov ebx, dword [num2]
    imul eax, ebx
    mov dword [result], eax
    jmp output_result

divide_func:
    mov eax, dword [num1]
    mov ebx, dword [num2]
    xor edx, edx         ; Clear edx for division
    div ebx
    mov dword [result], eax
    jmp output_result

output_result:
    ; Still need to handle correct string conversion and printing
    mov eax, 0x1         ; write() syscall
    mov rdi, 0x1         ; stdout
    mov rsi, retint      ; output text
    mov rdx, 0x7         ; length of text
    syscall

    mov eax, 0x60        ; exit() syscall
    xor edi, edi         ; exit code 0
    syscall
