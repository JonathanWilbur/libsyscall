/* This is an extraneous program to see what an inline-assembly function looks
like when you compile it using GCC. */

#define SYSCALL_PSELECT     270

#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                  \
({                                                                            \
	long _ret;                                                            \
	register long _num  __asm__ ("rax") = (num);                          \
	register long _arg1 __asm__ ("rdi") = (long)(arg1);                   \
	register long _arg2 __asm__ ("rsi") = (long)(arg2);                   \
	register long _arg3 __asm__ ("rdx") = (long)(arg3);                   \
	register long _arg4 __asm__ ("r10") = (long)(arg4);                   \
	register long _arg5 __asm__ ("r8")  = (long)(arg5);                   \
	register long _arg6 __asm__ ("r9")  = (long)(arg6);                   \
									      \
	__asm__ volatile (                                                    \
		"syscall\n"                                                   \
		: "=a"(_ret)                                                  \
		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
		  "r"(_arg6), "0"(_num)                                       \
		: "rcx", "r11", "memory", "cc"                                \
	);                                                                    \
	_ret;                                                                 \
})

struct timespec {
    long tv_sec;         /* seconds */
    long tv_nsec;        /* nanoseconds */
};

static struct timespec t = {
    .tv_sec = 5,
    .tv_nsec = 0,
};

int pselect(int nfds, void *readfds, void *writefds,
            void *exceptfds, const struct timespec *timeout,
            const void *sigmask) {
    return my_syscall6(SYSCALL_PSELECT, nfds, readfds, writefds, exceptfds, timeout, sigmask);
}

int main () {
    int nfds = 0;
    int readfds = 0;
    int writefds = 0;
    void* exceptfds = 0;
    void* sigmask = 0;
	int rc = pselect(nfds, readfds, writefds, exceptfds, &t, sigmask);
    // int rc = syscall5(SYSCALL_SELECT, 0, 0, 0, 0, &t);
    if (rc >= 0) {
        
    } else {
        return -rc;
    }

	rc = pselect(nfds, readfds, writefds, exceptfds, &t, sigmask);
    // int rc = syscall5(SYSCALL_SELECT, 0, 0, 0, 0, &t);
    if (rc >= 0) {
        return 0;
    } else {
        return -rc;
    }

}