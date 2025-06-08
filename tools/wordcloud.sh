#!/bin/sh

set -e

NAME=lizongsheng
if test $# -gt 0; then
    NAME=$1
fi

if test ! -f enlai/$NAME.Rmd; then
    echo "enlai/$NAME.txt dose not exist!"
    exit 1
fi

python wasabi/core/word_cloud.py -d enlai/$NAME.Rmd \
    -f "$HOME/taguba/mantra/喜鹊造字/喜鹊招牌体(简+繁体).ttf" \
    -c $NAME.png

echo images/$NAME.png: enlai/$NAME.Rmd
