#!/bin/bash

CURRENT_FOLER=$PWD

cd $HOME
rpmdev-setuptree

echo "#### compressing OpenDJ directory"
tar -cvf rpmbuild/SOURCES/OpenDJ.tar.gz OpenDJ

echo "#### building packaging env"

cp $CURRENT_FOLER/OpenDJ.spec $HOME/rpmbuild/SPECS/

echo "#### packaging starting up"
rpmbuild -ba $HOME/rpmbuild/SPECS/OpenDJ.spec

