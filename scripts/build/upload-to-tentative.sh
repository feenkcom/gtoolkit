set -o xtrace
set -e
export AWS=ubuntu@$AWSIP
export GTfolder=/var/www/html/tentative

scp GlamorousToolkitWin64.zip $AWS:$GTfolder/ 
scp GlamorousToolkitOSX64.zip $AWS:$GTfolder/
scp GlamorousToolkitLinux64.zip $AWS:$GTfolder/
rm  GlamorousToolkitWin64.zip GlamorousToolkitOSX64.zip GlamorousToolkitLinux64.zip 

set +e