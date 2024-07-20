extern int syscall1(int syscall_num, void *a);
extern int syscall3(int syscall_num, void *a, void *b, void *c);

#define SYSCALL_READ    0
#define SYSCALL_WRITE   1
#define SYSCALL_EXIT    60

int exit (int exitcode) {
    return syscall1(SYSCALL_EXIT, exitcode);
}

int read (int fd, char* buf, int count) {
    return syscall3(SYSCALL_READ, fd, buf, count);
}

int write (int fd, char* buf, int count) {
    return syscall3(SYSCALL_WRITE, fd, buf, count);
}

// Example usage: echo 'asdfasdf' | ./a.out
int asdf () {
    char buf[8] = {0};
    int rc;
    while ((rc = read(0, buf, 7)) > 0)  {
        buf[7] = 0;
        write(1, buf, rc);
    }
    return 0;
}

void _start (long *sp) {
    exit(asdf());
}