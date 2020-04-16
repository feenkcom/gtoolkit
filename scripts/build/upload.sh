set -o xtrace
set -e
pwd
ls -al
export AWS=ubuntu@$AWSIP
export GTfolder=/var/www/html/gt/
export ScriptsFolder=/var/www/html/scripts/
export build_zip=GT.zip

TAG_NAME=$(git ls-remote --tags git@github.com:feenkcom/gtoolkit.git | grep /v0 | sort -t '/' -k 3 -V | tail -n1 |sed 's/.*\///; s/\^{}//')
echo $TAG_NAME > tagname.txt

#download GToolkitOSX64 from tentative because the osx vm uploaded a notarized version of it 

curl https://dl.feenk.com/tentative/GToolkitOSX64.zip -o GToolkitOSX64.zip

mv GToolkitWin64.zip GToolkitWin64-$TAG_NAME.zip
mv GToolkitLinux64.zip GToolkitLinux64-$TAG_NAME.zip
mv GToolkitOSX64.zip GToolkitOSX64-$TAG_NAME.zip

scp GToolkitWin64-$TAG_NAME.zip $AWS:$GTfolder
scp GToolkitLinux64-$TAG_NAME.zip $AWS:$GTfolder
scp GToolkitOSX64-$TAG_NAME.zip $AWS:$GTfolder

#save the date so we can show it in the download button
date +%s > releasedateinseconds
scp releasedateinseconds $AWS:$GTfolder/.releasedateinseconds

ssh $AWS -t "cd ${GTfolder}; ls -tp | grep -v '/$' | tail -n +40 | xargs -d '\n' -r rm --"
./scripts/build/create-github-release.sh github_api_token=$GITHUB_TOKEN owner=feenkcom repo=gtoolkit tag=$TAG_NAME
./scripts/build/upload-github-release.sh github_api_token=$GITHUB_TOKEN owner=feenkcom repo=gtoolkit tag=$TAG_NAME filename=$build_zip
./scripts/build/upload-github-release.sh github_api_token=$GITHUB_TOKEN owner=feenkcom repo=gtoolkit tag=$TAG_NAME filename=libOSX64.zip
./scripts/build/upload-github-release.sh github_api_token=$GITHUB_TOKEN owner=feenkcom repo=gtoolkit tag=$TAG_NAME filename=libWin64.zip
./scripts/build/upload-github-release.sh github_api_token=$GITHUB_TOKEN owner=feenkcom repo=gtoolkit tag=$TAG_NAME filename=libLinux64.zip

file=$(echo build-artifacts/GToolkitVM-8.2.0-*-linux64-bin.zip)
mv $file GToolkitVM-8.2.0-linux64-bin.zip
./scripts/build/upload-github-release.sh github_api_token=$GITHUB_TOKEN owner=feenkcom repo=gtoolkit tag=$TAG_NAME filename=GToolkitVM-8.2.0-linux64-bin.zip

file=$(echo build-artifacts/GToolkitVM-8.2.0-*-mac64-bin.zip)
mv $file GToolkitVM-8.2.0-mac64-bin.zip
./scripts/build/upload-github-release.sh github_api_token=$GITHUB_TOKEN owner=feenkcom repo=gtoolkit tag=$TAG_NAME filename=GToolkitVM-8.2.0-mac64-bin.zip

file=$(echo build-artifacts/GToolkitVM-8.2.0-*-win64-bin.zip)
mv $file GToolkitVM-8.2.0-win64-bin.zip
./scripts/build/upload-github-release.sh github_api_token=$GITHUB_TOKEN owner=feenkcom repo=gtoolkit tag=$TAG_NAME filename=GToolkitVM-8.2.0-win64-bin.zip


#deploy local build scripts
scp scripts/localbuild/linux.sh $AWS:$ScriptsFolder
scp scripts/localbuild/mac.sh $AWS:$ScriptsFolder

pwd
find ../../ -type d -name workspace -mtime +4 | xargs /bin/rm -rf
set +e