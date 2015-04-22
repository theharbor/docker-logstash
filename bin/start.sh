#!/bin/bash

usage() {
	echo "Usage:" 2>&1
	echo "" 2>&1
	echo "shell              -- Start an interactive shell" 2>&1
	echo "logstash           -- Start logstash" 2>&1
}

ES_HOST=${ES_HOST:-$ES_PORT_9200_TCP_ADDR}
ES_PORT=${ES_PORT:-$ES_PORT_9200_TCP_PORT}

case $1 in
	"shell")
		exec /bin/bash
		;;
	"logstash")
		set -x
		ulimit -n ${LS_OPEN_FILE:-16384}

		for file in /etc/logstash/conf.d/*.conf; do
			sed --in-place --expression 's/\$ES_HOST/${ES_HOST}/g' "$file"
			sed --in-place --expression 's/\$ES_PORT/${ES_PORT}/g' "$file"
		done

		exec runas logstash /opt/logstash/bin/logstash agent  \
			-f /etc/logstash/conf.d/
		;;
	*)
		usage
		exit 1
		;;
esac
