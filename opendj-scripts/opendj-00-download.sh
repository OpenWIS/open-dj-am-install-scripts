#!/bin/bash                                                                                                            
source OpenDJ-config

cd $HOME

$GIT clone $REPO $HOME/OpenDJ
if [ $? != 0 ]
then
    echo -e "step 00 git clone error"
    exit $?
else
    echo -e "step 00 git clone Success"
fi

cd $HOME/OpenDJ
$GIT checkout $TAG
if [ $? != 0 ]
then
    echo -e "step 01 git checkout error"
    exit $?
else
    echo -e "step 01 checkout success"
fi

$GIT branch -D master
if [ $? != 0 ]
then
    echo -e "step 02 error : git branch -d master"
    exit $?
else
    echo -e "step 02 success"
fi

$GIT checkout -b master
if [ $? != 0 ]
then
    echo -e "step 03 error : git checkout -b master"
    exit $?
else
    echo -e "step 03 success"
fi

exit 0

