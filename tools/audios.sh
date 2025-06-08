#!/bin/bash

#set -e

files=`ls enlai/*.Rmd`
for f in $files; do
    x=`basename $f |awk -F . '{ print $1; }'`
    if test "X$x" != "Xindex" -a "X$x" != "X00-author" -a "X$x" != "X34-Chapter34" -a "X$x" != "X35-Chapter35" -a "X$x" != "X36-Chapter36" -a  "X$x" != "X37-books" -a "X$x" != "X38-hmm" -a "X$x" != "X39-references"; then
        bin/lark lark -f $f
    fi
done

if test $# != 0; then
    exit 1
fi

files=`ls audios/*/*.Rmd`
for f in $files; do
    base=`echo $f |awk -F . '{ print $1; }'`
    bash tools/tts.sh $f $base
done
