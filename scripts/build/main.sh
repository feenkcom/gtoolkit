echo $DISPLAY
export DISPLAY=:99.0
curl https://get.pharo.org/64/alpha+vmLatest | bash
./pharo Pharo.image st --save --quit scripts/build/loadgt.st
./pharo-ui Pharo.image examples --junit-xml-output Bloc 'Bloc-.*' 'GToolkit-.*'