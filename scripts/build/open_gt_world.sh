#/bin/sh!
set -o xtrace
GTVERSION=$(git ls-remote --tags git@github.com:feenkcom/gtoolkit.git | grep /v0 | sort -t '/' -k 3 -V | tail -n1 |sed 's/.*\///; s/\^{}//')
echo $GTVERSION > tagname.txt
xvfb-run -a -e /dev/stdout ./gtoolkit GToolkit-64-*/GToolkit-64-*.image eval --interactive --no-quit "GtWorld openWithShutdownListener. 30 seconds wait. BlHost pickHost universe snapshot: true andQuit: true"