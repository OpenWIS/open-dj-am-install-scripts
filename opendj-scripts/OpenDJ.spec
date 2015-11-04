Name:		OpenDJ
Version:	2.6.0
Release:	1%{?dist}
Summary:	OpenDJ packaging build

Group:		java
License:	GPL
URL:		http://opendj.forgerock.org
Source0:	OpenDJ.tar.gz

BuildRequires:	java-1.7.0-openjdk-devel
Requires:	java-1.7.0-openjdk-devel

%description


%prep
%setup -q -n OpenDJ


%build
./build.sh


%install
rm -rf $RPM_BUILD_ROOT
mkdir -p ${RPM_BUILD_ROOT}/root
cp -r %{_builddir}/OpenDJ/build/package/OpenDJ-2.6.0 $RPM_BUILD_ROOT/root


%clean
rm -rf $RPM_BUILD_ROOT


%files
%defattr(-,root,root,-)
%doc
%config(noreplace)  /root/OpenDJ-2.6.0/*


%changelog

