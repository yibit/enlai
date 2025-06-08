#/bin/bash

set -e

if test $# != 2; then
    echo "$0 <input-file> <output-filename>"
    exit 1
fi

FILE=$1
NAME=$2

sed -i '' 's/__//g' $FILE

sed -i '' 's/\*//g' $FILE

sed -i '' 's/#//g' $FILE

# speech.platform.bing.com:443
edge-tts --file $FILE --write-media $NAME.mp3 -v zh-CN-XiaoxiaoNeural

# IINA
# open -a "Visual Studio Code" $NAME.mp3
