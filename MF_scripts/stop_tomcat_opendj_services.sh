#!/bin/bash

#source deploy_config

#CURRENT=$(pwd)
#cd $CURRENT
TOMCAT=/data/openwis/apache-tomcat-7.0.59

# Stop Tomcat, and wait until Tomcat is stopped
echo "--- Stop Tomcat"
PID=`ps axe | grep tomcat | grep java | awk '{print $1}'`
$TOMCAT/bin/shutdown.sh
while kill -0 $PID 2>/dev/null;
do
  echo "Waiting for end of Tomcat shutdown"
  sleep 2
done

tail -100 $TOMCAT/logs/catalina.out
echo "---"
echo "*** Tomcat stopped ***"
echo "stopping openDJ..."
cd /data/openwis/OpenDJ-2.6.0/bin ; ./stop-ds

echo "*** OpenDJ stopped ***"


