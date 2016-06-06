#!/bin/bash

source ../deploy_config

CURRENT=$PWD

# Deploy ldpDiscovery
cp $OPENAM_PATH/IDPDiscovery-12.0.0.war $TOMCAT/webapps/idpdiscovery.war
cp libIDPDiscoveryConfig.properties $TOMCAT/conf

