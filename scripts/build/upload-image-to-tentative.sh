set -o xtrace
set -e
export AWS=ubuntu@$AWSIP
export GTfolder=/var/www/html/tentative
export build_zip=$(ls GlamorousToolkit-64-*.zip)

scp $build_zip $AWS:$GTfolder/GT.zip
