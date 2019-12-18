set -o xtrace
set -e
export AWS=ubuntu@ip-172-31-37-111.eu-central-1.compute.internal
export GTfolder=/var/www/html/tentative


if [ ! -z "${TAG_NAME}" ]
then
    echo ${TAG_NAME} > version.txt
    cp GToolkitWin64*.zip GToolkitWin64.zip 
    cp GToolkitOSX64*.zip GToolkitOSX64.zip 
    cp GToolkitLinux64*.zip GToolkitLinux64.zip 
    scp GToolkitWin64.zip $AWS:$GTfolder/ 
    scp GToolkitOSX64.zip $AWS:$GTfolder/
    scp GToolkitLinux64.zip $AWS:$GTfolder/
    rm  GToolkitWin64.zip GToolkitOSX64.zip GToolkitLinux64.zip 
else
    echo "TAG_NAME not set"
fi

set +e