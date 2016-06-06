Name:           OpenAM
Version:        12.0.0
Release:        1%{?dist}
Summary:        OpenAM packaging test

Group:          java
License:        CDDL + CC-by-nc-nd
URL:            http://openam.forgerock.org/
Source:         openam.tgz

BuildRequires:  java-1.7.0-openjdk-devel
Requires:       java-1.7.0-openjdk-devel

%description
Instalation of OpenAM in order to be used by OpenWIS.

%prep
%setup -q -n OpenAM 

%build
OPENAM_FOLDER=OpenAM
export MAVEN_HOME=/opt/maven/current
export PATH=$PATH:$MAVEN_HOME/bin

cd %{_builddir}/$OPENAM_FOLDER
mvn -DskipTests=true clean install
cd openam-distribution/openam-distribution-ssoadmintools
mvn clean install

%install
OPENAM_FOLDER=OpenAM
rm -rf $RPM_BUILD_ROOT;
getent passwd openwis || useradd -r -d /data/openwis -m openwis
mkdir -p $RPM_BUILD_ROOT/data/openwis/middleware;
mkdir -p $RPM_BUILD_ROOT/data/openwis/apache-tomcat-7.0.59/webapps;
cp -r %{_builddir}/$OPENAM_FOLDER/openam-server/target/OpenAM-12.0.0.war $RPM_BUILD_ROOT/data/openwis/apache-tomcat-7.0.59/webapps/openam.war
cp -r %{_builddir}/$OPENAM_FOLDER/openam-distribution/openam-distribution-ssoadmintools/target/*.zip $RPM_BUILD_ROOT/data/openwis/middleware
cp -r %{_builddir}/$OPENAM_FOLDER/openam-federation/openam-idpdiscovery-war/target/*.war $RPM_BUILD_ROOT/data/openwis/middleware
chown -R openwis:users $RPM_BUILD_ROOT/data/openwis/middleware
mkdir -p $RPM_BUILD_ROOT/data/openwis/openam

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,openwis,users,-)
/data/openwis/apache-tomcat-7.0.59/webapps/openam.war
%dir /data/openwis/middleware
/data/openwis/middleware/*
%dir /data/openwis/openam

%changelog
