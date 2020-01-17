#/bin/sh!
set -o xtrace

curl https://dl.feenk.com/tentative/GT.zip -o GT.zip
unzip GT.zip

sh scripts/build/downloadLatestVM.sh	
unzip build-artifacts.zip

unzip build-artifacts/GToolkitVM-8.2.0-*-linux64-bin.zip

# It is important to run headless vm with --interactive flag, otherwise the UI will not open
# We should also pass --no-quit flag, otherwise the VM will be terminated before the universe ever gets a chance to save an image.
# It takes significant amount of time to start GtWorld, so let's wait for 30 seconds to make sure everything is initialized
# There is not need to run save and quit an image from a forked process, because the save request is deffered though the universe
xvfb-run -a -e /dev/stdout ./gtoolkit GToolkit-64-*/GToolkit-64-*.image eval --interactive --no-quit "GtWorld openWithShutdownListener. 30 seconds wait. BlHost pickHost universe snapshot: true andQuit: true"