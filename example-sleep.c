// Example program to test system calls with six parameters

extern int syscall1(int syscall_num, void *a);
extern int syscall5(int syscall_num, void *a, void *b, void *c, void *d, void *e);
extern int syscall6(int syscall_num, void *a, void *b, void *c, void *d, void *e, void *f);

#define SYSCALL_SELECT      23
#define SYSCALL_EXIT        60
#define SYSCALL_PSELECT     270

int exit (int exitcode) {
    return syscall1(SYSCALL_EXIT, exitcode);
}

struct timespec {
    long tv_sec;         /* seconds */
    long tv_nsec;        /* nanoseconds */
};

static struct timespec t = {
    .tv_sec = 5,
    .tv_nsec = 0,
};

int asdf () {
	int rc = syscall6(SYSCALL_PSELECT, 0, 0, 0, 0, &t, 0);
    // int rc = syscall5(SYSCALL_SELECT, 0, 0, 0, 0, &t);
    if (rc >= 0) {
        return 0;
    } else {
        return -rc;
    }
}

void _start (long *sp) {
    exit(asdf());
}
