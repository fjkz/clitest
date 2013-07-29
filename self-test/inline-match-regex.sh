# Inline matching method: --regex
# Matches a egrep-style regular expression in the command output
#
# In fact, it's a real egrep match: eval $command | egrep 'regex'
# If egrep matched, we have a successful test. That means that in
# a multiline result, even if just a single line matches the regex,
# the test is considered OK.
#
# Test your regexes with egrep at the command line before adding
# tests using them.

# See man re_format in your system
# http://www.freebsd.org/cgi/man.cgi?query=re_format&sektion=7

# Use anchors ^ and $ to match the full output text

$ echo 'abc123'                 #→ --regex ^abc123$
$ echo 'abc123'                 #→ --regex ^abc.*3$
$ echo 'abc123'                 #→ --regex ^abc[0-9]+$

# Omit one or both anchors to make a parcial match

$ echo 'abc123'                 #→ --regex ^abc
$ echo 'abc123'                 #→ --regex 123$
$ echo 'abc123'                 #→ --regex [0-9]+$
$ echo 'abc123'                 #→ --regex bc
$ echo 'abc123'                 #→ --regex .

# Blanks are preserved, no escaping or quoting needed

$ echo 'abc 123'                #→ --regex ^abc [0-9]+$

# In some systems, the special sequence \t is expanded to a tab in
# egrep regexes. You'll need to test in your system if that's the
# case. I recommend using a literal tab to avoid problems.

$ printf 'may\tfail'            #→ --regex ^may\tfail$
$ printf 'may\tfail'            #→ --regex ^may[\t]fail$
$ printf 'will\tmatch'          #→ --regex ^will	match$

# Since it's an egrep test, regexes are not multiline.
# You can only match a single line.
# These tests will fail:

$ printf 'will\nfail'           #→ --regex will.*fail
$ printf 'will\nfail'           #→ --regex will\nfail

# If one line of a multiline results matches, the test is OK

$ printf '1\n2\n3\n4\nok\n'     #→ --regex ok

# Syntax: Must be exactly one space before and after --regex

$ echo 'fail'                   #→   --regex fail with 2 spaces
$ echo 'fail'                   #→ --regex	fail with tab

# Syntax: The extra space after '--regex ' is already part of the regex

$ echo ' ok'                    #→ --regex  ok

# Syntax: The space after --regex is required.
# When missing, the '--regex' is considered a normal text.

$ echo '--regex'                #→ --regex

# Syntax: Make sure we won't catch partial matches.

$ echo '--regexpal'             #→ --regexpal

# Syntax: To insert a literal text that begins with '--regex '
#         just prefix it with --text.

$ echo '--regex is cool'        #→ --text --regex is cool

# Syntax: Empty inline output contents are considered an error
# Note: Tested in a separate file: inline-match-regex-error-1.sh
#
# $ echo 'no contents'          #→ --regex 