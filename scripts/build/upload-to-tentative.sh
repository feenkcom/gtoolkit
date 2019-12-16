set -o xtrace
set -e
export AWS=ubuntu@ip-172-31-37-111.eu-central-1.compute.internal
export GTfolder=/var/www/html/tentative/


if [ ! -z "${TAG_NAME}" ]
then
    echo ${TAG_NAME} > version.txt
    scp GToolkitWin64*.zip $AWS:$GTfolder/GToolkitWin64.zip 
    scp GToolkitOSX64*.zip $AWS:$GTfolder/GToolkitOSX64.zip
    scp GToolkitLinux64*.zip $AWS:$GTfolder/GToolkitLinux64.zip
else
    echo "TAG_NAME not set"
fi

set +e