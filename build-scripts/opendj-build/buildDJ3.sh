#!/bin/bash

function build() {
	mvn clean install
	if [ $? -ne 0 ] ; then
		exit 1;
	fi
}

mkdir commons
cd commons
git clone https://stash.forgerock.org/scm/commons/forgerock-parent-public.git
cd forgerock-parent-public
git checkout 1.0.0
build
git checkout 1.2.0
build
git checkout 1.2.1
build
git checkout 2.0.3
build
git checkout 2.0.4
build
cd ..
git clone https://stash.forgerock.org/scm/legacycommons/forgerock-bom-public.git
cd forgerock-bom-public
git checkout forgerock-bom-1.0.0
build
git checkout 3.0.0
build
git checkout 4.0.0
build
git checkout forgerock-bom-4.1.1
build
cd ..
git clone https://stash.forgerock.org/scm/commons/forgerock-build-tools-public.git
cd forgerock-build-tools-public
git checkout 1.0.2
build
git checkout 1.0.3
build
cd ..
git clone https://stash.forgerock.org/scm/legacycommons/forgerock-util-public.git
cd forgerock-util-public
git checkout 3.0.1
build
git checkout 3.0.2
build
cd ..
git clone https://stash.forgerock.org/scm/commons/i18n-framework-public.git
cd i18n-framework-public
git checkout 1.4.1
build
git checkout 1.4.2
build
cd ..
git clone https://stash.forgerock.org/scm/commons/forgerock-guice-public.git
cd forgerock-guice-public
git checkout 1.1.0
# This test can fail due to a test ordering bug in the release
sed -i 's/\(public void shouldGetGuiceModuleServiceLoaderAsDefaultConfiguredGuiceModuleLoader\)/(enabled = false) \1/g' forgerock-guice-core/src/test/java/org/forgerock/guice/core/InjectorConfigurationTest.java
build
cd ..
git clone https://stash.forgerock.org/scm/legacycommons/forgerock-http-framework-public.git
cd forgerock-http-framework-public
git checkout 3.0.0
build
git checkout 3.0.1
build
cd ..
git clone https://stash.forgerock.org/scm/legacycommons/forgerock-rest-public.git
cd forgerock-rest-public
git checkout 4.0.3
build
cd ..
git clone https://stash.forgerock.org/scm/legacycommons/forgerock-audit-public.git
cd forgerock-audit-public
git checkout 4.1.1
build
cd ..
git clone https://stash.forgerock.org/scm/commons/forgerock-persistit-public.git
cd forgerock-persistit-public
git checkout 4.3.1
# The actual release was built with -DskipTests too...
mvn clean install -DskipTests
mkdir ../../opendj
cd ../../opendj
git clone https://stash.forgerock.org/scm/opendj/opendj-sdk-public.git
cd opendj-sdk-public
build
cd ..
git clone https://stash.forgerock.org/scm/opendj/opendj-public.git
cd opendj-public
build
