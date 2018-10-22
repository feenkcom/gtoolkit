if [ $BITS = 32 ]; then
  curl https://dl.feenk.com/Moz2D/osx/development/i386/libMoz2D.dylib -o libMoz2D.dylib
  curl https://dl.feenk.com/Moz2D/win/development/i386/libMoz2D.dll -o libMoz2D.dll
else
  curl https://dl.feenk.com/Moz2D/linux/development/x86_64/libMoz2D.so -o libMoz2D.so
  curl https://dl.feenk.com/Moz2D/osx/development/x86_64/libMoz2D.dylib -o libMoz2D.dylib
  curl https://dl.feenk.com/Moz2D/win/development/x86_64/libMoz2D.dll -o libMoz2D.dll
fi

cp -v "libMoz2D*" "${ARTIFACT_DIR}/"
