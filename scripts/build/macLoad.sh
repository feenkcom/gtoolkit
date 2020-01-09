#/bin/sh!
set -o xtrace
export RUST_BACKTRACE=full
system_profiler SPSoftwareDataType
system_profiler SPDisplaysDataType
defaults read /Library/Preferences/com.apple.windowserver.plist
exit 0
