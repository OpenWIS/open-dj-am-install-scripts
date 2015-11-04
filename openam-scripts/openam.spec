Name:           OpenAM
Version:        12.0.0
Release:        1%{?dist}
Summary:        OpenAM packaging test

Group:          java
License:        GPL
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
mkdir -p /$HOME/openam_tools
cd %{_builddir}/$OPENAM_FOLDER
mvn -DskipTests=true clean install
cd openam-distribution/openam-distribution-ssoadmintools
mvn clean install
cp target/*.zip $HOME/openam_tools/

%install
OPENAM_FOLDER=OpenAM
rm -rf $RPM_BUILD_ROOT;
mkdir -p $RPM_BUILD_ROOT/var/lib/tomcat6/webapps;
cp -r %{_builddir}/$OPENAM_FOLDER/openam-server/target/OpenAM-12.0.0.war $RPM_BUILD_ROOT/var/lib/tomcat6/webapps/openam.war

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)
%config(noreplace) /var/lib/tomcat6/webapps/openam.war

%changelog
