#/bin/sh!
set -o xtrace
xvfb-run -a -e /dev/stdout ./gtoolkit GToolkit-64-*/GToolkit-64-*.image eval --interactive --no-quit "GtWorld openWithShutdownListener. 30 seconds wait. BlHost pickHost universe snapshot: true andQuit: true"