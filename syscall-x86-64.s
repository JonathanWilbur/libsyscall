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
.globl syscall0
.globl syscall1
.globl syscall2
.globl syscall3
.globl syscall4
.globl syscall5

# Perform a Linux system call with two arguments.
syscall0:
    # The first argument becomes the syscall number.
    mov %rdi, %rax
    # Then we perform the system call.
    syscall
    # Then we return.
    ret

# Perform a Linux system call with one argument.
syscall1:
    # The first argument becomes the syscall number.
    mov %rdi, %rax
    # The second argument (rsi) becomes the first argument (rdi).
    mov %rsi, %rdi
    # Then we perform the system call.
    syscall
    # Then we return.
    ret

# Perform a Linux system call with two arguments.
syscall2:
    # The first argument becomes the syscall number.
    mov %rdi, %rax
    # The second argument (rsi) becomes the first argument (rdi).
    mov %rsi, %rdi
    # The third argument (rdx) becomes the second argument (rsi).
    mov %rdx, %rsi
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

# Perform a Linux system call with four arguments.
syscall4:
    # The first argument becomes the syscall number.
    mov %rdi, %rax
    # The second argument (rsi) becomes the first argument (rdi).
    mov %rsi, %rdi
    # The third argument (rdx) becomes the second argument (rsi).
    mov %rdx, %rsi
    # The fourth argument (rcx) becomes the third argument (rdx).
    mov %rcx, %rdx
    # The fifth argument (r8) becomes the fourth argument (r10)
    mov %r8, %r10
    # Then we perform the system call.
    syscall
    # Then we return.
    ret

# Perform a Linux system call with five arguments.
syscall5:
    # The first argument becomes the syscall number.
    mov %rdi, %rax
    # The second argument (rsi) becomes the first argument (rdi).
    mov %rsi, %rdi
    # The third argument (rdx) becomes the second argument (rsi).
    mov %rdx, %rsi
    # The fourth argument (rcx) becomes the third argument (rdx).
    mov %rcx, %rdx
    # The fifth argument (r8) becomes the fourth argument (r10)
    mov %r8, %r10
    # The sixth argument (r9) becomes the fifth argument (r8)
    mov %r9, %r8
    # Then we perform the system call.
    syscall
    # Then we return.
    ret

