#/bin/sh!
set -o xtrace
set -e
export RUST_BACKTRACE=full
echo "space := GtWorld openDefault. 30 seconds wait. GtMonitor printRuntimeInfo. space universe snapshot: true andQuit: true." > gtworld.st
xvfb-run -a -e /dev/stdout ./glamoroustoolkit GlamorousToolkit/GlamorousToolkit.image st gtworld.st --interactive --no-quit 
