#!/bin/bash

set -e

NAME=`uname -s`

files=`ls enlai/*Chapter*`
for f in $files; do
    if test "x$f" != "x37-Chapter37.Rmd" -a "x$f" != "x34-Chapter34.Rmd"; then

        path=`basename $f |awk -F . '{ print "images/cloud/"$1".png"; }'`
        if test "x$NAME" = "xDarwin"; then
            sed -i '' "2 i\\
                \n![]($path)
                " $f
        else
            sed -i "2 i\\\n![]($path)" $f
        fi

    fi
done
