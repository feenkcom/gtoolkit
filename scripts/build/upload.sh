set -o xtrace
set -e
export AWS=ubuntu@ip-172-31-37-111.eu-central-1.compute.internal
export GTfolder=/var/www/html/gt/
export build_zip=$(ls GToolkit-64-*.zip)

if [ -z "${TAG_NAME}" ]
then
    scp GToolkitWin64*.zip $AWS:$GTfolder
    scp GToolkitOSX64*.zip $AWS:$GTfolder
    scp GToolkitLinux64*.zip $AWS:$GTfolder
fi

scp $build_zip $AWS:$GTfolder
ssh $AWS -t "cd ${GTfolder}; ls -tp | grep -v '/$' | tail -n +40 | xargs -d '\n' -r rm --"
set +e