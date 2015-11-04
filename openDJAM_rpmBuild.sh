#!/bin/bash
#script to build openDJ and openAM rpms in openwis context
#needs to be run with the openwis user
#Meteo France Francois Faugeron

#prerequisites:
#Linagora's scripts are in ~openwis/open-DJ-AM-build
#see ~openwis/open-DJ-AM-build/*pdf for prerequisites

#generate openDJ rpm
echo openDJ rpm building ...
cd ~openwis/open-DJ-AM-build/opendj-scripts/
./opendj-all.sh
echo openDJ rpm done 
# created:
# ~openwis/OpenDJ/	: openDJ github clone
# ~openwis/OpenDJ.tar.gz :  openDJ artefact
# ~openwis/rpmbuild/RPMS/x86_64/OpenDJ-2.6.0-1.el6.x86_64.rpm : rpm folder

#generate openAM rpm
cd ~openwis/open-DJ-AM-build/openam-scripts/
echo openAM rpm building ...
#amending webapps folder
sed -i 's/var\/lib\/tomcat6\/webapps/var\/lib\/tomcat\/webapps/g' openam.spec
./openam-all.sh
echo openAM rpm done 
# created:
#~openwis/OpenAM	: openAM github clone
#~openwis/openam_tools/SSOAdminTools-12.0.0.zip
#~openwis/rpmbuild/RPMS/x86_64/OpenAM-12.0.0-1.el6.x86_64.rpm