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

#download GlamorousToolkitOSX64 from tentative because the osx vm uploaded a notarized version of it 

curl https://dl.feenk.com/tentative/GlamorousToolkitOSX64.zip -o GlamorousToolkitOSX64.zip

mv GlamorousToolkitWin64.zip GlamorousToolkitWin64-$TAG_NAME.zip
mv GlamorousToolkitLinux64.zip GlamorousToolkitLinux64-$TAG_NAME.zip
mv GlamorousToolkitOSX64.zip GlamorousToolkitOSX64-$TAG_NAME.zip

scp GlamorousToolkitWin64-$TAG_NAME.zip $AWS:$GTfolder
scp GlamorousToolkitLinux64-$TAG_NAME.zip $AWS:$GTfolder
scp GlamorousToolkitOSX64-$TAG_NAME.zip $AWS:$GTfolder

#save the date so we can show it in the download button
date +%s > releasedateinseconds
scp releasedateinseconds $AWS:$GTfolder/.releasedateinseconds

ssh $AWS -t "cd ${GTfolder}; ls -tp | grep -v '/$' | tail -n +40 | xargs -d '\n' -r rm --"
./scripts/build/create-github-release.sh github_api_token=$GITHUB_TOKEN owner=feenkcom repo=gtoolkit tag=$TAG_NAME
./scripts/build/upload-github-release.sh github_api_token=$GITHUB_TOKEN owner=feenkcom repo=gtoolkit tag=$TAG_NAME filename=$build_zip

libFolder=libOSX64
unzip $libFolder.zip
rm $libFolder.zip
mv $libFolder $libFolder-$TAG_NAME
zip -qyr libOSX64.zip $libFolder-$TAG_NAME
./scripts/build/upload-github-release.sh github_api_token=$GITHUB_TOKEN owner=feenkcom repo=gtoolkit tag=$TAG_NAME filename=libOSX64.zip

libFolder=libWin64
unzip $libFolder.zip
rm $libFolder.zip
mv $libFolder $libFolder-$TAG_NAME
zip -qyr libWin64.zip $libFolder-$TAG_NAME
./scripts/build/upload-github-release.sh github_api_token=$GITHUB_TOKEN owner=feenkcom repo=gtoolkit tag=$TAG_NAME filename=libWin64.zip

libFolder=libLinux64
unzip $libFolder.zip
rm $libFolder.zip
mv $libFolder $libFolder-$TAG_NAME
zip -qyr libLinux64.zip $libFolder-$TAG_NAME
./scripts/build/upload-github-release.sh github_api_token=$GITHUB_TOKEN owner=feenkcom repo=gtoolkit tag=$TAG_NAME filename=libLinux64.zip


file=$(echo build-artifacts/GlamorousToolkitVM-8.2.0-*-linux64-bin.zip)
mv $file GlamorousToolkitVM-8.2.0-linux64-bin.zip
./scripts/build/upload-github-release.sh github_api_token=$GITHUB_TOKEN owner=feenkcom repo=gtoolkit tag=$TAG_NAME filename=GlamorousToolkitVM-8.2.0-linux64-bin.zip

file=$(echo build-artifacts/GlamorousToolkitVM-8.2.0-*-mac64-bin.zip)
mv $file GlamorousToolkitVM-8.2.0-mac64-bin.zip
./scripts/build/upload-github-release.sh github_api_token=$GITHUB_TOKEN owner=feenkcom repo=gtoolkit tag=$TAG_NAME filename=GlamorousToolkitVM-8.2.0-mac64-bin.zip

file=$(echo build-artifacts/GlamorousToolkitVM-8.2.0-*-win64-bin.zip)
mv $file GlamorousToolkitVM-8.2.0-win64-bin.zip
./scripts/build/upload-github-release.sh github_api_token=$GITHUB_TOKEN owner=feenkcom repo=gtoolkit tag=$TAG_NAME filename=GlamorousToolkitVM-8.2.0-win64-bin.zip


#deploy local build scripts
scp scripts/localbuild/linux.sh $AWS:$ScriptsFolder
scp scripts/localbuild/mac.sh $AWS:$ScriptsFolder

pwd
find ../../ -type d -name workspace -mtime +4 | xargs /bin/rm -rf
set +e