# Output from both STDOUT and STDERR are catched by the tester.

### STDOUT

# Showing STOUT

$ echo "stdout"
stdout
$ echo "stdout" 2> /dev/null
stdout
$

# Redirecting STDOUT to STDERR

$ echo "stderr" 1>&2
stderr
$

# Closing STDOUT

$ echo "stdout" > /dev/null
$ echo "stdout" 2> /dev/null 1>&2
$

### STDERR

$ echo_stderr() { echo "stderr" 1>&2; }
$

# Showing STDERR

$ echo_stderr
stderr
$ echo_stderr > /dev/null
stderr
$

# Redirecting STDERR to STDOUT

$ echo_stderr 2>&1
stderr
$

# Closing STDERR

$ echo_stderr 2> /dev/null
$ echo_stderr > /dev/null 2>&1
$
