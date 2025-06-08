#!/bin/bash

set -e

# R bookdown knitr rmarkdown

Rscript install.r

UNAME=`uname`
MARCH=`uname -m`

if test "x$UNAME" = "xDarwin" -a "x$MARCH" != "xarm64"; then 
    brew install pandoc-citeproc
fi

# https://github.com/rany2/edge-tts
pip install edge-tts

edge-tts --list-voices
