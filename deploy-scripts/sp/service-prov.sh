#!/bin/bash

source ../deploy_config

CURRENT=$PWD
cd $OPENAM_PATH/SSOAdminTools/openam/bin

# You must generate the fedlets on every portals before this step
# Import remote service provider
./ssoadm import-entity -t $COT -u $OPENAM_USER -f passwd -m $CURRENT/portal-meta.xml

cd $CURRENT
