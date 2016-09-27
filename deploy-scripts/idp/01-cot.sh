#!/bin/bash

source ../deploy_config

CURRENT=$PWD

# Adapt IDPs config files
sed "s|http://hacops.lan.par.lng:8080/openam|$OPENAM_URL|g" IDP1-meta.xml.orig > IDP1-meta.xml
sed "s|http://hacops.lan.par.lng:8080/openam|$OPENAM_URL|g" IDP1-extend.xml.orig > IDP1-extend.xml

##### WARNING !  the passwd file mush have readonly right for owner only.

# Create fully configured circle of trust
# WARNING: the --prefix option is totally undocumented and thus cannot be found in any reference manual.
$OPENAM_PATH/SSOAdminTools/openam/bin/ssoadm create-cot -t $COT -u $OPENAM_USER -f $OPENAM_PATH/SSOAdminTools/openam/bin/passwd --prefix $IDPDSC_PREFIX
# Create hosted identity provider
$OPENAM_PATH/SSOAdminTools/openam/bin/ssoadm import-entity -t $COT -u $OPENAM_USER -f $OPENAM_PATH/SSOAdminTools/openam/bin/passwd -m $CURRENT/IDP1-meta.xml -x $CURRENT/IDP1-extend.xml
