#!/bin/bash

set -e
set -x

apt-get update
apt-get install --no-install-recommends -y ca-certificates curl

curl --silent --show-error --location https://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb http://packages.elasticsearch.org/logstash/${LOGSTASH_MAJOR_VERSION}/debian stable main" > /etc/apt/sources.list.d/logstash.list

apt-get update
apt-get install --no-install-recommends -y logstash stunnel4
rm -rf /var/lib/apt/lists/*

runas logstash /opt/logstash/bin/plugin install logstash-input-log-courier
