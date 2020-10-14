#!/bin/bash
#
# Check that Gtoolkit libraries have the required dependencies available
#

LOG_FILE="GtLibs-`date --iso-8601`.log"

function libs_not_found() {
	echo "Unable to find Gtoolkit libraries."
	echo "This script assumes that the VM is located in the 'lib' directory"
	echo "below the image directory."
	echo "This script should be run from the image directory, i.e."
	echo "GToolkit-*.image and libSkia.so should be present"
	exit 1
}



#
# Quick check of the log for problems
#
function check_log() {
	grep "not found" $LOG_FILE
	if [ $? -eq 0 ]
	then
		echo "Library dependencies missing"
	fi
}



#
# Check that the libraries are present
#
if [ ! -f libSkia.so ]
then
	libs_not_found
fi
if [ ! -f lib/libgit2.so ]
then
	libs_not_found
fi


#
# Ensure output redirection
#
if [ -z "$1" ]
then
	$0 save > $LOG_FILE
	check_log
	echo "Output saved to $LOG_FILE"
	exit 0
fi

export LD_LIBRARY_PATH=`pwd`/lib

echo "Run: `date`"
echo ""
echo "Image directory:"
echo ""
ls -l
echo ""
echo "lib directory:"
echo ""
ls -l lib/
echo ""
echo "libSkia.so"
echo ""
ldd libSkia.so
echo ""
echo "lib/libgit2.so"
echo ""
ldd lib/libgit2.so
echo ""
echo "glxinfo extract"
echo ""
glxinfo | grep -i opengl
exit 0
