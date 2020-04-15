#/bin/sh!
set -o xtrace

echo "GtWorld openWithShutdownListener. 30 seconds wait. BlHost pickHost universe snapshot: true andQuit: true." > gtworld.st
xvfb-run -a -e /dev/stdout ./gtoolkit GToolkit-64-*/GToolkit-64-*.image st gtworld.st --interactive --no-quit 