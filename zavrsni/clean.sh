# clean build directory

DIR=$(dirname `readlink -f $0`)
. $DIR/testing.conf

rm -r $DIR/temp/build/tests
exit 0
