#!/bin/bash

source deploy_config

export JAVA_HOME=/usr/lib/jvm/java-1.7.0/

CURRENT=$(pwd)
cd $CURRENT

# Check that OpenDJ and openam folder exist
if [ ! -d $OPENDJ_PATH ]
then
  echo "Please install OpenDJ RPM"
  exit 1
fi
if [ ! -d $OPENAM_PATH ]
then
  echo "Please install OpenAM RPM"
  exit 1
fi

# Setup OpenDJ
echo "--- Setup OpenDJ"
$OPENDJ_PATH/setup --cli --propertiesFilePath ./setup_opendj.properties --acceptLicense --no-prompt
$OPENDJ_PATH/bin/ldapmodify -h localhost -p 4444 -D "cn=Directory Manager" -w $OPENAM_PASSWD -X --useSSL -f ./SchemaOpenWIS.ldif

# Start Tomcat, and wait until Tomcat is started
echo "--- Start Tomcat"
$TOMCAT/bin/startup.sh
until [ "`curl --silent --show-error --connect-timeout 1 -I http://localhost:8080 2>/dev/null | grep 'Coyote'`" != "" ];
do
  echo "Waiting for end of Tomcat startup"
  sleep 2
done

# Setup OpenAM
echo "--- Setup OpenAM"
cp spGetToken.jsp $TOMCAT/webapps/openam/

cd SSOConfiguratorTools
java -jar openam-configurator-tool-11.0.0.jar -f setup_openam.properties

if [ ! -d $OPENAM_PATH/SSOAdminTools ]
then
	unzip $OPENAM_PATH/SSOAdminTools-12.0.0.zip -d $OPENAM_PATH/SSOAdminTools
fi
cd $OPENAM_PATH/SSOAdminTools
./setup --acceptLicense -p $OPENAM_INSTALL_PATH

# Create file with openam user passwd
echo "--- Modify IPlanetAMUserService"
PASSWD_FILE=$OPENAM_PATH/SSOAdminTools/openam/bin/passwd
if [ ! -f $PASSWD_FILE ]; then
  touch $PASSWD_FILE
fi
chmod 600 $PASSWD_FILE
echo "$OPENAM_PASSWD" > $PASSWD_FILE
chmod 400 $PASSWD_FILE

cd $OPENAM_PATH/SSOAdminTools/openam/bin
./ssoadm delete-svc -u $OPENAM_USER -f passwd -s iPlanetAMUserService
./ssoadm create-svc -u $OPENAM_USER -f passwd --xmlfile $CURRENT/amUser.xml


# Adapt attrs.properties
echo "--- Update the Data Store Configuration"
cd $CURRENT
sed "s|ldap-server=localhost:1389|ldap-server=$LDAP_SERVER|g" attrs.properties | sed "s|authpw=.*|authpw=$OPENAM_PASSWD|g" | sed "s|psearchbase=.*|psearchbase=$ORGANIZATION|g" | sed "s|organization_name=.*|organization_name=$ORGANIZATION|g" > $OPENAM_PATH/SSOAdminTools/openam/bin/attrs.properties
# Update datastore
cd $OPENAM_PATH/SSOAdminTools/openam/bin
./ssoadm update-datastore -u $OPENAM_USER -f passwd -e / -m OpenDJ -D attrs.properties
cd $CURRENT

# Stop Tomcat, and wait until Tomcat is stopped
echo "--- Stop Tomcat"
PID=`ps axe | grep tomcat | grep java | awk '{print $1}'`
$TOMCAT/bin/shutdown.sh
while kill -0 $PID 2>/dev/null;
do
  echo "Waiting for end of Tomcat shutdown"
  sleep 2
done

# Start deploying OpenWIS IdP
echo "--- Deploy IdpDiscovery"
cd idp
./00-idpdiscovery.sh

# Start Tomcat, and wait until Tomcat is started
echo "--- Start Tomcat"
$TOMCAT/bin/startup.sh
until [ "`curl --silent --show-error --connect-timeout 1 -I http://localhost:8080 2>/dev/null | grep 'Coyote'`" != "" ];
do
  echo "Waiting for end of Tomcat startup"
  sleep 2
done

# Create circle of trust 
echo "--- Create Circle of Trust"
./01-cot.sh

echo "--- Deployment done."

