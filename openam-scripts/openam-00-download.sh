#!/bin/bash

# Grab the code from the SVN repository
# Author : Guy Godfroy, Linagora, 2015

source openam-config

CURRENT_FOLDER=$PWD

cd $HOME

#### Download sources from repository ####

$GIT clone $REPO

if [ "$?" = "0" ]
then
    echo "--> Code cloned correctly."
    echo
else
    echo "--> /!\\ An error happened during cloning."
    exit 1
fi

cd OpenAM

$GIT checkout $TAG

if [ "$?" = "0" ]
then
    echo "--> Tag checkout successful."
    echo
else
    echo "--> /!\\ An error happened during tag checkout."
    exit 1
fi

$GIT branch -D master

if [ "$?" = "0" ]
then
    echo "--> Deleted old master branch."
    echo
else
    echo "--> /!\\ An error happened during old master branch deletion."
    exit 1
fi

$GIT checkout -b master

if [ "$?" = "0" ]
then
    echo "--> New master branch checkout successfull."
    echo
else
    echo "--> /!\\ An error happened during new master branch checkout."
    exit 1
fi

cd ..

#### Patches a corrupted file ####

cd $CURRENT_FOLDER
cp openam-server-prepare-war.xml $HOME/$OPENAM_FOLDER/openam-server-only/

if [ "$?" != "0" ]
then
    echo "--> /!\\ You should modify the OPENAM_FOLDER variable in the openam-config file."
    exit 1
fi
