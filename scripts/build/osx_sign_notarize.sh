#!/bin/sh
set -o xtrace
ls -al

curl https://dl.feenk.com/tentative/GToolkitOSX64.zip -o GToolkitOSX64.zip
security create-keychain -p 'temporaryPassword' MyKeychain.keychain
security list-keychains -d user -s login.keychain MyKeychain.keychain
security list-keychains
echo $CERT > encoded
base64 --decode encoded -o pipe.p12
security unlock-keychain -p 'temporaryPassword' MyKeychain.keychain
security import pipe.p12 -k MyKeychain.keychain -P ""
unzip GToolkitOSX64.zip

codesign --entitlements scripts/resources/Product.entitlements  --force -v --options=runtime  --deep --timestamp --file-list - -s $SIGNING_IDENTITY GToolkitOSX64-*/GToolkit.app
codesign --entitlements scripts/resources/Product.entitlements  --force -v --options=runtime  --deep --timestamp --file-list - -s $SIGNING_IDENTITY GToolkitOSX64-*/*.dylib 

ditto -c -k --sequesterRsrc --keepParent GToolkitOSX64-*/ GToolkitVM-8.2.0-latest-mac64-bin-signed.zip