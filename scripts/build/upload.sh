set -o xtrace
set -e
export AWS=ubuntu@$AWSIP
export GTfolder=/var/www/html/gt/
export build_zip=GT.zip

scp GToolkitWin64*.zip $AWS:$GTfolder

#save the date so we can show it in the download button
date +%s > releasedateinseconds
scp releasedateinseconds $AWS:$GTfolder/.releasedateinseconds

ssh $AWS -t "cd ${GTfolder}; ls -tp | grep -v '/$' | tail -n +40 | xargs -d '\n' -r rm --"
./scripts/build/create-github-release.sh github_api_token=$GITHUB_TOKEN owner=feenkcom repo=gtoolkit tag=$TAG_NAME
./scripts/build/upload-github-release.sh github_api_token=$GITHUB_TOKEN owner=feenkcom repo=gtoolkit tag=$TAG_NAME filename=$build_zip
./scripts/build/upload-github-release.sh github_api_token=$GITHUB_TOKEN owner=feenkcom repo=gtoolkit tag=$TAG_NAME filename=libOSX64-$TAG_NAME.zip
./scripts/build/upload-github-release.sh github_api_token=$GITHUB_TOKEN owner=feenkcom repo=gtoolkit tag=$TAG_NAME filename=libWin64-$TAG_NAME.zip
./scripts/build/upload-github-release.sh github_api_token=$GITHUB_TOKEN owner=feenkcom repo=gtoolkit tag=$TAG_NAME filename=libLinux64-$TAG_NAME.zip



pwd
find ../../ -type d -name workspace -mtime +4 | xargs /bin/rm -rf
set +e