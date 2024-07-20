# This will only work on Linux on the x86-64 ISA.
#
# Copyright 2024 (c) Jonathan M. Wilbur. Released under an MIT License.
# 
# Example compilation:
#
# ```bash
# gcc -static ./libs/stdio.s ./test.c -o yeet
# ```

# Export the symbols so they can be linked.
.globl syscall1
.globl syscall3

# Perform a Linux system call with three arguments.
syscall1:
    # The first argument becomes the syscall number.
    mov %rdi, %rax
    # The second argument (rsi) becomes the first argument (rdi).
    mov %rsi, %rdi
    # Then we perform the system call.
    syscall
    # Then we return.
    ret

# Perform a Linux system call with three arguments.
syscall3:
    # The first argument becomes the syscall number.
    mov %rdi, %rax
    # The second argument (rsi) becomes the first argument (rdi).
    mov %rsi, %rdi
    # The third argument (rdx) becomes the second argument (rsi).
    mov %rdx, %rsi
    # The fourth argument (rcx) becomes the third argument (rdx).
    # You might be wondering: why use rcx instead of r10?
    # This is because non-system-call function calls use rcx for the fourth
    # argument. System calls use r10 for the fourth argument.
    # See: https://stackoverflow.com/questions/32253144/why-is-rcx-not-used-for-passing-parameters-to-system-calls-being-replaced-with
    mov %rcx, %rdx
    # Then we perform the system call.
    syscall
    # Then we return.
    ret
