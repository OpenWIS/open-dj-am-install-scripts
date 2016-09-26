#!/bin/bash

source deploy_config
export $(grep -v ^# deploy_config | cut -d= -f1)

# Set OpenDJ and OpenAM configuration files
echo "Prepare setup_opendj.properties"
envsubst < setup_opendj.properties.orig > setup_opendj.properties

echo "Prepare setup_openam.properties"
envsubst < SSOConfiguratorTools/setup_openam.properties.orig > SSOConfiguratorTools/setup_openam.properties

echo "Prepare attrs.properties"
envsubst < attrs.properties.orig > attrs.properties

echo "Prepare libIDPDiscoveryConfig.properties"
envsubst < idp/libIDPDiscoveryConfig.properties.orig > idp/libIDPDiscoveryConfig.properties

echo "Prepare register_sp.sh"
envsubst < sp/register_sp.sh.orig > sp/register_sp.sh

# Unset exported environment variables to avoid side effects on main script
unset $(grep -v ^# deploy_config | cut -d= -f1)
source deploy_config

