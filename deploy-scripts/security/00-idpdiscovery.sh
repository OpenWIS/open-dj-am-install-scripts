#!/bin/bash

source ../deploy_config

CURRENT=$PWD

# Deploy ldpDiscovery
cp idpdiscovery.war $TOMCAT/webapps
cp libIDPDiscoveryConfig.properties $TOMCAT/conf

