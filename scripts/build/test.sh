#/bin/sh!
set -o xtrace
set -e
echo $DISPLAY
export DISPLAY=:99.0
set +e
git config --global user.name "Jenkins"
git config --global user.email "jenkins@feenk.com"
./pharo Pharo.image examples --junit-xml-output 'GToolkit-.*' 2>&1
exit 0