echo "Uninstall begin..."
TOMCAT_PATH=/data/openwis/apache-tomcat-7.0.59

killall java
rpm -e OpenAM OpenDJ
rm -rf /data/openwis/middleware /data/openwis/openam /data/openwis/OpenDJ-2.6.0
rm -rf $TOMCAT_PATH/webapps/openam
rm -rf $TOMCAT_PATH/webapps/openam.war
rm -rf $TOMCAT_PATH/webapps/idpdiscovery
rm -rf $TOMCAT_PATH/webapps/idpdiscovery.war
rm -rf $TOMCAT_PATH/conf/libIDPDiscoveryConfig.properties
echo "*** Uninstall done ***"
