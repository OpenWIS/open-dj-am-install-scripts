#!/bin/bash

cd /tmp
wget http://apache-mirror.rbc.ru/pub/apache/maven/maven-3/3.3.3/binaries/apache\
-maven-3.3.3-bin.tar.gz

tar -xvzpf apache-maven-3.3.3-bin.tar.gz
mkdir -p /opt/maven/3.3.3
mv apache-maven-3.3.3/* /opt/maven/3.3.3/
ln -s /opt/maven/3.3.3/ /opt/maven/current
