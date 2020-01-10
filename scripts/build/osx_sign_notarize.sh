#!/bin/sh
set -o xtrace
ls -al

curl https://dl.feenk.com/tentative/GToolkitOSX64.zip -o GToolkitOSX64.zip
security delete-keychain MyKeychain.keychain
security create-keychain -p 'temporaryPassword' MyKeychain.keychain
security list-keychains -d user -s login.keychain MyKeychain.keychain
security list-keychains
echo $CERT > encoded
base64 --decode encoded -o pipe.p12
security unlock-keychain -p 'temporaryPassword' MyKeychain.keychain
security import pipe.p12 -k MyKeychain.keychain -P ""
unzip GToolkitOSX64.zip

codesign --entitlements scripts/resources/Product.entitlements  --force -v --options=runtime  --deep --timestamp --file-list - -s "$SIGNING_IDENTITY" GToolkitOSX64-*/GToolkit.app
codesign --entitlements scripts/resources/Product.entitlements  --force -v --options=runtime  --deep --timestamp --file-list - -s "$SIGNING_IDENTITY" GToolkitOSX64-*/*.dylib 

ditto -c -k --sequesterRsrc --keepParent GToolkitOSX64-*/ GToolkitOSX64-"${TAG_NAME}".zip

xcrun altool -t osx -f GToolkitOSX64-"${TAG_NAME}".zip -itc_provider "77664ZXL29" --primary-bundle-id "com.feenk.gtoolkit" --notarize-app --verbose  --username "george.ganea@feenk.com" --password "${APPLEPASSWORD}"

export AWS=ubuntu@ec2-35-157-37-37.eu-central-1.compute.amazonaws.com 
export GTfolder=/var/www/html/gt/

scp GToolkitOSX64*.zip $AWS:$GTfolder