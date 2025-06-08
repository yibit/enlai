#!/bin/sh

set -e

UNAME=$(uname -s)

ECHO_OPT="-e"
if test "x$UNAME" = "xDarwin"; then
    ECHO_OPT=""
fi

n=$(git status | grep "nothing to commit, working tree clean" | wc -l)
if test $n -ne 1; then
    if test $# -gt 0; then
        echo "dirty"
    else
        git status
        echo $ECHO_OPT "\033[31;1m\nWarning ...\033[0m"
        echo $ECHO_OPT "\033[31;1mYour working tree is dirty, this action is not permited.\033[0m"
        echo $ECHO_OPT "\033[31;1mPlease commit all your changes and try it again.\n\033[0m"
    fi
    exit 1
fi

echo "clean"
