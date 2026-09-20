.section .note.GNU-stack,""
.global calculate
.text

calculate:
    push %rbx

    # Reserve stack space for partial results.
    sub $32, %rsp

    # %rbx = x
    mov %rdi, %rbx

    # a = x + 3
    mov %rbx, %rcx
    add $3, %rcx

    mov %rcx, 0(%rsp)

    # b = f(x, a)
    mov %rbx, %rdi
    mov %rcx, %rsi
    call f

    mov 0(%rsp), %rcx
    mov %rcx, 24(%rsp)

    # Save b.
    mov %rax, 8(%rsp)

    # c = f(b, x)
    mov %rax, %rdi
    mov %rbx, %rsi
    call f

    # Save c.
    mov %rax, 16(%rsp)

    # d = f(x, c)
    mov %rbx, %rdi
    mov %rax, %rsi
    call f

    # return a + b + c + d
    add 24(%rsp), %rax
    add 8(%rsp), %rax
    add 16(%rsp), %rax

    add $32, %rsp
    pop %rbx
    ret