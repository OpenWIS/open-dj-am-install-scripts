Name:		OpenDJ
Version:	2.6.0
Release:	1%{?dist}
Summary:	OpenDJ packaging build

Group:		java
License:        CDDL + CC-by-nc-nd
URL:		http://opendj.forgerock.org
Source0:	OpenDJ.tar.gz

BuildRequires:	java-1.7.0-openjdk-devel
Requires:	java-1.7.0-openjdk-devel

%description


%prep
%setup -q -n OpenDJ
getent passwd openwis || useradd -r -d /home/openwis -m openwis

%build
./build.sh


%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/home/openwis
cp -r %{_builddir}/OpenDJ/build/package/OpenDJ-2.6.0 $RPM_BUILD_ROOT/home/openwis
chown -R openwis:openwis $RPM_BUILD_ROOT/home/openwis/OpenDJ-2.6.0


%clean
rm -rf $RPM_BUILD_ROOT


%files
%defattr(-,openwis,openwis,-)
%doc
%dir /home/openwis/OpenDJ-2.6.0
/home/openwis/OpenDJ-2.6.0/*


%changelog

