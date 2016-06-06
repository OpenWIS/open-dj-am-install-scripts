#!/bin/bash
echo "#### 01 Downloading SOURCES ####"
./opendj-00-download.sh
if [ $? != 0 ]
then
    echo -e "error : please check opendj-00-download.sh and OpenDJ-config"
    exit $?
else
    echo -e "#### 01 SUCCESS ####"
fi

echo "#### 02 Packaging OpenDJ ####"
./opendj-02-package.sh
if [ $? != 0 ]
then
    echo -e "error : please check opendj-02-package.sh and OpenDJ.spec"
    exit $?
else
    echo -e "#### 02 SUCCESS ####"
fi

