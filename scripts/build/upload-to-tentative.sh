set -o xtrace
set -e
export AWS=ubuntu@ip-172-31-37-111.eu-central-1.compute.internal
export GTfolder=/var/www/html/tentative/


if [ ! -z "${TAG_NAME}" ]
then
    scp GToolkitWin64*.zip $AWS:$GTfolder
    scp GToolkitOSX64*.zip $AWS:$GTfolder
    scp GToolkitLinux64*.zip $AWS:$GTfolder
else
    echo "TAG_NAME not set"
fi

set +e