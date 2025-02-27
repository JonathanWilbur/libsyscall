# libsyscall

> [!WARNING]  
> This is very much a work in progress. I am still experimenting with this.
> Once it works, I'll create a release and sign it with my PGP key.

This repo contains the bare minimum assembly to be able to make system calls.
Most C standard libraries use GCC inline assembly to implement system calls,
and this is a problem for portability: you _have_ to use GCC to compile them.
This repo basically takes that little bit of _inline_ assembly and makes it
_external_ assembly, so you can use a simpler assembler to produce a small
linkable object file, then use normal non-GCC-flavored C that links with it.

Instead of producing a separate function for every system call, this library
defines functions that take a system call number, followed by a fixed number
of arguments. The system call number, and the arguments are placed in the
correct registers by this function, and the system call is then triggered,
and its return code returned directly to the caller. (Yes, I know, this is
not the most performant way of doing it, but it produces smaller, simpler
code.)

`syscall-x86-64.s` contains this minimal amount of assembly on Linux on the
x86-64 instruction set architecture. Pull requests are welcome to implement
this in other ISAs, and maybe even Windows or Mac (why not?).

`example.c` is an example usage of this syscalls library. It just reads from
`stdin` and echoes it to `stdout`. `example-sleep.c` is another example that was
tailored to test the ability to invoke a system call that uses six parameters,
which has special significance, because the sixth parameter requires a slightly
different technique. All `example-sleep.c` does is sleep for five seconds.

## Purpose

My interest in this is for bootstrapping. This is so little assembly that you
could inspect the ELF file and understand it entirely. This can be linked with
hyper-minimal C programs to produce hyper-minimal compilers and other build
tools with the minimal ability to read and write files.

## Usage

Compile just the library with:

```bash
gcc ./syscall-x86-64.s -c -o syscall.o
```

To compile a program with this, use:

```bash
gcc -nostdlib -static ./syscall-x86-64.s ./example.c -o yeet
```

And check that it works by running:

```bash
echo 'asdfasdf' | ./yeet
```

You should see `asdfasdf` echoed to your console.

## Miscellaneous

`gnu-asm.c` is an extraneous program for seeing what normal inline assembly
looks like when compiled with GCC.
