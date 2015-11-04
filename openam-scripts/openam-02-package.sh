#!/bin/bash

# Prepares and lauches RPM packet creation from downloaded sources.
# Author: Guy Godfroy, Linagora, 2015

CURRENT_FOLDER=$PWD

cd $HOME
rpmdev-setuptree
tar -cvzf $HOME/rpmbuild/SOURCES/openam.tgz OpenAM
if [ "$?" != "0" ]
then
	echo "--> /!\\ Error while archive creation"
	exit 1
fi
cp $CURRENT_FOLDER/openam.spec $HOME/rpmbuild/SPECS

cd $HOME/rpmbuild/SPECS
rpmbuild -ba openam.spec
if [ "$?" != "0" ]
then
	echo "--> /!\\ Error while RPM creation"
	exit 1
fi
