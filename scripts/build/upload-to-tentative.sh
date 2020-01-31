set -o xtrace
set -e
export AWS=ubuntu@$AWSIP
export GTfolder=/var/www/html/tentative

scp GToolkitWin64.zip $AWS:$GTfolder/ 
scp GToolkitOSX64.zip $AWS:$GTfolder/
scp GToolkitLinux64.zip $AWS:$GTfolder/
rm  GToolkitWin64.zip GToolkitOSX64.zip GToolkitLinux64.zip 

set +e