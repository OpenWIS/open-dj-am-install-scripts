#!/bin/bash

# Master script for OpenAM download, compilation and packaging
# Author : Guy Godfroy, Linagora, 2015

echo "########## Downloading sources ##########"
echo

./openam-00-download.sh

if [ "$?" != "0" ]
then
    exit 1
fi

echo "######## Building and packaging #########"
echo

./openam-02-package.sh

if [ "$?" != "0" ]
then
    exit 1
fi
