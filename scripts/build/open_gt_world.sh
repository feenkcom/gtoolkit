#/bin/sh!
set -o xtrace
GTVERSION=$(curl -s https://api.github.com/repos/feenkcom/gtoolkit/tags/latest | grep tag_name | cut -d '"' -f 4)
echo $GTVERSION > tagname.txt
xvfb-run -a -e /dev/stdout ./gtoolkit GToolkit-64-*/GToolkit-64-*.image eval --interactive --no-quit "GtWorld openWithShutdownListener. 30 seconds wait. BlHost pickHost universe snapshot: true andQuit: true"