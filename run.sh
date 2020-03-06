#!/bin/bash
set -ex

if [ -f "/root/config/peercast.ini" ]
then
	echo "Running with user configuration: /root/config/peercast.ini"
else
	echo "Running with default configuration"
	cp /root/peercast-yt/peercast.ini.default /root/config/peercast.ini
fi

peercast-yt/peercast

echo "shutdown peercast"
