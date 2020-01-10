set -o xtrace
set -e
export AWS=ubuntu@ip-172-31-37-111.eu-central-1.compute.internal
export GTfolder=/var/www/html/gt/
export build_zip=$(ls GToolkit-64-*.zip)

if [ ! -z "${TAG_NAME}" ]
then
    scp GToolkitWin64*.zip $AWS:$GTfolder
    # scp GToolkitOSX64*.zip $AWS:$GTfolder
    scp GToolkitLinux64*.zip $AWS:$GTfolder
    scp gt.jpg $AWS:$GTfolder
    scp releasedateinseconds $AWS:$GTfolder/.releasedateinseconds
    scp $build_zip $AWS:$GTfolder 
    ssh $AWS -t "cd ${GTfolder}; ls -tp | grep -v '/$' | tail -n +40 | xargs -d '\n' -r rm --"
    ./scripts/build/create-github-release.sh github_api_token=$GITHUB_TOKEN owner=feenkcom repo=gtoolkit tag=$TAG_NAME
    ./scripts/build/upload-github-release.sh github_api_token=$GITHUB_TOKEN owner=feenkcom repo=gtoolkit tag=$TAG_NAME filename=$build_zip
    ./scripts/build/upload-github-release.sh github_api_token=$GITHUB_TOKEN owner=feenkcom repo=gtoolkit tag=$TAG_NAME filename=libOSX64-$TAG_NAME.zip
    ./scripts/build/upload-github-release.sh github_api_token=$GITHUB_TOKEN owner=feenkcom repo=gtoolkit tag=$TAG_NAME filename=libWin64-$TAG_NAME.zip
    ./scripts/build/upload-github-release.sh github_api_token=$GITHUB_TOKEN owner=feenkcom repo=gtoolkit tag=$TAG_NAME filename=libLinux64-$TAG_NAME.zip
else
    echo "TAG_NAME not set"
fi


pwd
find ../../ -type d -name workspace -mtime +4 | xargs /bin/rm -rf
set +e