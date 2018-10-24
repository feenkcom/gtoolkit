#!/bin/sh
if [ $# -ne 3 ]; then
	echo "Usage: `basename $0` <image> <width> <height>"
	exit 1
fi
if expr "`hexdump -n 4 -e '"%u"' "$1"`" '>=' 68000 >/dev/null; then
	echo -ne \\x$(printf "%02X" $[$3%256])\\x$(printf "%02X" $[$3/256])\\x$(printf "%02X" $[$2%256])\\x$(printf "%02X" $[$2/256])\\x$(printf "%02X" 0)\\x$(printf "%02X" 0)\\x$(printf "%02X" 0)\\x$(printf "%02X" 0) \
	| dd of="$1" obs=1 seek=40 conv=block,notrunc cbs=8
else
	echo -ne \\x$(printf "%02X" $[$3%256])\\x$(printf "%02X" $[$3/256])\\x$(printf "%02X" $[$2%256])\\x$(printf "%02X" $[$2/256]) \
	| dd of="$1" obs=1 seek=24 conv=block,notrunc cbs=4
fi
