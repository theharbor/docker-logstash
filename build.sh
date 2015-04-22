#!/bin/sh

exec docker build --force-rm --rm --tag harbor/logstash .
