#!/bin/bash

set -e

files=`ls enlai/*.Rmd`
for f in $files; do
    x=`basename $f |awk -F . '{ print $1; }'`
    bash tools/wordcloud.sh $x
done

rm -f images/34-Chapter34.png images/38-hmm.png images/39-references.png
