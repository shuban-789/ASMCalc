.data

prompt1:
    .ascii "Number 1: \n"
prompt2:
    .ascii "Number 2: \n"
prompt3:
    .ascii "Operation: \n"
retint:
    .ascii "Output: \n"

.bss
    .lcomm num1, 4
    .lcomm num2, 4
    .lcomm op, 1
    .lcomm result, 4

.text
.global _start

_start:
    ; Write prompt1
    ldr x0, =1          ; stdout
    ldr x1, =prompt1    ; pointer to prompt1
    ldr x2, =11         ; length of prompt1
    mov x8, 64          ; syscall number for write (64 in ARM)
    svc 0               ; make syscall

    ; Read num1
    ldr x0, =0          ; stdin
    ldr x1, =num1       ; address to store num1
    mov x2, 4           ; bytes to read
    mov x8, 63          ; syscall number for read (63 in ARM)
    svc 0               ; make syscall

    ; Write prompt3
    ldr x0, =1          ; stdout
    ldr x1, =prompt3    ; pointer to prompt3
    ldr x2, =11         ; length of prompt3
    mov x8, 64          ; syscall number for write
    svc 0               ; make syscall

    ; Read op
    ldr x0, =0          ; stdin
    ldr x1, =op         ; address to store op
    mov x2, 1           ; byte to read
    mov x8, 63          ; syscall number for read
    svc 0               ; make syscall

    ; Write prompt2
    ldr x0, =1          ; stdout
    ldr x1, =prompt2    ; pointer to prompt2
    ldr x2, =11         ; length of prompt2
    mov x8, 64          ; syscall number for write
    svc 0               ; make syscall

    ; Read num2
    ldr x0, =0          ; stdin
    ldr x1, =num2       ; address to store num2
    mov x2, 4           ; bytes to read
    mov x8, 63          ; syscall number for read
    svc 0               ; syscall

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;        Calculate       ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    
    ldrb w0, [op]       ; load op into w0
    cmp w0, '+'         ; compare with '+'
    beq add_func
    cmp w0, '-'         ; compare with '-'
    beq subtract_func
    cmp w0, '*'         ; compare with '*'
    beq multiply_func
    cmp w0, '/'         ; compare with '/'
    beq divide_func

add_func:
    ldr w0, [num1]
    ldr w1, [num2]
    add w0, w0, w1
    str w0, [result]
    b output_result

subtract_func:
    ldr w0, [num1]
    ldr w1, [num2]
    sub w0, w0, w1
    str w0, [result]
    b output_result

multiply_func:
    ldr w0, [num1]
    ldr w1, [num2]
    mul w0, w0, w1
    str w0, [result]
    b output_result

divide_func:
    ldr w0, [num1]
    ldr w1, [num2]
    udiv w0, w0, w1
    str w0, [result]
    b output_result

output_result:
    ; Output result (this part is simplified, you would need to convert the result to a string)
    ldr x0, =1          ; stdout
    ldr x1, =retint     ; pointer to retint
    ldr x2, =8          ; length of retint
    mov x8, 64          ; syscall number for write
    svc 0               ; make syscall

    ; Exit
    mov x8, 93          ; syscall number for exit (93 in ARM)
    mov x0, 0           ; exit code 0
    svc 0               ; syscall
