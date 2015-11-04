#!/bin/bash
#script to install openDJ and openAM from rpms in openwis context
#needs to be run with the ROOT user
#Meteo France Francois Faugeron

#prerequisites:
#rpms built by openDJAM_rpmBuild.sh => they are in ~openwis/rpmbuild/RPMS/x86_64/ folder
#tomcat hosting openAM is installed => /var/lib/tomcat/webapps exists

#openDJ install
echo installing openDJ  ...
rpm -i ~openwis/rpmbuild/RPMS/x86_64/OpenDJ-2.6.0-1.el6.x86_64.rpm
#copy to openwis home directory
cp -r /root/OpenDJ-2.6.0/ ~openwis/opendj
chown -R  openwis:openwis ~openwis/opendj
echo openDJ  installed
#cleaning /root 
echo cleaning root folder ...
rpm -e OpenDJ-2.6.0-1.el6.x86_64
rm -rf /root/OpenDJ-2.6.0/
echo root clean

#openAM install
echo installing openAM  ...
rpm -i ~openwis/rpmbuild/RPMS/x86_64/OpenAM-12.0.0-1.el6.x86_64.rpm
echo openAM  installed