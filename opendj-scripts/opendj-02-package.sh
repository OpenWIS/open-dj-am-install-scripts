#!/bin/bash
CURRENT_FOLDER=$PWD

echo "#### compressing OpenDJ directory"
cd $HOME
tar -czvf $HOME/OpenDJ.tar.gz OpenDJ

echo "#### building packaging env"
rpmdev-setuptree

cp $HOME/OpenDJ.tar.gz $HOME/rpmbuild/SOURCES/

cp $CURRENT_FOLDER/OpenDJ.spec $HOME/rpmbuild/SPECS/

echo "#### packaging starting up"
rpmbuild -ba $HOME/rpmbuild/SPECS/OpenDJ.spec

