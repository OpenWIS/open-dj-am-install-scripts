#!/bin/bash

source ../deploy_config

CURRENT=$PWD
cd $OPENAM_PATH/SSOAdminTools/openam/bin

# You must generate the fedlets on every portals before this step
# Import remote service provider
./ssoadm import-entity -t cot_openwis -u amAdmin -f passwd -m $CURRENT/portal-meta.xml

# Attributes matching
./ssoadm set-attr-defs -u amAdmin -f passwd -s iPlanetAMSAMLService -t global -D $CURRENT/AssertionProcessingAttributes

cd $CURRENT
