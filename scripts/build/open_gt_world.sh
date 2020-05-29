#/bin/sh!
set -o xtrace
export RUST_BACKTRACE=full
echo "GtWorld openWithShutdownListener. 30 seconds wait. BlHost pickHost universe snapshot: true andQuit: true." > gtworld.st
xvfb-run -a -e /dev/stdout ./glamoroustoolkit GlamorousToolkit/GlamorousToolkit.image st gtworld.st --interactive --no-quit 