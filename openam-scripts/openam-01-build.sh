#!/bin/bash

# Compilation of OpenAM
# Author : Guy Godfroy, Linagora, 2015

MVN=/opt/maven/current/bin/mvn

source openam-config

#### Patch maven configuration ####

# cp openam-server-prepare-war.xml $HOME/$OPENAM_FOLDER/openam-server-only/

#### Compilation ####
cd $HOME/$OPENAM_FOLDER
$MVN -DskipTests=true clean install
cd openam-distribution/openam-distribution-ssoadmintools
$MVN clean install
