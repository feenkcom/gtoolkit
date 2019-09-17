#/bin/sh!
set -o xtrace
export RUST_BACKTRACE=1
system_profiler SPSoftwareDataType
system_profiler SPDisplaysDataType
defaults read /Library/Preferences/com.apple.windowserver.plist
exit 0
