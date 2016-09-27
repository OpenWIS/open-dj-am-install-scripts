#!/bin/bash

#source deploy_config

#CURRENT=$(pwd)
#cd $CURRENT
TOMCAT=/data/openwis/apache-tomcat-7.0.59

echo "starting openDJ..."
cd /data/openwis/OpenDJ-2.6.0/bin ; ./start-ds

echo "*** OpenDJ started ***"

# Start Tomcat, and wait until Tomcat is started
echo "--- Start Tomcat"
$TOMCAT/bin/startup.sh
until [ "`curl --silent --show-error --connect-timeout 1 -I http://localhost:8080 2>/dev/null | grep 'Coyote'`" != "" ];
do
  echo "Waiting for end of Tomcat startup"
  sleep 2
done

tail -100 $TOMCAT/logs/catalina.out
echo "---"
echo "*** Tomcat started ***"



