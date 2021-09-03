``` sh

ulimit
User limits - limit the use of system-wide resources.

Syntax
      ulimit [-HS] -a
      ulimit [-HS] [-bcdefiklmnpqrstuvxPRT] [limit]
Key
   -S   Set a soft limit for the given resource.
   -H   Set a hard limit for the given resource.

   -a   All current limits are reported.
   -b   The maximum socket buffer size.
   -c   The maximum size of core files created. 
   -d   The maximum size of a process's data segment.
   -e   The maximum scheduling priority ("nice") 
   -f   The maximum size of files created by the shell(default option).
   -i   The maximum number of pending signals.
   -k   The maximum number of kqueues that may be allocated.
   -l   The maximum size that can be locked into memory. 
   -m   The maximum resident set size. 
   -n   The maximum number of open file descriptors. 
   -p   The pipe buffer size.
   -P   The maximum number of pseudoterminals.
   -q   The maximum number of bytes in POSIX message queues.
   -r   The maximum real-time scheduling priority.
   -R   The maximum time a real-time process can run before blocking, in microseconds.
   -s   The maximum stack size. 
   -t   The maximum amount of cpu time in seconds.
   -T   The maximum number of threads.
   -u   The maximum number of processes available to a single user.
   -v   The maximum amount of virtual memory available to the process.
   -x   The maximum number of file locks.
```
ulimit provides control over the resources available to the shell and to processes started by it, on systems that allow such control.

The soft limit is the value that the kernel enforces for the corresponding resource. The hard limit acts as a ceiling for the soft limit.

An unprivileged process may only set its soft limit to a value in the range from 0 up to the hard limit, and (irreversibly) lower its hard limit. A privileged process can make arbitrary changes to either limit value.

If limit is given, it is the new value of the specified resource. Otherwise, the current value of the soft limit for the specified resource is printed, unless the '-H' option is supplied.

When setting new limits, if neither '-H' nor '-S' is supplied, both the hard and soft limits are set.

Restricting per user processes ( -u) can be useful for limiting the potential effects of a fork bomb.

Values are in 1024-byte increments, except for '-t', which is in seconds, '-p', which is in units of 512-byte blocks, and '-n' and '-u', which are unscaled values.

The return status is zero unless an invalid option is supplied, a non-numeric argument other than unlimited is supplied as a limit, or an error occurs while setting a new limit.

This is a BASH shell builtin, to display your local syntax from the bash prompt type: help ulimit

```
Example

$ ulimit -a
core file size          (blocks, -c) 0
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 20
file size               (blocks, -f) unlimited
pending signals                 (-i) 16382
max locked memory       (kbytes, -l) 64
max memory size         (kbytes, -m) unlimited
open files                      (-n) 1024
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
real-time priority              (-r) 0
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) unlimited
max user processes              (-u) unlimited
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited
“Every man is a damn fool for at least five minutes every day; wisdom consists of not exceeding that limit” ~ Elbert Hubbard

```